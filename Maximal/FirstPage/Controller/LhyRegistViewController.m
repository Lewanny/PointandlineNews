//
//  LhyRegistViewController.m
//  Maximal
//
//  Created by 李宏远 on 15/11/24.
//  Copyright © 2015年 李宏远. All rights reserved.
//

#import "LhyRegistViewController.h"
#import "LhyMainViewController.h"
#import "LhyUserDataHanlder.h"

#import "LhyUserInfoModel.h"




@interface LhyRegistViewController ()<UIAlertViewDelegate, UITextFieldDelegate>



@property(nonatomic, retain)UIButton *buttonReturn;

@property(nonatomic, retain)UILabel *labelUserId;
@property(nonatomic, retain)UILabel *labelPassword;
@property(nonatomic, retain)UILabel *labelPassword02;

@property(nonatomic, retain)UITextField *textfieldUserId;
@property(nonatomic, retain)UITextField *textfieldPassWord;
@property(nonatomic, retain)UITextField *textfieldPassWord02;

@property(nonatomic, retain)UILabel *labelError;
@property(nonatomic, retain)UIButton *buttonConcern;
@property(nonatomic, retain)UIButton *buttonRegist;


@end

@implementation LhyRegistViewController

- (void)dealloc {
    
    [_labelPassword02 release];
    [_labelPassword release];
    [_labelUserId release];
    
    [_textfieldPassWord02 release];
    [_textfieldPassWord release];
    [_textfieldUserId release];
    
    [_labelError release];
    [super dealloc];
    
}
#pragma mark - 页面将要出现
- (void)viewWillAppear:(BOOL)animated {
    
    self.labelError.hidden = YES;
}

/* 背景图片 */
- (void)createBGView {
    
    UIImageView *bgView = [[UIImageView alloc] init];
    bgView.frame = self.view.bounds;
    bgView.image = [UIImage imageNamed:@"denglu"];
    [self.view addSubview:bgView];
    bgView.backgroundColor = [UIColor colorWithRed:0.956 green:1.000 blue:0.951 alpha:1.000];
    [bgView release];
}

#pragma mark - 页面即将出现
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createBGView];
    [self createButtonReturn];
    [self createLabel];
    [self createTextField];
    [self createButtonConrern];
    
 
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleResignKeyBoard)];
    [self.view addGestureRecognizer:tap];
    [tap release];
    
}
/* 回收键盘 */
- (void)handleResignKeyBoard {
    [self.view endEditing:YES];
}

#pragma mark - 创建label
- (void)createLabel {
    
    self.labelUserId = [[UILabel alloc] initWithFrame:CGRectMake(70, 230, 90, 20)];
    [self.view addSubview:self.labelUserId];
    self.labelUserId.text = @"用户名:";
    self.labelUserId.textColor = [UIColor whiteColor];
    [self.labelUserId release];
    
    self.labelPassword = [[UILabel alloc] initWithFrame:CGRectMake(70, self.labelUserId.frame.origin.y + 50, 90, 20)];
    [self.view addSubview:self.labelPassword];
    self.labelPassword.text = @"密码:";
    self.labelPassword.textColor = [UIColor whiteColor];
    [self.labelPassword release];
    
    self.labelPassword02 = [[UILabel alloc] initWithFrame:CGRectMake(70, self.labelPassword.frame.origin.y + 50, 90, 20)];
    [self.view addSubview:self.labelPassword02];
    self.labelPassword02.text = @"确认密码:";
    self.labelPassword02.textColor = [UIColor whiteColor];
    [self.labelPassword02 release];
    
    self.labelError = [[UILabel alloc] initWithFrame:CGRectMake(70, 60 , 130, 20)];
    [self.view addSubview:self.labelError];
    self.labelError.text = @"该账号已被注册过";
    self.labelError.font = [UIFont systemFontOfSize:15];
    self.labelError.textColor = [UIColor redColor];
    self.labelError.hidden = YES;
    [self.labelError release];
}

/* 创建textfield */
- (void)createTextField {
    
    self.textfieldUserId = [[UITextField alloc] initWithFrame:CGRectMake(60 + self.labelUserId.frame.size.width + 10, self.labelUserId.frame.origin.y - 5, 150, 30)];
    [self.view addSubview:self.textfieldUserId];
    self.textfieldUserId.adjustsFontSizeToFitWidth = YES;
    self.textfieldUserId.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.textfieldUserId.borderStyle = UITextBorderStyleLine;
    self.textfieldUserId.delegate = self;
    self.textfieldUserId.tag = 100;
    self.textfieldUserId.backgroundColor = [UIColor clearColor];
    self.textfieldUserId.borderStyle =  2;
    self.textfieldUserId.tag = 100;
    self.textfieldUserId.textColor = [UIColor whiteColor];
    [self.textfieldUserId release];
    
    
    self.textfieldPassWord = [[UITextField alloc] initWithFrame:CGRectMake(60 + self.labelPassword.frame.size.width + 10, self.labelPassword.frame.origin.y - 5, 150, 30)];
    [self.view addSubview:self.textfieldPassWord];
    self.textfieldPassWord.adjustsFontSizeToFitWidth = YES;
    self.textfieldPassWord.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.textfieldPassWord.borderStyle = UITextBorderStyleLine;
    self.textfieldPassWord.secureTextEntry = YES;
    self.textfieldPassWord.delegate = self;
    self.textfieldPassWord.tag = 200;
    self.textfieldPassWord.clearsOnBeginEditing = YES;
    self.textfieldPassWord.backgroundColor = [UIColor clearColor];
    self.textfieldPassWord.borderStyle =  2;
    self.textfieldPassWord.tag = 100;
    self.textfieldPassWord.textColor = [UIColor whiteColor];
    [self.textfieldPassWord release];
    
    
    
    self.textfieldPassWord02 = [[UITextField alloc] initWithFrame:CGRectMake(60 + self.labelPassword.frame.size.width + 10, self.labelPassword02.frame.origin.y - 5, 150, 30)];
    [self.view addSubview:self.textfieldPassWord02];
    self.textfieldPassWord02.adjustsFontSizeToFitWidth = YES;
    self.textfieldPassWord02.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.textfieldPassWord02.borderStyle = UITextBorderStyleLine;
    self.textfieldPassWord02.secureTextEntry = YES;
    self.textfieldPassWord02.delegate = self;
    self.textfieldPassWord02.clearsOnBeginEditing = YES;
    self.textfieldPassWord02.tag = 300;
    self.textfieldPassWord02.backgroundColor = [UIColor clearColor];
    self.textfieldPassWord02.borderStyle =  2;
    self.textfieldPassWord02.tag = 100;
    self.textfieldPassWord02.textColor = [UIColor whiteColor];
    [self.textfieldPassWord02 release];
}

#pragma mark - textfield的协议方法
/* 协议方法 */
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    NSMutableArray *arrUserInfo = [NSMutableArray array];
    /* 确认密码完成后, 自动回收键盘 */
    if (textField.tag == 300) {
        [textField resignFirstResponder];
    } else if(textField.tag == 100) {
        NSLog(@"aaa-------");
        
        
        [[LhyUserDataHanlder sharedDataBaseCreate] openDB];
        arrUserInfo = [[LhyUserDataHanlder sharedDataBaseCreate] selectInfoWithTitle:self.textfieldUserId.text];
        LhyUserInfoModel *model = [arrUserInfo firstObject];
        NSString *userId = model.userId;
        if (userId != nil) {
            
            self.labelError.hidden = NO;
            
        }
    }
    
}

/* 提示框小时 */
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
    if (textField.tag == 100) {
        self.labelError.hidden = YES;
    }
    
}

#pragma mark - 确认注册按钮按钮
- (void)createButtonConrern {
    
    self.buttonConcern = [UIButton buttonWithType:UIButtonTypeSystem];
    self.buttonConcern.frame = CGRectMake((self.view.frame.size.width - 80)/2, self.textfieldPassWord02.frame.origin.y + 60, 80, 30);
    [self.view addSubview:self.buttonConcern];
    [self.buttonConcern setTitle:@"确认注册" forState:UIControlStateNormal];
    self.buttonConcern.layer.borderWidth = 1;
    self.buttonConcern.layer.cornerRadius = 5;
    self.buttonConcern.layer.borderColor = [UIColor colorWithRed:0.656 green:0.688 blue:0.869 alpha:1.000].CGColor;
    [self.buttonConcern addTarget:self action:@selector(handleConcrenRegist:) forControlEvents:UIControlEventTouchUpInside];
    
    self.buttonConcern.backgroundColor = [UIColor colorWithWhite:0.631 alpha:1.000];
    [self.buttonConcern setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
}

- (void)handleConcrenRegist:(UIButton *)button {
    /* 打开数据库, 查找用户信息 */
    [[LhyUserDataHanlder sharedDataBaseCreate] openDB];
    
    NSMutableArray *arrUserInfo = [[LhyUserDataHanlder sharedDataBaseCreate] selectInfoWithTitle:self.textfieldUserId.text];
    LhyUserInfoModel *model = [arrUserInfo firstObject];
    NSString *userId = model.userId;
    
    /* 注册成功 */
    if ([self.textfieldPassWord.text isEqualToString:self.textfieldPassWord02.text] && ![self.textfieldUserId.text isEqualToString:@""]&&![self.textfieldPassWord.text isEqualToString:@""]) {
        NSLog(@"注册成功, 请返回登陆");
        
        if (userId == nil) {
            UIAlertController *alertSucess = [UIAlertController alertControllerWithTitle:@"注册成功" message:@"注册成功, 请返回登陆" preferredStyle:UIAlertControllerStyleAlert];
            
            // 直接返回到登陆界面, 并用协议完成传值
            UIAlertAction *actionSuccess01 = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                /* 跳转界面时, 实现协议方法 */
                [self.delegate getTrueUserName:self.textfieldUserId.text PassWord:self.textfieldPassWord.text];
                
                [self dismissViewControllerAnimated:YES completion:^{
                    
                }];
                // NSLog(@"666666666666");
                
            }];
            
            [alertSucess addAction:actionSuccess01];
            
            
            [self presentViewController:alertSucess animated:YES completion:^{
                
            }];
            
            /* 打开数据库, 存储用户信息 */
            [[LhyUserDataHanlder sharedDataBaseCreate] openDB];
            [[LhyUserDataHanlder sharedDataBaseCreate] createTable];
            LhyUserInfoModel *model = [[LhyUserInfoModel alloc] init];
            model.userId = self.textfieldUserId.text;
            model.password = self.textfieldPassWord.text;
            
            [[LhyUserDataHanlder sharedDataBaseCreate] insertInfoWithModel:model];
            
        } else {
            
            
            UIAlertController *alertSucess = [UIAlertController alertControllerWithTitle:@"注册失败" message:@"该账号已经被注册过" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *actionSuccess01 = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            
            [alertSucess addAction:actionSuccess01];
            [self presentViewController:alertSucess animated:YES completion:^{
                
            }];

            
        }
        
       
        
        
    } else {
        
        if ([self.textfieldUserId.text isEqualToString:@""]) {
            UIAlertController *alertSucess = [UIAlertController alertControllerWithTitle:@"注册失败" message:@"请输入用户名" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *actionSuccess01 = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            
            [alertSucess addAction:actionSuccess01];
            [self presentViewController:alertSucess animated:YES completion:^{
                
            }];

        } else if ([self.textfieldPassWord.text isEqualToString:@""] &&![self.textfieldUserId.text isEqualToString:@""]) {
            if (userId == nil) {
                
                UIAlertController *alertSucess = [UIAlertController alertControllerWithTitle:@"注册失败" message:@"请输入密码" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *actionSuccess01 = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    
                }];
                
                [alertSucess addAction:actionSuccess01];
                [self presentViewController:alertSucess animated:YES completion:^{
                    
                }];
            } else {
                
                UIAlertController *alertSucess = [UIAlertController alertControllerWithTitle:@"注册失败" message:@"该账号已经被注册过" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *actionSuccess01 = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    
                }];
                
                [alertSucess addAction:actionSuccess01];
                [self presentViewController:alertSucess animated:YES completion:^{
                    
                }];

                
                
            }
            

            
        } else if ([self.textfieldPassWord02.text isEqualToString:@""] && ![self.textfieldPassWord.text isEqualToString:@""] && ![self.textfieldUserId.text isEqualToString:@""]) {
            
            if (userId == nil) {
                UIAlertController *alertSucess = [UIAlertController alertControllerWithTitle:@"注册失败" message:@"请确认密码" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *actionSuccess01 = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    
                }];
                
                [alertSucess addAction:actionSuccess01];
                [self presentViewController:alertSucess animated:YES completion:^{
                    
                }];
            } else {
                
                UIAlertController *alertSucess = [UIAlertController alertControllerWithTitle:@"注册失败" message:@"该账号已经被注册过" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *actionSuccess01 = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    
                }];
                
                [alertSucess addAction:actionSuccess01];
                [self presentViewController:alertSucess animated:YES completion:^{
                    
                }];

                
                
                
            }
            
        } else if (![self.textfieldPassWord02.text isEqualToString:@""] && ![self.textfieldPassWord.text isEqualToString:@""] && ![self.textfieldUserId.text isEqualToString:@""] && ![self.textfieldPassWord.text isEqualToString:self.textfieldPassWord02.text]) {
            
            if (userId == nil) {
                UIAlertController *alertSucess = [UIAlertController alertControllerWithTitle:@"注册失败" message:@"两次输入的密码不一致, 请检查后重试" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *actionSuccess01 = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    
                }];
                
                [alertSucess addAction:actionSuccess01];
                [self presentViewController:alertSucess animated:YES completion:^{
                    
                }];
            } else {
                
                UIAlertController *alertSucess = [UIAlertController alertControllerWithTitle:@"注册失败" message:@"该账号已经被注册过" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *actionSuccess01 = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    
                }];
                
                [alertSucess addAction:actionSuccess01];
                [self presentViewController:alertSucess animated:YES completion:^{
                    
                }];
                
            }
            
            
            
            
        }
        
        NSLog(@"未考虑到情况");
            }
    
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
