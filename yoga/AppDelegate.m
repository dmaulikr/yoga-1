//
//  AppDelegate.m
//  yoga
//
//  Created by renxlin on 14-7-10.
//  Copyright (c) 2014年 任小林. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"
#import "PortraitNavigationController.h"
#import "VideoPlayerController.h"
#import "RL_FMViewController.h"
#import "RL_TVViewController.h"


#import "UMSocial.h"
#import "UMSocialQQHandler.h"
#import "UMSocialSinaHandler.h"
#import "UMSocialTencentWeiboHandler.h"
#import "UMSocialWechatHandler.h"
#import "InAppRageIAPHelper.h"
@implementation AppDelegate
{
    UIScrollView * launchScrollView;
    UIPageControl *pageControl;
}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    DataBase *shareDB = [DataBase sharedDataBase];
    [shareDB createDataBase];
    
    // Override  point for customization after application launch.
    //友盟分享：
    [UMSocialConfig setSupportedInterfaceOrientations:UIInterfaceOrientationMaskAll];
    
    //设置支持没有客户端情况下使用SSO授权
    [UMSocialQQHandler setSupportWebView:YES];

    
    [UMSocialData setAppKey:@"53d4c20456240b2af4103c08"];
    
    //    //打开新浪微博的SSO开关
        [UMSocialSinaHandler openSSOWithRedirectURL:@"http://sns.whalecloud.com/sina2/callback"];
    //
    //    //打开腾讯微博SSO开关，设置回调地址
    [UMSocialTencentWeiboHandler openSSOWithRedirectUrl:@"http://sns.whalecloud.com/tencent2/callback"];
    
    //设置分享到QQ空间的应用Id，和分享url 链接
    [UMSocialQQHandler setQQWithAppId:@"1101943503" appKey:@"EMI0UWJ3iE6LHz7G" url:@"http://www.chinayogaonline.com/app"];
    
    [UMSocialWechatHandler setWXAppId:@"wx135514f2491ecfe0" url:@"http://www.chinayogaonline.com/app"];
    
    
    
    //如果你要支持不同的屏幕方向，需要这样设置，否则在iPhone只支持一个竖屏方向
    [UMSocialConfig setSupportedInterfaceOrientations:UIInterfaceOrientationMaskAll];
    
   // [UMSocialData defaultData].extConfig.qqData.qqMessageType = UMSocialQQMessageTypeDefault; //设置QQ分享纯图片，默认分享图文消息
//    [UMSocialData defaultData].extConfig.wechatSessionData.wxMessageType = UMSocialWXMessageTypeWeb;  //设置微信好友分享纯图片
//    [UMSocialData defaultData].extConfig.wechatTimelineData.wxMessageType = UMSocialWXMessageTypeWeb;  //设置微信朋友圈分享纯图片
//    

  
     [[SKPaymentQueue defaultQueue] addTransactionObserver:[InAppRageIAPHelper sharedHelper]];
    
    //判断是否首次启动
    NSUserDefaults *usrDef = [NSUserDefaults standardUserDefaults];
    BOOL isFirst = [usrDef boolForKey:@"isFirst"];
    if (!isFirst) {
        //NSLog(@"第一次启动应用");
        [usrDef setBool:YES forKey:@"isFirst"];
        [usrDef synchronize];
    //加入引导界面
        launchScrollView = [[UIScrollView alloc] init];
        launchScrollView.frame = [UIScreen mainScreen].bounds;
        launchScrollView.contentSize = CGSizeMake(3*[UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        launchScrollView.pagingEnabled = YES;
        launchScrollView.bounces = NO;
        launchScrollView.delegate = self;
        [self.window addSubview:launchScrollView];

        for (int i = 0; i < 3; i++) {
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i * [UIScreen mainScreen].bounds.size.width, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
           // NSLog(@"%@",[UIDevice currentDevice].model);
            if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
                if (MAX([UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.height) < 500) {
                    imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"start%d_320x480.jpg",i+1]];
                    
                }else
                    imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"开机画面0%d_640x1136.jpg",i+1]];
            }else if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad){
                imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"开机画面0%d_1536x2048.jpg",i+1]];
            }
            
            [launchScrollView addSubview:imageView];
            
            if (i == 2) {
                UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
                btn.frame = CGRectMake((imageView.frame.size.width-80)/2, imageView.frame.size.height * 3 / 4, 80, 30);
                btn.layer.cornerRadius = 4;
                btn.backgroundColor = [UIColor colorWithRed:0.96f green:0.73f blue:0.23f alpha:1.00f];
                [btn addTarget:self action:@selector(StartBtnClick) forControlEvents:UIControlEventTouchUpInside];
                [btn setTitle:@"开始体验" forState:UIControlStateNormal];
                [imageView addSubview:btn];
                imageView.userInteractionEnabled = YES;
            }
        }
        pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/3, [UIScreen mainScreen].bounds.size.height * 4/5, [UIScreen mainScreen].bounds.size.width/3, 20)];
        pageControl.numberOfPages = 3;
        pageControl.currentPage = 0;
        [pageControl addTarget:self action:@selector(pageTurn:) forControlEvents:UIControlEventValueChanged];
        [self.window addSubview:pageControl];
        
    }else{
        [self StartBtnClick];
    }
    
    

    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

-(void)pageTurn:(UIPageControl *)pageCotr
{
    [launchScrollView setContentOffset:CGPointMake(pageCotr.currentPage * launchScrollView.frame.size.width, 0)];
}
- (void)scrollViewDidScroll:(UIScrollView *)sender {
    
    int page = sender.contentOffset.x / [UIScreen mainScreen].bounds.size.width;
    
    pageControl.currentPage = page;
    
}
-(void)StartBtnClick
{
   // NSLog(@"start");
    [launchScrollView removeFromSuperview];
    [pageControl removeFromSuperview];
    MainViewController *mvc = [[MainViewController alloc] init];
    
    PortraitNavigationController *nav = [[PortraitNavigationController alloc]initWithRootViewController:mvc];
    
    self.window.rootViewController = nav;

}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    
   // NSLog(@"into background");
    UINavigationController *rootVc = (UINavigationController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    if ([rootVc isKindOfClass:[PortraitNavigationController class]]) {
        //NSLog(@"yes");
        UIViewController *vc = rootVc.topViewController;
        if ([vc isKindOfClass:[VideoPlayerController class]]) {
            
            if ([((VideoPlayerController *)vc).titleName isEqualToString:@"音频点播"]) {
                //NSLog(@"音频点播");
            }else{
                //NSLog(@"视频点播");
                [((VideoPlayerController *)vc) videoPause];
            }
        }else if ([vc isKindOfClass:[RL_TVViewController class]]){
            [((RL_TVViewController *)vc) pauseIntoBackground];

        }
    }
    
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
   // NSLog(@"into foreground");
    
    UINavigationController *rootVc = (UINavigationController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    if ([rootVc isKindOfClass:[PortraitNavigationController class]]) {
        //NSLog(@"yes");
        UIViewController *vc = rootVc.topViewController;
        if ([vc isKindOfClass:[VideoPlayerController class]]) {
            
//            if ([((VideoPlayerController *)vc).titleName isEqualToString:@"音频点播"]) {
//                //NSLog(@"音频点播");
//            }else{
//                NSLog(@"视频点播");
                [((VideoPlayerController *)vc) videoStart];
//            }
        }else if ([vc isKindOfClass:[RL_FMViewController class]]){
            [(RL_FMViewController *)vc startIntoForground];
        }else if ([vc isKindOfClass:[RL_TVViewController class]]){
            [(RL_TVViewController *)vc startIntoForground];
        }
    }

}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
//独立客户端回调函数
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    
    //NSLog(@"1233131313131313");
	
	
	return YES || [UMSocialSnsService handleOpenURL:url];
    

}
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
   
    return YES || [UMSocialSnsService handleOpenURL:url];
}



@end
