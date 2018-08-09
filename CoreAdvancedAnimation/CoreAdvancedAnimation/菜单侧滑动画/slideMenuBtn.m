//
//  slideMenuBtn.m
//  CoreAdvancedAnimation
//
//  Created by mac on 2018/8/8.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "slideMenuBtn.h"


@implementation slideMenuBtn{
    NSString * btnTitle;
}

-(id)initWithTitle:(NSString *)title{
    self = [super init];
    if (self) {
        btnTitle = title;
    }
    return self;
}

-(void)drawRect:(CGRect)rect{
    //先添加画布
    NSLog(@"%@",NSStringFromCGRect(rect));
    NSLog(@"%@",NSStringFromCGRect(CGRectInset(rect, 1, 1)));
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextAddRect(context, rect);
    
    UIColor * color =[UIColor colorWithRed:0 green:0.722 blue:1 alpha:1];
//    UIColor * color =[UIColor redColor];
    //设置填充和描边颜色
//    [color setFill];
//    CGContextFillPath(context);
//    [[UIColor whiteColor]setStroke];
//    CGContextStrokePath(context);
    
    /*
     圆角矩形
     坑：如果不用CGRectInset，则白色边框会模糊（猜测：在进行填充时，会影响边框）
     CGRectInset使用：平移且缩小
     */
    
    //赛贝尔曲线
    UIBezierPath * path =[UIBezierPath bezierPathWithRoundedRect:CGRectInset(rect, 1, 1) cornerRadius:rect.size.height/2];
//    UIBezierPath* path = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius: rect.size.height/2];
    //指定位置圆角矩形
    //    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:UIRectCornerTopLeft cornerRadii:CGSizeMake(30, 30)];
    //设置描边颜色
    [[UIColor whiteColor] setStroke];
    path.lineWidth = 1;
    [color setFill];
    //设置描边和填充
    [path fill];
    [path stroke];
    
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
    style.alignment = NSTextAlignmentCenter;
    NSDictionary *attr = @{NSParagraphStyleAttributeName:style,
                           NSFontAttributeName:[UIFont systemFontOfSize:24.0f],
                           NSForegroundColorAttributeName:[UIColor whiteColor]
                           };
    CGSize size = [btnTitle sizeWithAttributes:attr];
    CGRect r = CGRectMake(rect.origin.x, rect.origin.y + (rect.size.height - size.height)/2.0, rect.size.width, size.height);
    [btnTitle drawInRect:r withAttributes:attr];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    self.btnClickBlock();
}
@end
