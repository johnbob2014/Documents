//
//  UTIHelper.m
//  Documents-C11
//
//  Created by BobZhang on 16/6/17.
//  Copyright © 2016年 ZhangBaoGuo. All rights reserved.
//

#import "UTIHelper.h"
@import MobileCoreServices;

@implementation UTIHelper

+ (NSString *)createUUID{
    CFUUIDRef theUUID = CFUUIDCreate(kCFAllocatorDefault);
    NSString *uuidString = (__bridge_transfer NSString *)CFUUIDCreateString(NULL, theUUID);
    CFRelease(theUUID);
    return uuidString;
}

+ (NSString *)preferredExtensionForUTI:(NSString *)aUTI{
    CFStringRef theUTI = (__bridge CFStringRef) aUTI;
    CFStringRef results = UTTypeCopyPreferredTagWithClass(theUTI, kUTTagClassFilenameExtension);
    return (__bridge_transfer NSString*) results;
}

+ (NSString *)preferredMimeTypeForUTI:(NSString *)aUTI{
    CFStringRef theUTI = (__bridge CFStringRef) aUTI;
    CFStringRef results = UTTypeCopyPreferredTagWithClass(theUTI, kUTTagClassMIMEType);
    return (__bridge_transfer NSString*) results;
}

+ (NSString *)preferredUTIForExtension:(NSString *)ext{
    NSString *theUTI = (__bridge_transfer NSString *) UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, (__bridge CFStringRef) ext, NULL);
    return theUTI;
}

+ (NSString *)preferredUTIForMIMEType:(NSString *)mime{
    NSString *theUTI = (__bridge_transfer NSString *) UTTypeCreatePreferredIdentifierForTag(kUTTagClassMIMEType, (__bridge CFStringRef) mime, NULL);
    return theUTI;
}

+ (NSDictionary *)utiDictionary:(NSString *)aUTI{
    NSDictionary *dic = (__bridge_transfer NSDictionary *) UTTypeCopyDeclaration((__bridge CFStringRef) aUTI);
    return dic;
}

+ (NSArray *)uniqueArray:(NSArray *)anArray{
    NSMutableArray *copiedArray = [NSMutableArray arrayWithArray:anArray];
    for (id object in anArray) {
        [copiedArray removeObjectIdenticalTo:object];
        [copiedArray addObject:object];
    }
    return [NSArray arrayWithArray:copiedArray];
}

+ (NSArray *)conformanceArray:(NSString *)aUTI{
    NSMutableArray *results = [NSMutableArray arrayWithObject:aUTI];
    NSDictionary *dic = [UTIHelper utiDictionary:aUTI];
    id conforms = dic[(__bridge NSString*) kUTTypeConformsToKey];
    
    // No conformance
    if (!conforms) return results;
    
    // Single conformance
    if ([conforms isKindOfClass:[NSString class]]) {
        [results addObjectsFromArray:[UTIHelper conformanceArray:conforms]];
    }
    
    // Iterate through multiple conformance
    if ([conforms isKindOfClass:[NSArray class]]) {
        for (NSString *eachUTI in (NSArray *)conforms) {
            [results addObjectsFromArray:[UTIHelper conformanceArray:eachUTI]];
        }
        return [UTIHelper uniqueArray:results];
    }
    
    // Just return the one-item array
    return results;
}

+ (NSArray *)allExtensions:(NSString *)aUTI{
    NSMutableArray *results = [NSMutableArray array];
    NSArray *conformance = [UTIHelper conformanceArray:aUTI];
    
    for (NSString *eachUTI in conformance) {
        NSDictionary *dic = [UTIHelper utiDictionary:eachUTI];
        NSDictionary *extDic = dic[(__bridge NSString*) kUTTypeTagSpecificationKey];
        id fileTypes = extDic[(__bridge NSString *) kUTTagClassFilenameExtension];
        
        if ([fileTypes isKindOfClass:[NSArray class]]) {
            [results addObjectsFromArray:(NSArray *) fileTypes];
        }else if ([fileTypes isKindOfClass:[NSString class]]){
            [results addObject:(NSString *) fileTypes];
        }
    }
    
    return [UTIHelper uniqueArray:results];
}

+ (NSArray *)allMIMETypes:(NSString *)aUTI{
    NSMutableArray *results = [NSMutableArray array];
    NSArray *conformance = [UTIHelper conformanceArray:aUTI];
    
    for (NSString *eachUTI in conformance) {
        NSDictionary *dic = [UTIHelper utiDictionary:eachUTI];
        NSDictionary *extDic = dic[(__bridge NSString*) kUTTypeTagSpecificationKey];
        id fileTypes = extDic[(__bridge NSString *) kUTTagClassMIMEType];
        
        if ([fileTypes isKindOfClass:[NSArray class]]) {
            [results addObjectsFromArray:(NSArray *) fileTypes];
        }else if ([fileTypes isKindOfClass:[NSString class]]){
            [results addObject:(NSString *) fileTypes];
        }
    }
    
    return [UTIHelper uniqueArray:results];
}

+ (NSArray *)allUTIsForExtension:(NSString *)ext{
    NSArray *array = (__bridge_transfer NSArray *) UTTypeCreateAllIdentifiersForTag(kUTTagClassFilenameExtension, (__bridge CFStringRef) ext, NULL);
    return array;
}

+ (BOOL)pathPointsTo:(NSString *)path likelyUTIMatch:(CFStringRef)theUTI{
    NSString *preferredUTI = [UTIHelper preferredUTIForExtension:path.pathExtension];
    return (UTTypeConformsTo((__bridge CFStringRef) preferredUTI, theUTI));
}

// mimeTypesDictionary 用于存放 extension : mimeType 键值对
static NSDictionary *mimeTypesDictionary;

+ (void)initialMimeTypesDictionary{
    NSError *error;
    NSString *mimeFilePath = [[NSBundle mainBundle] pathForResource:@"ApacheMIMETypes" ofType:@"txt"];
    NSString *mimeFileContent = [NSString stringWithContentsOfFile:mimeFilePath encoding:NSUTF8StringEncoding error:&error];
    if (!mimeFileContent) {
        NSLog(@"Could not read in mime type file : %@",error.localizedFailureReason);
        return;
    }
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    NSArray *lineArray = [mimeFileContent componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
    for (NSString *eachLine in lineArray) {
        NSString *line = [eachLine stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        // 如果长度太小，放弃解析此行
        if (line.length < 2) continue;
        // 如果此行以 # 开头，放弃解析此行，比如：
        // # application/1d-interleaved-parityfec
        if ([line hasPrefix:@"#"]) continue;
        
        // 根据 Tab 字符拆分此行，比如：
        // application/gpx+xml				gpx
        NSArray *itemArray = [line componentsSeparatedByString:@"\t"];
        // 如果数据不完整，放弃解析此行
        if (itemArray.count < 2) continue;
        
        // 本行拥有完整数据，开始解析
        // mimeType唯一，表示类型
        NSString *mimeType = itemArray.firstObject;
        // 一种mimeType可能包括多种extension，比如：
        // application/inkml+xml				ink inkml
        NSArray *extensionArray = [itemArray.lastObject componentsSeparatedByString:@" "];
        for (NSString *extension in extensionArray) {
            // 以extension为键、以mimeType为值存入字典
            dic[extension] = mimeType;
        }
    }
    
    mimeTypesDictionary = dic;
}

+ (NSString *)mimeForExtension:(NSString *)ext{
    if (!mimeTypesDictionary) {
        [UTIHelper initialMimeTypesDictionary];
    }
    
    if (mimeTypesDictionary)
        return mimeTypesDictionary[[ext lowercaseString]];
    else
        return nil;
}

@end
