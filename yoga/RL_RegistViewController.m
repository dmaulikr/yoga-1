//
//  RL_RegistViewController.m
//  yoga
//
//  Created by renxlin on 14-7-12.
//  Copyright (c) 2014年 任小林. All rights reserved.
//

#import "RL_RegistViewController.h"
#import "AFNetworking.h"
#import "CountCenterViewController.h"

@interface RL_RegistViewController ()

@end

@implementation RL_RegistViewController
{
    UITextField *_phoneNum;
    UITextField *_verifyNum;
    UITextField *_passWord;
    UITextField *_passWord2;
    UITextField *_name;
    UIButton *verify;
    NSTimer *_timer;
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(BOOL)shouldAutorotate
{
    return NO;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.png"]];

    [[UIApplication sharedApplication] setIdleTimerDisabled:NO];

    UIView *nav;
    if ([[UIDevice currentDevice].systemVersion intValue] >= 7) {
        nav = [self myNavgationBar:CGRectMake(0, 20, self.view.frame.size.width, 44) andTitle:@"注册"];
    }else{
        nav = [self myNavgationBar:CGRectMake(0, 0, self.view.frame.size.width, 44) andTitle:@"注册"];    }
    [self.view addSubview:nav];
    nav.autoresizingMask =
    UIViewAutoresizingFlexibleBottomMargin |
    //    UIViewAutoresizingFlexibleTopMargin |
    UIViewAutoresizingFlexibleHeight |
    UIViewAutoresizingFlexibleLeftMargin |
    UIViewAutoresizingFlexibleRightMargin |
    UIViewAutoresizingFlexibleWidth;
    
    _phoneNum = [[UITextField alloc] init];
    _phoneNum.frame = CGRectMake(10, 70, self.view.frame.size.width- 140, 45);
    _phoneNum.borderStyle = UITextBorderStyleRoundedRect;//设置边框样式
    _phoneNum.placeholder = @"请输入手机号码";
    _phoneNum.clearButtonMode = UITextFieldViewModeAlways;
    _phoneNum.textColor = [UIColor blackColor];
    _phoneNum.backgroundColor = [UIColor whiteColor];
    _phoneNum.delegate = self;
    _phoneNum.tag = 100;
    _phoneNum.returnKeyType = UIReturnKeyDone;
    [self.view addSubview:_phoneNum];
    _phoneNum.autoresizingMask =
    UIViewAutoresizingFlexibleBottomMargin |
    //    UIViewAutoresizingFlexibleTopMargin |
    UIViewAutoresizingFlexibleHeight |
    UIViewAutoresizingFlexibleLeftMargin |
    UIViewAutoresizingFlexibleRightMargin |
    UIViewAutoresizingFlexibleWidth;
    
    verify = [UIButton buttonWithType:UIButtonTypeCustom];
    verify.showsTouchWhenHighlighted = YES;
    verify.frame = CGRectMake(_phoneNum.frame.size.width+20, 70, 110, 45);
    verify.backgroundColor = [UIColor colorWithRed:0.23f green:0.90f blue:1.00f alpha:1.00f];
    [verify setTitle:@"获取验证码" forState:UIControlStateNormal];
    [verify setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    verify.tag = 1;
    [verify addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:verify];
    verify.autoresizingMask =
    UIViewAutoresizingFlexibleBottomMargin |
    //    UIViewAutoresizingFlexibleTopMargin |
    UIViewAutoresizingFlexibleHeight |
    UIViewAutoresizingFlexibleLeftMargin |
    UIViewAutoresizingFlexibleRightMargin |
    UIViewAutoresizingFlexibleWidth;
    
    _verifyNum = [[UITextField alloc] init];
    _verifyNum.frame = CGRectMake(10, 120, self.view.frame.size.width - 20, 45);
    _verifyNum.borderStyle = UITextBorderStyleRoundedRect;//设置边框样式
    _verifyNum.placeholder = @"验证码";
    _verifyNum.clearButtonMode = UITextFieldViewModeAlways;
    _verifyNum.textColor = [UIColor blackColor];
    _verifyNum.backgroundColor = [UIColor whiteColor];
    _verifyNum.delegate = self;
    _verifyNum.tag = 100;
    _verifyNum.returnKeyType = UIReturnKeyDone;
    [self.view addSubview:_verifyNum];
    _verifyNum.autoresizingMask =
    UIViewAutoresizingFlexibleBottomMargin |
    //    UIViewAutoresizingFlexibleTopMargin |
    UIViewAutoresizingFlexibleHeight |
    UIViewAutoresizingFlexibleLeftMargin |
    UIViewAutoresizingFlexibleRightMargin |
    UIViewAutoresizingFlexibleWidth;
    
    _passWord = [[UITextField alloc] init];
    _passWord.frame = CGRectMake(10, 170, self.view.frame.size.width - 20, 45);
    _passWord.borderStyle = UITextBorderStyleRoundedRect;//设置边框样式
    _passWord.placeholder = @"请输入密码";
    _passWord.clearButtonMode = UITextFieldViewModeAlways;
    _passWord.textColor = [UIColor blackColor];
    _passWord.secureTextEntry = YES;
    _passWord.backgroundColor = [UIColor whiteColor];
    _passWord.delegate = self;
    _passWord.tag = 100;
    _passWord.returnKeyType = UIReturnKeyDone;
    [self.view addSubview:_passWord];
    _passWord.autoresizingMask =
    UIViewAutoresizingFlexibleBottomMargin |
    //    UIViewAutoresizingFlexibleTopMargin |
    UIViewAutoresizingFlexibleHeight |
    UIViewAutoresizingFlexibleLeftMargin |
    UIViewAutoresizingFlexibleRightMargin |
    UIViewAutoresizingFlexibleWidth;
    
    _passWord2 = [[UITextField alloc] init];
    _passWord2.frame = CGRectMake(10, 220, self.view.frame.size.width - 20, 45);
    _passWord2.borderStyle = UITextBorderStyleRoundedRect;//设置边框样式
    _passWord2.placeholder = @"请确认密码";
    _passWord2.clearButtonMode = UITextFieldViewModeAlways;
    _passWord2.textColor = [UIColor blackColor];
    _passWord2.secureTextEntry = YES;
    _passWord2.backgroundColor = [UIColor whiteColor];
    _passWord2.delegate = self;
    _passWord2.tag = 100;
    _passWord2.returnKeyType = UIReturnKeyDone;
    [self.view addSubview:_passWord2];
    _passWord2.autoresizingMask =
    UIViewAutoresizingFlexibleBottomMargin |
    //    UIViewAutoresizingFlexibleTopMargin |
    UIViewAutoresizingFlexibleHeight |
    UIViewAutoresizingFlexibleLeftMargin |
    UIViewAutoresizingFlexibleRightMargin |
    UIViewAutoresizingFlexibleWidth;

    
    _name = [[UITextField alloc] init];
    _name.frame = CGRectMake(10, 270, self.view.frame.size.width - 20, 45);
    _name.borderStyle = UITextBorderStyleRoundedRect;//设置边框样式
    _name.placeholder = @"请输入姓名";
    _name.clearButtonMode = UITextFieldViewModeAlways;
    _name.textColor = [UIColor blackColor];
    _name.backgroundColor = [UIColor whiteColor];
    _name.delegate = self;
    _name.tag = 100;
    _name.returnKeyType = UIReturnKeyDone;
    [self.view addSubview:_name];
    _name.autoresizingMask =
    UIViewAutoresizingFlexibleBottomMargin |
    //    UIViewAutoresizingFlexibleTopMargin |
    UIViewAutoresizingFlexibleHeight |
    UIViewAutoresizingFlexibleLeftMargin |
    UIViewAutoresizingFlexibleRightMargin |
    UIViewAutoresizingFlexibleWidth;
    
    UIButton *assign = [UIButton buttonWithType:UIButtonTypeCustom];
    assign.frame = CGRectMake(10, 320, self.view.frame.size.width - 20, 45);
    assign.backgroundColor = [UIColor colorWithRed:0.23f green:0.90f blue:1.00f alpha:1.00f];
    [assign setTitle:@"注册" forState:UIControlStateNormal];
    assign.showsTouchWhenHighlighted = YES;
    [assign setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    assign.tag = 2;
    [assign addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:assign];
    assign.autoresizingMask =
    UIViewAutoresizingFlexibleBottomMargin |
    //    UIViewAutoresizingFlexibleTopMargin |
    UIViewAutoresizingFlexibleHeight |
    UIViewAutoresizingFlexibleLeftMargin |
    UIViewAutoresizingFlexibleRightMargin |
    UIViewAutoresizingFlexibleWidth;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_phoneNum resignFirstResponder];
    [_passWord resignFirstResponder];
    [_passWord2 resignFirstResponder];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
-(void)btnClick:(UIButton *)btn
{
    //NSLog(@"click %@",btn);
    if (btn.tag == 1) {
        //获取验证码：
        if (_timer == nil) {

            AFHTTPRequestOperationManager *regsieMg = [AFHTTPRequestOperationManager manager];
            regsieMg.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
            
            NSString *url = [NSString stringWithFormat:@"%@%@",GETVERTIFY_URL,_phoneNum.text];
            NSLog(@"%@",url);
            [regsieMg GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
               // NSLog(@"success:\n%@",[responseObject objectForKey:@"msg"]);
                if ([[responseObject objectForKey:@"msg"] isEqualToString:@"ok"]) {
                    
                    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerTick) userInfo:nil repeats:YES];
                    btn.alpha = 0.5;
                    btn.userInteractionEnabled = NO;
                    
                    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"验证码已发送" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    [alert show];
                }else{
                    NSString *message = [NSString stringWithFormat:@"%@",[responseObject objectForKey:@"msg"]];
                    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    [alert show];
                }
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                NSLog(@"Failed:%@",error.localizedDescription);
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"验证码发送失败" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }];
        }
    }else if(btn.tag == 2){
        //注册
        if ([_phoneNum.text length] == 0) {
            [self animateIncorrectMessage:_phoneNum];

            [SVProgressHUD showErrorWithStatus:@"请输入手机号！"];
            return;
        }
        
        if ([_verifyNum.text length] == 0) {
            [self animateIncorrectMessage:_verifyNum];
            [SVProgressHUD showErrorWithStatus:@"请输入验证码！"];
            return;
        }
        if ([_passWord.text length] == 0) {
            [self animateIncorrectMessage:_passWord];
            [SVProgressHUD showErrorWithStatus:@"请输入密码！" ];
            return;
        }
        
        if (![_passWord.text isEqualToString:_passWord2.text]) {
            [SVProgressHUD showErrorWithStatus:@"两次输入密码不一致！"];
            [self animateIncorrectMessage:_passWord2];
            return;
        }
        
        if (![_name.text isEqualToString:_name.text]) {
            [SVProgressHUD showErrorWithStatus:@"请输入姓名！"];
            [self animateIncorrectMessage:_name];
            return;
        }
        
        if ([_passWord.text length]<6) {
            [SVProgressHUD showErrorWithStatus:@"密码长度必须大于6！"];
            [self animateIncorrectMessage:_passWord];
            [self animateIncorrectMessage:_passWord2];
            return;
        }

        AFHTTPRequestOperationManager *registM = [AFHTTPRequestOperationManager manager];
        NSDictionary *paramterDic = [NSDictionary dictionaryWithObjectsAndKeys:_phoneNum.text,@"mobile",
                                     _passWord.text,@"password",
                                     _verifyNum.text,@"code",
                                     _name.text,@"email",nil];
        registM.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
        
        [registM GET:[NSString stringWithFormat:@"%@mobile=%@&password=%@&code=%@&name=%@%@",REGIST_URL,_phoneNum.text,_passWord.text,_verifyNum.text,_name.text,Kversion] parameters:paramterDic success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            NSLog(@"%@",responseObject);
            if([[responseObject objectForKey:@"code"] intValue] == 200)
            {
                
                
                Kdefaults;
                NSArray*arr=@[_phoneNum.text,_passWord.text];
                [defaults setObject:arr forKey:@"accountAndPassword"];
                [defaults synchronize];
                
                UserInfo *info = [UserInfo shareUserInfo];
                info.userDict = [responseObject objectForKey:@"data"];
                
                
                UserInfo *userInfo = [UserInfo shareUserInfo];
                userInfo.token = [[responseObject objectForKey:@"data"] objectForKey:@"token"];
                userInfo.userName = [[responseObject objectForKey:@"data"] objectForKey:@"username"];
                
                
                CountCenterViewController *countCenter = [[CountCenterViewController alloc]init];
                countCenter.regStr = @"regStr";
                [self.navigationController pushViewController:countCenter animated:YES];
                
            }else
            {
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:[NSString stringWithFormat:@"%@",[responseObject objectForKey:@"msg"]] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                
                [alert show];
                
            }
            
            
            
//            NSLog(@"success:\n%@",responseObject);
//             NSLog(@"%@",[NSString stringWithFormat:@"%@mobile=%@&password=%@&code=%@&email=%@",REGIST_URL,_phoneNum.text,_passWord.text,_verifyNum.text,_email.text]);
//            NSLog(@"%@",[responseObject objectForKey:@"msg"]);
//            if ([[[responseObject objectForKey:@"data"] objectForKey:@"username"]isEqualToString:_phoneNum.text]) {
//                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:[responseObject objectForKey:@"msg"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//                [alert show];
//            }else{
//                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:[NSString stringWithFormat:@"%@",[responseObject objectForKey:@"msg"]] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//                [alert show];
//            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
           // NSLog(@"Failed:%@",error);
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"注册失败" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }];
    }
}
-(void)timerTick
{
    static int second = 60;
    [verify setTitle:[NSString stringWithFormat:@"重新获取(%d)", --second ] forState:UIControlStateNormal];
    if (second == 0) {
        second = 60;
        [verify setTitle:@"发送验证码" forState:UIControlStateNormal];
        [_timer invalidate];
        verify.userInteractionEnabled = YES;
        _timer = nil;
        verify.alpha = 1;
        verify.selected = NO;
    }
}

-(UIView *)myNavgationBar:(CGRect)rect andTitle:(NSString *)tit
{
    UIView *view = [[UIView alloc] initWithFrame:rect];
    view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"title.png"]];
    
    //back button
    UIButton *back = [UIButton buttonWithType:UIButtonTypeCustom];
    back.frame = CGRectMake(2, 0, 40, view.frame.size.height);
    [back addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [back setImage:[UIImage imageNamed:@"title_icon.png"] forState:UIControlStateNormal];
    [view addSubview:back];
    
    //title
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(back.frame.size.width, 0, 70, rect.size.height)];
    title.text = tit;
    title.backgroundColor = [UIColor clearColor];
    title.textColor = [UIColor colorWithRed:0.92f green:0.92f blue:0.92f alpha:1.00f];
    [view addSubview:title];
    return view;
}
-(void)backBtnClick
{
    [self.navigationController popViewControllerAnimated:YES];
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

//账户未输入动画
- (void)animateIncorrectMessage:(UIView *)view
{
    
    CGAffineTransform moveRight = CGAffineTransformTranslate(CGAffineTransformIdentity, 8, 0);
    CGAffineTransform moveLeft = CGAffineTransformTranslate(CGAffineTransformIdentity, -8, 0);
    CGAffineTransform resetTransform = CGAffineTransformTranslate(CGAffineTransformIdentity, 0, 0);
    
    [UIView animateWithDuration:0.1 animations:^{
        view.transform = moveLeft;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.1 animations:^{
            view.transform = moveRight;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.1 animations:^{
                view.transform = moveLeft;
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.1 animations:^{
                    view.transform = moveRight;
                } completion:^(BOOL finished) {
                    [UIView animateWithDuration:0.1 animations:^{
                        view.transform = resetTransform;
                    }];
                }];
            }];
        }];
    }];
}


@end
