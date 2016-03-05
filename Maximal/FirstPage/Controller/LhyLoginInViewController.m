


//
//  LhyLoginInViewController.m
//  Maximal
//
//  Created by 李宏远 on 15/11/24.
//  Copyright © 2015年 李宏远. All rights reserved.
//

#import "LhyLoginInViewController.h"
#import "LhyRegistViewController.h"
#import "LhyMainViewController.h"
#import "LhyUserDataHanlder.h"
#import "LhyUserInfoModel.h"
#import "MBProgressHUD.h"
#import "AppDelegate.h"


@interface LhyLoginInViewController ()<RegistViewController, UITextFieldDelegate>

@property(nonatomic, retain)UIButton *buttonReturn;

@property(nonatomic, retain)UILabel *labelUserId;
@property(nonatomic, retain)UILabel *labelPassword;
@property(nonatomic, retain)UITextField *textfieldUserId;
@property(nonatomic, retain)UITextField *textfieldPassWord;
@property(nonatomic, retain)UIButton *buttonLoginIn;
@property(nonatomic, retain)UIButton *buttonRegist;


@end

@implementation LhyLoginInViewController

- (void)dealloc {
    
    
    [_pageType release];
    
    [_labelPassword release];
    [_labelUserId release];
    [_textfieldPassWord release];
    [_textfieldUserId release];
    [super dealloc];
    
}

/* 背景图片 */
- (void)createBGView {
    
    UIImageView *bgView = [[UIImageView alloc] init];
    bgView.frame = self.view.bounds;
    [self.view addSubview:bgView];
    bgView.backgroundColor = [UIColor colorWithRed:0.956 green:1.000 blue:0.951 alpha:1.000];
    bgView.image = [UIImage imageNamed:@"denglu"];
    bgView.alpha = 1;
    [bgView release];
}

#pragma mark - 页面加载完成
- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self createBGView];
    [self createButtonReturn];
    [self createLabel];
    [self createTextField];
    [self createButtonLoginIn];
    [self createButtonRegist];
    
    /* 添加手势 */
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleResignKeyboard)];
    [self.view addGestureRecognizer:tap];
    [tap release];
    
}
- (void)handleResignKeyboard {
    
    [self.view endEditing:YES];
}

#pragma mark - 创建label
- (void)createLabel {
    
    self.labelUserId = [[UILabel alloc] initWithFrame:CGRectMake(70, 230, 60, 20)];
    [self.view addSubview:self.labelUserId];
    self.labelUserId.text = @"用户名:";
    self.labelUserId.textColor = [UIColor whiteColor];
    [self.labelUserId release];
    
    self.labelPassword = [[UILabel alloc] initWithFrame:CGRectMake(70, self.labelUserId.frame.origin.y + 50, 60, 20)];
    [self.view addSubview:self.labelPassword];
    self.labelPassword.text = @"密码:";
    self.labelPassword.textColor = [UIColor whiteColor];
    [self.labelPassword release];
    
}

#pragma mark - 创建textField
/* 创建textfield */
- (void)createTextField {
    
    self.textfieldUserId = [[UITextField alloc] initWithFrame:CGRectMake(70 + self.labelUserId.frame.size.width + 10, self.labelUserId.frame.origin.y - 5, 150, 30)];
    [self.view addSubview:self.textfieldUserId];
    self.textfieldUserId.adjustsFontSizeToFitWidth = YES;
    self.textfieldUserId.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.textfieldUserId.borderStyle = UITextBorderStyleLine;
    self.textfieldUserId.delegate = self;
    self.textfieldUserId.backgroundColor = [UIColor clearColor];
    self.textfieldUserId.borderStyle =  2;
    self.textfieldUserId.tag = 100;
    self.textfieldUserId.textColor = [UIColor whiteColor];
    [self.textfieldUserId release];
    
    
    self.textfieldPassWord = [[UITextField alloc] initWithFrame:CGRectMake(70 + self.labelPassword.frame.size.width + 10, self.labelPassword.frame.origin.y - 5, 150, 30)];
    [self.view addSubview:self.textfieldPassWord];
    self.textfieldPassWord.secureTextEntry = YES;
 //   self.textfieldPassWord.placeholder = @"输入您的密码";
    self.textfieldPassWord.clearsOnBeginEditing = YES;
    self.textfieldPassWord.adjustsFontSizeToFitWidth = YES;
    self.textfieldPassWord.borderStyle =  2;
    self.textfieldPassWord.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.textfieldPassWord.borderStyle = UITextBorderStyleLine;
    self.textfieldPassWord.delegate  = self;
    self.textfieldPassWord.backgroundColor = [UIColor clearColor];
    self.textfieldPassWord.borderStyle =  2;
    self.textfieldPassWord.textColor = [UIColor whiteColor];
    self.textfieldPassWord.tag = 200;
    [self.textfieldPassWord release];
    
}

#pragma mark - textfield协议方法
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    /* 确认密码完成后, 自动回收键盘 */
    if (textField.tag == 200) {
        [textField resignFirstResponder];
    }
}



#pragma mark - 登陆按钮
- (void)createButtonLoginIn {
    
    self.buttonLoginIn = [UIButton buttonWithType:UIButtonTypeSystem];
    self.buttonLoginIn.frame = CGRectMake((self.view.frame.size.width - 80)/2, self.textfieldPassWord.frame.origin.y + 60, 80, 30);
   // self.buttonLoginIn.alpha = 0.2;
    [self.view addSubview:self.buttonLoginIn];
    self.buttonLoginIn.layer.borderWidth = 1;
    self.buttonLoginIn.layer.borderColor = [UIColor colorWithRed:0.656 green:0.688 blue:0.869 alpha:1.000].CGColor;
    self.buttonLoginIn.layer.cornerRadius = 5;
   // self.buttonLoginIn.backgroundColor = [UIColor grayColor];
    [self.buttonLoginIn setTitle:@"登陆" forState:UIControlStateNormal];
    [self.buttonLoginIn addTarget:self action:@selector(handleLoginInButton:) forControlEvents:UIControlEventTouchUpInside];
    
     self.buttonLoginIn.backgroundColor = [UIColor colorWithWhite:0.631 alpha:1.000];
    [self.buttonLoginIn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
}

/* 登陆按钮实现 */
- (void)handleLoginInButton:(UIButton *)button {
    
    
    /* 打开数据库, 查找用户信息 */
    [[LhyUserDataHanlder sharedDataBaseCreate] openDB];
    
    NSMutableArray *arrUserInfo = [[LhyUserDataHanlder sharedDataBaseCreate] selectInfoWithTitle:self.textfieldUserId.text];
   // NSLog(@"%@", arrUserInfo);
    LhyUserInfoModel *model = [arrUserInfo firstObject];
    NSString *userId = model.userId;
    NSString *passWord = model.password;
    
    /* 未输入用户名时 */
    if ([self.textfieldUserId.text isEqualToString:@""]) {
        
        UIAlertController *alertSucess = [UIAlertController alertControllerWithTitle:@"登陆失败" message:@"请输入用户名" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *actionSuccess01 = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        }];
        
        [alertSucess addAction:actionSuccess01];
        [self presentViewController:alertSucess animated:YES completion:^{
                        
                    }];
    }
    
    /* 输入用户名, 未输入密码时 */
    else if (![self.textfieldUserId.text isEqualToString:@""] && [self.textfieldPassWord.text isEqualToString:@""]) {
        
        
            UIAlertController *alertSucess = [UIAlertController alertControllerWithTitle:@"登陆失败" message:@"请输入密码" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *actionSuccess01 = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
                    }];
        
            [alertSucess addAction:actionSuccess01];
            [self presentViewController:alertSucess animated:YES completion:^{
        
                    }];
                    
                    
                }
    
    /* 输入完整, 用户名不存在时 */
    else if (![self.textfieldUserId.text isEqualToString:@""] && ![self.textfieldUserId.text isEqualToString:@""] && userId == nil) {
        
        
        UIAlertController *alertSucess = [UIAlertController alertControllerWithTitle:@"登陆失败" message:@"用户名不存在" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *actionSuccess01 = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        [alertSucess addAction:actionSuccess01];
        [self presentViewController:alertSucess animated:YES completion:^{
            
        }];
        
    }
    
    /* 输入完整, 用户名存在, 密码不匹配时 */
    else if (![self.textfieldUserId.text isEqualToString:@""] && ![self.textfieldUserId.text isEqualToString:@""] && userId != nil && ![passWord isEqualToString:self.textfieldPassWord.text]) {
        
        UIAlertController *alertSucess = [UIAlertController alertControllerWithTitle:@"登陆失败" message:@"密码不正确, 请重试" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *actionSuccess01 = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        [alertSucess addAction:actionSuccess01];
        [self presentViewController:alertSucess animated:YES completion:^{
            
        }];

        
        
    }
    
    /* 登陆成功! 加载菊花, 跳转界面, （完成传值）, 并本地存储当前用户名*/
    else {
        
        MBProgressHUD *MbProgress = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        MbProgress.dimBackground = NO;
        [MbProgress show:YES];
        
        
/* 加载菊花 */
        
        /* 延迟线程 */
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [UIView animateWithDuration:1 animations:^{
                
                [MbProgress hide:YES];
                
            } completion:^(BOOL finished) {
                if ([self.pageType isEqualToString:@"myInfo"]) {
                    [self dismissViewControllerAnimated:YES completion:^{
                    }];

                    /* 重新指定跟视图 */
                } else {
                    
                    AppDelegate *tempAppDelegate = [UIApplication sharedApplication].delegate;
                    tempAppDelegate.window.rootViewController = tempAppDelegate.tb;
                    NSLog(@"返回主界面");
                }
                
            }];
        });
        
        NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)firstObject];
        NSString *userIdPath = [docPath stringByAppendingPathComponent:@"UserId.txt"];
        
        [userId writeToFile:userIdPath atomically:YES encoding:NSUTF8StringEncoding error:nil];
    }
 
}


#pragma mark - 注册按钮
- (void)createButtonRegist {
    
    
    self.buttonRegist = [UIButton buttonWithType:UIButtonTypeCustom];
    self.buttonRegist.frame = CGRectMake((self.view.frame.size.width - 80)/2 + 120, self.textfieldPassWord.frame.origin.y + 100, 70, 15);
    self.buttonRegist.titleLabel.font = [UIFont systemFontOfSize:13];
    [self.view addSubview:self.buttonRegist];
   // self.buttonRegist.backgroundColor = [UIColor grayColor];
    [self.buttonRegist setTitle:@"立即注册 >" forState:UIControlStateNormal];
    [self.buttonRegist setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.buttonRegist addTarget:self action:@selector(handleRegistButton:) forControlEvents:UIControlEventTouchUpInside];
    
}

/* 注册按钮点击方法 */
- (void)handleRegistButton:(UIButton *)buttonRegist {
    
    NSLog(@"aaa");
    LhyRegistViewController *registVC = [[LhyRegistViewController alloc] init];
    [self presentViewController:registVC animated:YES completion:^{
        
    }];
    
    /* 指定代理人 */
    registVC.delegate = self;
    [registVC release];

}

#pragma mark - 协议方法的实现
- (void)getTrueUserName:(NSString *)name PassWord:(NSString *)passWord {
    
    /* 协议完成传值 */
    self.textfieldUserId.text = name;
    self.textfieldPassWord.text = passWord;
    
}

#pragma mark - 返回按钮
/* 创建返回按钮 */
- (void)createButtonReturn {
    
    self.buttonReturn = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.buttonReturn setImage:[UIImage imageNamed:@"iconfont-close"] forState:UIControlStateNormal];
    self.buttonReturn.frame = CGRectMake(15, 30, 20, 20);
    self.buttonReturn.tintColor = [UIColor whiteColor];
    [self.view addSubview:self.buttonReturn];
    /* 按钮添加点击方法 */
    [self.buttonReturn addTarget:self action:@selector(handleReturnButton:) forControlEvents:UIControlEventTouchUpInside];

}


/* 返回按钮点击方法 */
- (void)handleReturnButton:(UIButton *)buttonReturn {
   
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
