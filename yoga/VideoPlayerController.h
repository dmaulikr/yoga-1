//
//  VideoPlayerController.h
//  yoga
//
//  Created by renxlin on 14-7-16.
//  Copyright (c) 2014年 任小林. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Vitamio.h"
#import "SC_Model.h"


@interface VideoPlayerController : UIViewController<VMediaPlayerDelegate>

@property(nonatomic,strong)SC_Model *itemMode;

@property(nonatomic,strong)NSArray *sourceArray;
@property(nonatomic,assign)int index;

@property(nonatomic,strong)NSString *titleName;
@property(nonatomic,strong)NSString *audoOrNot;

-(void)videoPause;
-(void)videoStart;

@end
