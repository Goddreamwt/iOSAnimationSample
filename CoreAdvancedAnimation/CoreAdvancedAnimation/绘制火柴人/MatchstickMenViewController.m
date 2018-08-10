//
//  MatchstickMenViewController.m
//  CoreAdvancedAnimation
//
//  Created by mac on 2018/8/10.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "MatchstickMenViewController.h"
#import <CoreText/CoreText.h>

@interface MatchstickMenViewController ()

@end

@implementation MatchstickMenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor whiteColor];
    [self shaperLayer];
    
    [self textLayer];
}
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

-(void)shaperLayer{
    UIBezierPath * path =[UIBezierPath bezierPath];
    //首先绘制圆形
    [path moveToPoint:CGPointMake(175, 100)];
    //addArcWithCenter既可以画圆也可以画弧线
    /*
     Center:中心点
     radius:半径
     startAngle：开始角度
     endAngle:结束角度
     clockwise:是否是顺时针
     */
     [path addArcWithCenter:CGPointMake(150, 100) radius:25 startAngle:0 endAngle:2 *M_PI clockwise:YES];
    
    //重新来个起始点,画竖线
    [path moveToPoint:CGPointMake(150, 125)];
    //addLineToPoint画线
    [path addLineToPoint:CGPointMake(150, 175)];
    
    //画腿 第一条
    [path addLineToPoint:CGPointMake(125, 225)];
    //另外一条
    [path moveToPoint:CGPointMake(150, 175)];
    [path addLineToPoint:CGPointMake(175, 225)];
    
    //画胳膊
    [path moveToPoint:CGPointMake(100, 150)];
    [path addLineToPoint:CGPointMake(200, 150)];
    
    CAShapeLayer * shapeLayer =[CAShapeLayer layer];
    shapeLayer.path =path.CGPath;
    shapeLayer.strokeColor =[UIColor redColor].CGColor;//画笔颜色
    shapeLayer.lineWidth = 5;
    shapeLayer.fillColor = nil;//填充颜色
    shapeLayer.lineCap =kCALineCapRound;//设置线的末尾样式
    shapeLayer.lineJoin = kCALineJoinRound;//设置两条连线的中间样式
    [self.view.layer addSublayer:shapeLayer];
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
