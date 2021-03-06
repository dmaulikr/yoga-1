//
//  PortraitNavigationController.m
//  yoga
//
//  Created by renxlin on 14-8-11.
//  Copyright (c) 2014年 任小林. All rights reserved.
//

#import "PortraitNavigationController.h"
#import "VideoPlayerController.h"
#import "RL_TVViewController.h"

@interface PortraitNavigationController ()

@end

@implementation PortraitNavigationController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return toInterfaceOrientation == UIInterfaceOrientationPortrait;
}

- (BOOL)shouldAutorotate
{
//    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
//        return NO;
//    }
    
    if ([self.topViewController isKindOfClass:[VideoPlayerController class]]) {
        if ([((VideoPlayerController *)self.topViewController).titleName isEqualToString:@"视频点播"]){
            return YES;
        }
    } else  if ([self.topViewController isKindOfClass:[RL_TVViewController class]]) {
        return YES;
    }
    return NO;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAll;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
