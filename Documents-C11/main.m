//
//  main.m
//  Documents-C11
//
//  Created by BobZhang on 16/6/17.
//  Copyright © 2016年 BobZhang. All rights reserved.
//

//#define TBVC_01
//#define TBVC_03
//#define TBVC_04
//#define TBVC_05
//#define TBVC_06
#define TBVC_07

#import <UIKit/UIKit.h>
#import "Utility.h"
#import "TestBedViewController.h"

#ifdef TBVC_07
#import "InboxHelper.h"
#endif

@interface TestBedAppDelegate : UIResponder <UIApplicationDelegate>
@property (strong,nonatomic) UIWindow *window;
@end

@implementation TestBedAppDelegate

-(BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.tintColor = COOKBOOK_PURPLE_COLOR;
    
#ifdef TBVC_01
    TBVC_01_UTI_Utilities *tbvc = [[TBVC_01_UTI_Utilities alloc]init];
#endif
    
#ifdef TBVC_03
    TBVC_03_Document_Monitoring *tbvc = [[TBVC_03_Document_Monitoring alloc]init];
#endif
    
#ifdef TBVC_04
    TBVC_04_UIActivityViewController *tbvc = [[TBVC_04_UIActivityViewController alloc]init];
#endif

#ifdef TBVC_05
    TBVC_05_QuickLook_QLPreviewController *tbvc = [[TBVC_05_QuickLook_QLPreviewController alloc]init];
#endif
    
#ifdef TBVC_06
    TBVC_06_UIDocumentInteractionController *tbvc = [[TBVC_06_UIDocumentInteractionController alloc]init];
#endif
    
#ifdef TBVC_07
    TBVC_07_Receive_Process_CustomType_Documents *tbvc = [[TBVC_07_Receive_Process_CustomType_Documents alloc] init];
#endif
    
    tbvc.edgesForExtendedLayout = UIRectEdgeNone;
    UINavigationController *rootVC = [[UINavigationController alloc]initWithRootViewController:tbvc];
    
    self.window.rootViewController = rootVC;
    [self.window makeKeyAndVisible];
    return YES;
}

#ifdef TBVC_07
- (void)applicationDidBecomeActive:(UIApplication *)application{
    [InboxHelper checkAndProcessInbox];
    TBVC_07_Receive_Process_CustomType_Documents *tbvc = (TBVC_07_Receive_Process_CustomType_Documents *) (((UINavigationController *)self.window.rootViewController).topViewController);
    [tbvc scanDocs];
}
#endif
@end

int main(int argc, char * argv[]) {
    @autoreleasepool {
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([TestBedAppDelegate class]));
    }
}
