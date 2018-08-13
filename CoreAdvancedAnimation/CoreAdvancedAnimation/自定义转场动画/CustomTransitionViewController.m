//
//  CustomTransitionViewController.m
//  CoreAdvancedAnimation
//
//  Created by mac on 2018/8/10.
//  Copyright © 2018年 mac. All rights reserved.
//
/*
 1.实现相关协议
 2.在协议中实现动画
 */
#import "CustomTransitionViewController.h"
#import "SecondViewController.h"
#import "WTCircleTransition.h"

@interface CustomTransitionViewController ()<UINavigationControllerDelegate>

@end

@implementation CustomTransitionViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor whiteColor];
   
    UIImageView * bgView =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    bgView.image =[UIImage imageNamed:@"view0"];
    [self.view addSubview:bgView];
    
    
    _customTransitionBtn =[[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width -100,self.view.frame.size.height -100, 60, 60)];
    [_customTransitionBtn setBackgroundColor:[UIColor grayColor]];
    [_customTransitionBtn.layer setMasksToBounds:YES];
    [_customTransitionBtn.layer setCornerRadius:30];
    [_customTransitionBtn addTarget:self action:@selector(customTransitionBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_customTransitionBtn];
 
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    self.navigationController.delegate = self;
}
-(void)customTransitionBtnClick:(UIButton *)btn{
    SecondViewController * sec =[[SecondViewController alloc]init];
    self.navigationController.navigationBarHidden = YES;
    [self.navigationController pushViewController:sec animated:YES];
}
//告诉nav，想自己自定义一个转场
-(id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC{
    if (operation == UINavigationControllerOperationPush) {
        WTCircleTransition *trans =[WTCircleTransition new];
        trans.isPush = YES;
        return trans;
    }
    return nil;
}

@end
