//
//  UILabel+MoneyAnimation.m
//  CoreAdvancedAnimation
//
//  Created by mac on 2018/8/13.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "UILabel+MoneyAnimation.h"
#import <objc/runtime.h>

//每次数字跳动相差的间隔数
#define kRangeNumberKey @"RangeKey"
//起始数字
#define kBeginNumberKey @"BeginNumberKey"
//结束跳动时的数字
#define kEndNumberKey @"EndNumberKey"
//数字跳动频率
#define kFrequency 1.0/30.0f
#define kRangeNumber(endNumber,duration) (endNumber * kFrequency)/duration

@interface UILabel()
@property (nonatomic, strong) NSNumber *animatedNumber;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) NSString *valueString;
@end

@implementation UILabel (MoneyAnimation)

/** 由于分类中要添加属性，所以通过runtime方法来实现 */
- (void)setAnimatedNumber:(NSNumber *)animatedNumber {
    objc_setAssociatedObject(self, "animatedNumber", animatedNumber, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSNumber *)animatedNumber {
    return objc_getAssociatedObject(self, "animatedNumber");
}

- (void)setTimer:(NSTimer *)timer {
    objc_setAssociatedObject(self, "timer", timer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSTimer *)timer {
    return objc_getAssociatedObject(self, "timer");
}

- (void)setValueString:(NSString *)valueString {
    objc_setAssociatedObject(self, "valueString", valueString, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)valueString {
    return objc_getAssociatedObject(self, "valueString");
}

-(void)wt_setNumber:(NSNumber *)number{
    [self wt_setNumber:number duration:1.0];
}

- (void)wt_setTextPageAnimation:(NSString *)text direction:(AnimationDirection)direction{
    UILabel *auxLabel = [[UILabel alloc] initWithFrame:self.frame];
    auxLabel.text = text;
    auxLabel.font = self.font;
    auxLabel.textAlignment = self.textAlignment;
    auxLabel.textColor = self.textColor;
    auxLabel.backgroundColor = self.backgroundColor;
    //    auxLabel.backgroundColor = [UIColor redColor];
    //offset
    CGFloat auxLabelOffset = (CGFloat)direction *
    auxLabel.frame.size.height/2.0;
    auxLabel.transform = CGAffineTransformScale(CGAffineTransformMakeTranslation(0.0, auxLabelOffset), 1.0, 0.1);
    [self.superview addSubview:auxLabel];
    [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        auxLabel.transform = CGAffineTransformIdentity;
        self.transform =  CGAffineTransformScale(CGAffineTransformMakeTranslation(0.0, -auxLabelOffset), 1.0, 0.1);
    } completion:^(BOOL finished) {
        self.text = auxLabel.text;
        self.transform = CGAffineTransformIdentity;
        [auxLabel removeFromSuperview];
    }];
}


- (void)wt_setNumber:(NSNumber *)number duration:(NSTimeInterval)duration{
    [self.timer invalidate];
    self.timer = nil;

    //变量初始化
    self.animatedNumber = @(0);
    double beginNumber = 0;
    double endNumber = [number doubleValue];
        
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionaryWithCapacity:0];
        
    [userInfo setObject:@(beginNumber) forKey:kBeginNumberKey];
    [userInfo setObject:number forKey:kEndNumberKey];
    [userInfo setObject:@(kRangeNumber(endNumber, duration)) forKey:kRangeNumberKey];
    // 添加定时器，添加到NSRunLoop中
    self.timer = [NSTimer scheduledTimerWithTimeInterval:kFrequency target:self selector:@selector(changeAnimation:) userInfo:userInfo repeats:YES];

    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)changeAnimation:(NSTimer *)timer{
    
    NSMutableDictionary *info = timer.userInfo;
    double begin = (int)[info objectForKey:kBeginNumberKey];
    double end = ((NSNumber *)[info objectForKey:kEndNumberKey]).doubleValue;
    double range = ((NSNumber *)[info objectForKey:kRangeNumberKey]).doubleValue;
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterNoStyle];
    [formatter setFormatWidth:9];
    [formatter setPositiveFormat:@",##0.00"];
    
    double value = self.valueString.doubleValue;
    
    if (value == 0) {
        self.valueString = [NSString stringWithFormat:@"%f", begin];
        self.text = [NSString stringWithFormat:@"%.@",[formatter stringFromNumber:@(begin)]];
    } else if (value >= end) {
        self.text = [NSString stringWithFormat:@"%.@",[formatter stringFromNumber:@(end)]];
        self.valueString = [NSString stringWithFormat:@"%f", begin];
        [self.timer invalidate];
        self.timer = nil;
        return;
    } else {
        value += range;
        self.valueString = [NSString stringWithFormat:@"%f", value];
        self.text = [NSString stringWithFormat:@"%.@",[formatter stringFromNumber:@(value)]];
        
    }
    
}
@end
