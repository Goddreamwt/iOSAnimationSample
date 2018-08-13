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
@property(nonatomic,strong)UILabel * lb2;
@property(nonatomic)int number;
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
    
    _lb2 =[[UILabel alloc]initWithFrame:CGRectMake(100, 300, 200, 50)];
    [self.view addSubview:_lb2];
    
    [self changeFlight];
}

- (void)changeFlight {
  
   _number++;
    NSString *string = [NSString stringWithFormat:@"%@%d",@"日子一天天过去:",_number];
   [_lb2 wt_setTextPageAnimation:string direction:negative];
    
    double delayInSeconds = 3.0;
    __block NumberAnimationViewController* bself = self;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [bself changeFlight];
    });
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSString *str = @"188969";
    double a = [str doubleValue]/100;
    NSString * num1 = [NSString stringWithFormat:@"%.2lf",a];
    [_lb wt_setNumber:@([num1 doubleValue])];
}
@end
