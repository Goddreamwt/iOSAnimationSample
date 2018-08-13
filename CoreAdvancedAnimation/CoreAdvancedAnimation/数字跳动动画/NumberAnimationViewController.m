//
//  NumberAnimationViewController.m
//  CoreAdvancedAnimation
//
//  Created by mac on 2018/8/13.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "NumberAnimationViewController.h"
#import "UILabel+MoneyAnimation.h"
#import "UIView+UIView_Gradient.h"

@interface NumberAnimationViewController ()
@property(nonatomic,strong)UILabel * lb;
@end

@implementation NumberAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor whiteColor];
    _lb =[[UILabel alloc]initWithFrame:CGRectMake(100, 100, 100, 50)];
    _lb.textAlignment = NSTextAlignmentCenter;
    _lb.textColor =[UIColor whiteColor];
    [self.view addSubview:_lb];
    
    [_lb setGradientBackgroundWithColors:@[[UIColor redColor],[UIColor orangeColor]] locations:nil startPoint:CGPointMake(0, 0) endPoint:CGPointMake(1, 0)];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSString *str = @"188969";
    double a = [str doubleValue]/100;
    NSString * num1 = [NSString stringWithFormat:@"%.2lf",a];
    [_lb wt_setNumber:@([num1 doubleValue])];
}
@end
