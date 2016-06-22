//
//  InboxHelper.h
//  Documents-C11
//
//  Created by BobZhang on 16/6/22.
//  Copyright © 2016年 ZhangBaoGuo. All rights reserved.
//

#import <Foundation/Foundation.h>

#define DOCUMENTS_PATH  [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]
#define INBOX_PATH      [DOCUMENTS_PATH stringByAppendingPathComponent:@"Inbox"]

@interface InboxHelper : NSObject
+ (void)checkAndProcessInbox;
@end
