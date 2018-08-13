//
//  SecondViewController.m
//  CoreAdvancedAnimation
//
//  Created by mac on 2018/8/10.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "SecondViewController.h"
#import "WTCircleTransition.h"

@interface SecondViewController()<UINavigationControllerDelegate>

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UIImageView * bgView =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    bgView.image =[UIImage imageNamed:@"view1"];
    [self.view addSubview:bgView];
    
    _backBtn =[[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width -100,self.view.frame.size.height -100, 60, 60)];
    [_backBtn setBackgroundColor:[UIColor redColor]];
    [_backBtn.layer setMasksToBounds:YES];
    [_backBtn.layer setCornerRadius:30];
    [_backBtn addTarget:self action:@selector(customTransitionBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_backBtn];
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.delegate = self;
}
-(void)customTransitionBtnClick:(UIButton *)btn{
    [self.navigationController popViewControllerAnimated:YES];
    
}
//告诉nav，想自己自定义一个转场
-(id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC{
    if (operation == UINavigationControllerOperationPop) {
        WTCircleTransition *trans =[WTCircleTransition new];
        trans.isPush = NO;
        return trans;
    }
    return nil;
}
@end
