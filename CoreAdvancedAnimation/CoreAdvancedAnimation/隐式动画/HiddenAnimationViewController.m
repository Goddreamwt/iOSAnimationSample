//
//  HiddenAnimationViewController.m
//  CoreAdvancedAnimation
//
//  Created by mac on 2018/8/7.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "HiddenAnimationViewController.h"
#import "WTRedView.h"

@interface HiddenAnimationViewController ()

@property(strong,nonatomic)CALayer *layer;
@property (strong, nonatomic)WTRedView *redView;
@end

@implementation HiddenAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor whiteColor];
    
    CALayer * layer =[CALayer layer];
    layer.frame = CGRectMake(100, 100, 100, 100);
    layer.backgroundColor =[UIColor greenColor].CGColor;
    _layer = layer;
    [self.view.layer addSublayer:layer];
    
    _redView =[[WTRedView alloc]initWithFrame:CGRectMake(50, 100, 100, 100)];
    _redView.backgroundColor =[UIColor redColor];
    [self.view addSubview:_redView];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    _layer.frame =CGRectMake(100, 400, 100, 100);
    _layer.backgroundColor =[UIColor orangeColor].CGColor;
    CGPoint p = [[touches anyObject] locationInView:_redView];
    //presentationLayer
    if (_redView.layer.presentationLayer == [_redView.layer hitTest:p]) {
        NSLog(@"1");
    }
    //修改模型图层
    _redView.frame = CGRectMake(50, 400, 100, 100);
    CABasicAnimation * anim =[CABasicAnimation animation];
    anim.keyPath = @"position.y";
    //anim.toValue = @400;
    anim.duration = 1;
    anim.removedOnCompletion=NO; //完成是否移除
    //anim.fillMode =kCAFillModeForwards;//保持最后的状态
    //anim.delegate =self;
    [_redView.layer addAnimation:anim forKey:nil];
}

#pragma -CAAnimationDelegate

-(void)animationDidStart:(CAAnimation *)anim{
    NSLog(@"%@",NSStringFromCGRect(_redView.frame));
}

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    NSLog(@"%@",NSStringFromCGRect(_redView.frame));
    
    NSLog(@"%@",NSStringFromCGRect(_redView.layer.presentationLayer.frame));
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
