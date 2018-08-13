//
//  SublayerViewController.m
//  CoreAdvancedAnimation
//
//  Created by mac on 2018/8/10.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "SublayerViewController.h"
#import <CoreText/CoreText.h>
#import "UIView+UIView_Gradient.h"

@interface SublayerViewController ()

@end

@implementation SublayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor whiteColor];
//    [self textLayer];
    [self gradientLayer];
//    [self tranFrom3D];
}


//3D图层
//CGTransform 2D图层 + z轴
/*
 1.立方体有6个面（layer）
 2.layer做一个3D转换（平移+旋转）
 3.通过CATransform3D做变换
 4.把layer添加在CATransformLayer
 5.把CATransformLayer添加到self.view.layer
 */
-(void)tranFrom3D{
    CATransformLayer * cubeLayer =[CATransformLayer layer];
    
    //1
    //tx ty tz
    CATransform3D ct = CATransform3DMakeTranslation(0, 0, 50);
    [cubeLayer addSublayer:[self faceWithTransfrom:ct]];
    //2
    ct = CATransform3DMakeTranslation(50, 0, 0);//平移
    ct = CATransform3DRotate(ct, M_PI_2, 0, 1, 0);
//    ct = CATransform3DMakeRotation(M_PI_4, 0, 1, 0);//旋转  角度 以及绕Y轴旋转 M_PI_2 90度看不到效果
    [cubeLayer addSublayer:[self faceWithTransfrom:ct]];
    //3
    ct = CATransform3DMakeTranslation(0,-50, 0);//平移
    ct = CATransform3DRotate(ct, M_PI_2, 1, 0, 0);//X轴旋转
    [cubeLayer addSublayer:[self faceWithTransfrom:ct]];
    //4
    ct = CATransform3DMakeTranslation(0,50, 0);//平移
    ct = CATransform3DRotate(ct, M_PI_2, 1, 0, 0);//X轴旋转
    [cubeLayer addSublayer:[self faceWithTransfrom:ct]];
    //5
    ct = CATransform3DMakeTranslation(-50,0, 0);//平移
    ct = CATransform3DRotate(ct, M_PI_2, 0, 1, 0);//X轴旋转
    [cubeLayer addSublayer:[self faceWithTransfrom:ct]];
    //6
    ct = CATransform3DMakeTranslation(0,0, -50);//平移
    ct = CATransform3DRotate(ct, M_PI, 0, 1, 0);//X轴旋转
    [cubeLayer addSublayer:[self faceWithTransfrom:ct]];
    
    cubeLayer.position = CGPointMake(CGRectGetWidth(self.view.bounds)/2, CGRectGetHeight(self.view.bounds)/2);
    
    //旋转
    cubeLayer.transform = CATransform3DMakeRotation(M_PI_4, 1, 1, 0);
    [self.view.layer addSublayer:cubeLayer];
}
//layer转3D
-(CALayer *)faceWithTransfrom:(CATransform3D)transform{
    CALayer * face =[CALayer layer];
    //设置位置和颜色
    face.bounds = CGRectMake(0, 0, 100, 100);
    CGFloat red = arc4random()/(CGFloat)INT_MAX;
    CGFloat green = arc4random()/(CGFloat)INT_MAX;
    CGFloat blue = arc4random()/(CGFloat)INT_MAX;
    UIColor * color =[UIColor colorWithRed:red green:green blue:blue alpha:1];
    face.backgroundColor = color.CGColor;
    face.transform = transform;
    return face;
}

//渐变图层
-(void)gradientLayer{
    
    CAGradientLayer * gradientLayer =[CAGradientLayer layer];
    gradientLayer.frame = CGRectMake(100, 100, 100, 100);
    gradientLayer.colors= @[(id)[UIColor redColor].CGColor,(id)[UIColor yellowColor].CGColor,(id)[UIColor orangeColor].CGColor];
    //设置对角渐变
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1, 1);
    [self.view.layer addSublayer:gradientLayer];
    
    //使用UIView分类UIView+UIView_Gradient增加渐变色的拓展方法
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 280, 200, 30)];
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 320, 200, 30)];
    UIView *tempView = [[UIView alloc] initWithFrame:CGRectMake(0, 360, 200, 30)];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 400, 200, 30)];
    
    [self.view addSubview:label];
    [self.view addSubview:btn];
    [self.view addSubview:tempView];
    [self.view addSubview:imageView];
    
    label.backgroundColor = [UIColor clearColor];
    btn.backgroundColor = [UIColor blueColor];
    tempView.backgroundColor = [UIColor blueColor];
    imageView.backgroundColor = [UIColor blueColor];
    
    [label setGradientBackgroundWithColors:@[[UIColor redColor],[UIColor greenColor]] locations:nil startPoint:CGPointMake(0, 0) endPoint:CGPointMake(1, 0)];
    
    [btn setGradientBackgroundWithColors:@[[UIColor redColor],[UIColor grayColor]] locations:nil startPoint:CGPointMake(0, 0) endPoint:CGPointMake(1, 0)];
    
    [tempView setGradientBackgroundWithColors:@[[UIColor redColor],[UIColor yellowColor]] locations:nil startPoint:CGPointMake(0, 0) endPoint:CGPointMake(1, 0)];
    
    [imageView setGradientBackgroundWithColors:@[[UIColor redColor],[UIColor clearColor]] locations:nil startPoint:CGPointMake(0, 0) endPoint:CGPointMake(1, 0)];
    
    label.text = @"Text";
    label.textAlignment = NSTextAlignmentCenter;
    
    [btn setTitle:@"Button" forState:UIControlStateNormal];
}

//富文本图层
-(void)textLayer{
    
    CATextLayer * textLayer =[CATextLayer layer];
    textLayer.frame = CGRectMake(100, 400, 200, 50);
    textLayer.backgroundColor =[UIColor greenColor].CGColor;
    //    textLayer.string = @"HelloWorld";
    textLayer.alignmentMode = kCAAlignmentCenter;
    textLayer.fontSize = [UIFont systemFontOfSize:20].pointSize;
    textLayer.foregroundColor =[UIColor blackColor].CGColor;
    [self.view.layer addSublayer:textLayer];
    
    //富文本
    NSMutableAttributedString *str =[[NSMutableAttributedString alloc]initWithString:@"hello world"];
    NSDictionary *attribs = @{(id)kCTForegroundColorAttributeName:(id)[UIColor redColor]};
    [str setAttributes:attribs range:NSMakeRange(0, 5)];
    textLayer.string = str;
}

@end
