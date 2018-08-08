//
//  ViewController.m
//  CoreAdvancedAnimation
//
//  Created by mac on 2018/8/7.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "ViewController.h"
#import "HiddenAnimationViewController.h"
#import "JitterViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor whiteColor];
    
    UIButton * hiddenBtn =[[UIButton alloc]initWithFrame:CGRectMake(50, 100, 100, 20)];
    [hiddenBtn setTitle:@"隐式动画" forState:UIControlStateNormal];
    [hiddenBtn addTarget:self action:@selector(hiddenBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [hiddenBtn setBackgroundColor:[UIColor grayColor]];
    [self.view addSubview:hiddenBtn];
    
    UIButton * jitterBtn =[[UIButton alloc]initWithFrame:CGRectMake(160, 100, 100, 20)];
    [jitterBtn setTitle:@"关键帧动画" forState:UIControlStateNormal];
    [jitterBtn addTarget:self action:@selector(jitterBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [jitterBtn setBackgroundColor:[UIColor grayColor]];
    [self.view addSubview:jitterBtn];
}

#pragma mark --隐式动画
-(void)hiddenBtnClick:(UIButton *)btn{
    HiddenAnimationViewController * hidden =[[HiddenAnimationViewController alloc]init];
    [self.navigationController pushViewController:hidden animated:NO];
}

#pragma mark --抖动效果-关键帧动画
-(void)jitterBtnClick:(UIButton *)btn{
    JitterViewController * jitter =[[JitterViewController alloc]init];
    [self.navigationController pushViewController:jitter animated:NO];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
