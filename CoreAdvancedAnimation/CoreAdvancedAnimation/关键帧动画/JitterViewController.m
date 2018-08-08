//
//  JitterViewController.m
//  CoreAdvancedAnimation
//
//  Created by mac on 2018/8/7.
//  Copyright © 2018年 mac. All rights reserved.
//

#define angleToRadians(angle) ((angle)/180.0 * M_PI)
#import "JitterViewController.h"

@interface JitterViewController ()
@property(nonatomic,strong)UIImageView * image;
@end

@implementation JitterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor whiteColor];
    _image =[[UIImageView alloc]initWithFrame:CGRectMake(100, 100, 50, 50)];
    _image.image =[UIImage imageNamed:@"weixin"];
    [self.view addSubview:_image];
    
}

#pragma mark -过山车动画
-(void)test{
    //贝塞尔曲线：1.数据点（起点终点）；2.控制点
    UIBezierPath * path =[UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(20, 400)];
    [path addCurveToPoint:CGPointMake(400, 400) controlPoint1:CGPointMake(100, 100) controlPoint2:CGPointMake(200, 500)];
    CAShapeLayer *shapeLayer =[CAShapeLayer layer];
    shapeLayer.path = path.CGPath;
    shapeLayer.fillColor=nil;
    shapeLayer.strokeColor =[UIColor purpleColor].CGColor;
    
    [self.view.layer addSublayer:shapeLayer];
    
    CALayer * carLayer =[CALayer layer];
    carLayer.frame = CGRectMake(15, 400-18, 36, 36);
    //寄宿图 contents属性
    carLayer.contents =(id)([UIImage imageNamed:@"car"].CGImage);
    carLayer.anchorPoint = CGPointMake(0.5, 0.8);//设置锚点，轮胎的位置
    [self.view.layer addSublayer:carLayer];
    
    CAKeyframeAnimation * anim =[CAKeyframeAnimation animation];
    anim.keyPath = @"position";
    anim.path = path.CGPath;
    anim.duration = 4.0;
    anim.rotationMode = kCAAnimationRotateAuto;//自动切换角度，车头的朝向
    [carLayer addAnimation:anim forKey:nil];
}

#pragma mark -抖动效果
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    CAKeyframeAnimation * anim =[CAKeyframeAnimation animation];
    anim.keyPath =@"transform.rotation";
    //动画平滑化-方式一
//    anim.values =@[@angleToRadians(-3),@angleToRadians(3),@angleToRadians(-3)];
    //方式二
    anim.values =@[@angleToRadians(-3),@angleToRadians(3)];
    anim.speed =2;//动画速度
//    anim.duration = 1;//持续时间
    anim.autoreverses =YES;//动画反转
    anim.repeatCount = MAXFLOAT;//重复次数
    [_image.layer addAnimation:anim forKey:nil];
    
    [self test];
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
