//
//  InboxHelper.m
//  Documents-C11
//
//  Created by BobZhang on 16/6/22.
//  Copyright © 2016年 ZhangBaoGuo. All rights reserved.
//

#import "InboxHelper.h"

@implementation InboxHelper
+ (NSString *)findAlternativeNameForPath: (NSString *) path
{
    NSString *ext = path.pathExtension;
    NSString *base = [path stringByDeletingPathExtension];
    
    for (int i = 1; i < 999; i++) // we have limits here
    {
        NSString *dest = [NSString stringWithFormat:@"%@-%d.%@", base, i, ext];
        if (![[NSFileManager defaultManager] fileExistsAtPath:dest])
            return dest;
    }
    
    NSLog(@"Exhausted possible names for file %@. Bailing.", path.lastPathComponent);
    return nil;
}

+ (void)checkAndProcessInbox{
    NSError *error;
    BOOL success;
    BOOL isDir;
    NSFileManager *defaultFM = [NSFileManager defaultManager];
    
    // Does the inbox folder exist? If not, we're done here.
    if (![defaultFM fileExistsAtPath:INBOX_PATH isDirectory:&isDir]) return;
    
    // It exists. Is it a dir?
    if (!isDir){
        // 如果 Inbox 不是文件夹而是一个文件，那么删除这个文件
        if (![defaultFM removeItemAtPath:INBOX_PATH error:&error]){
            // 如果删除失败，返回
            NSLog(@"Error deleting Inbox file (not directory): %@", error.localizedFailureReason);
            return;
        }
    }
    
    NSArray *fileArray = [defaultFM contentsOfDirectoryAtPath:INBOX_PATH error:&error];
    if (!fileArray) {
        NSLog(@"Error reading contents of Inbox: %@", error.localizedFailureReason);
        return;
    }
    
    NSUInteger initialCount = fileArray.count;
    
    for (NSString *fileName in fileArray) {
        NSString *sourcePath = [INBOX_PATH stringByAppendingPathComponent:fileName];
        NSString *destPath = [DOCUMENTS_PATH stringByAppendingPathComponent:fileName];
        
        if ([defaultFM fileExistsAtPath:destPath]) {
            destPath = [InboxHelper findAlternativeNameForPath:destPath];
        }
        
        if (!destPath) {
            NSLog(@"Error. File name conflict could not be resolved for %@. Bailing", fileName);
            continue;
        }
        
        if (![defaultFM moveItemAtPath:sourcePath toPath:destPath error:&error]) {
            NSLog(@"Error moving file %@ to Documents from Inbox: %@", fileName, error.localizedFailureReason);
            continue;
        }
    }
    
    // Inbox should now be empty
    fileArray = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:INBOX_PATH error:&error];
    if (!fileArray)
    {
        NSLog(@"Error reading contents of Inbox: %@", error.localizedFailureReason);
        return;
    }
    
    if (fileArray.count)
    {
        NSLog(@"Error clearing out inbox. %d items still remain", fileArray.count);
        return;
    }
    
    // Remove the inbox
    success = [[NSFileManager defaultManager] removeItemAtPath:INBOX_PATH error:&error];
    if (!success)
    {
        NSLog(@"Error removing inbox: %@", error.localizedFailureReason);
        return;
    }
    
    NSLog(@"Moved %d items from the Inbox to the Documents folder", initialCount);
}

@end
