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
   
    CGFloat width =100;
    CGFloat height = 20;
    CGFloat l_space = 20;
    CGFloat v_space = 20;
    CGFloat top = 80;
    
    
    UIButton * hiddenBtn =[[UIButton alloc]initWithFrame:CGRectMake(0, top, width, height)];
    [self createButton:hiddenBtn setTitle:@"隐式动画" addAction:@selector(hiddenBtnClick:)];
    
    UIButton * jitterBtn =[[UIButton alloc]initWithFrame:CGRectMake(width+l_space, top, width, height)];
    [self createButton:jitterBtn setTitle:@"关键帧动画" addAction:@selector(jitterBtnClick:)];
}
-(void)createButton:(UIButton *)btn setTitle:(NSString *)title addAction:(SEL)action{
    [btn setTitle:title forState:UIControlStateNormal];
    [btn addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    [btn setBackgroundColor:[UIColor grayColor]];
    [self.view addSubview:btn];
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
