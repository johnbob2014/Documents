//
//  DocumentWatcher.h
//  Documents-C11
//
//  Created by 张保国 on 16/6/18.
//  Copyright © 2016年 ZhangBaoGuo. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kDocumentChanged	@"DocumentsFolderContentsDidChangeNotification"

/**
 监视文件夹中的文件变化，并提供通知
 通知名称：kDocumentChanged
 */
@interface DocumentWatcher : NSObject

//@property (strong,readonly) NSString *path;

/**
 根据指定路径创建监视器，并开始监控
 */
+ (id)documentWatcherForPath:(NSString *)aPath;

@end
