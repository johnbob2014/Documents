//
//  UTIHelper.h
//  Documents-C11
//
//  Created by BobZhang on 16/6/17.
//  Copyright © 2016年 ZhangBaoGuo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UTIHelper : NSObject

/**
 生成全局唯一标识符 - UTIHelper - Creates a Universally Unique Identifier (UUID) string.
 */
+ (NSString *)createUUID;

+ (NSString *)preferredExtensionForUTI:(NSString *)aUTI;
+ (NSString *)preferredMimeTypeForUTI:(NSString *)aUTI;
+ (NSString *)preferredUTIForExtension:(NSString *)ext;
+ (NSString *)preferredUTIForMIMEType:(NSString *)mime;

+ (NSArray *)allExtensions:(NSString *)aUTI;
+ (NSArray *)allMIMETypes:(NSString *)aUTI;

+ (NSDictionary *)utiDictionary:(NSString *)aUTI;
+ (NSArray *)conformanceArray:(NSString *)aUTI;

+ (NSArray *)allUTIsForExtension:(NSString *)ext;

+ (BOOL)pathPointsTo:(NSString *)path likelyUTIMatch:(CFStringRef)theUTI;

@end
