//
//  FishModelImageView.m
//  ShanHaiJing-Trip
//
//  Created by mac on 2018/8/16.
//  Copyright © 2018年 mac. All rights reserved.
//
//  鱼的模型
#import "FishModelImageView.h"
#import "UIView+Extension.h"
#import "GlobalDefine.h"

#define OffSetYRange  30 //波动范围

//模型鱼
NSString *const kModelFishAnimationKey = @"kModelFishAnimationKey";
NSString *const kModelFishAnimationValue = @"kModelFishAnimationValue";

@interface FishModelImageView()

@property (nonatomic, assign) FishModelImageViewType fishType;
@property (nonatomic, assign) FishModelImageViewDirection direction;
@property (nonatomic, strong) CAKeyframeAnimation *animation;
@property (nonatomic, assign) CGFloat mOffsetX,mOffsetY;//模型鱼的xy偏移量
@property (nonatomic, assign) double duration;
@property (nonatomic, assign) double speed; //速度
@property (nonatomic, assign) int randomRange;
@property (nonatomic, assign) CGFloat fishWidth; //自身的宽度
@property (nonatomic, assign) CGPoint initialPosition; //初始位置

@property (nonatomic, strong) CADisplayLink *linkTimer;

@property (nonatomic, assign) CGFloat changeX; //鱼 每1/60秒变化的距离

@property (nonatomic, strong) UIBezierPath *fishPath;//游走路径

@end
@implementation FishModelImageView

//初始化小鱼模型
- (instancetype)initModelFishWithType:(FishModelImageViewType)type andDirection:(FishModelImageViewDirection)dir{
    self.userInteractionEnabled = YES;
    if (self = [super init]){
        self.direction = dir;
        [self initViewWithType:type andDuration:1 andInitialPosition:CGPointMake(100, 100)];
        if (dir == FishModelImageViewFromLeft){//从左往右，默认所有的鱼都是从右往左
            self.transform = CGAffineTransformMakeScale(-1, 1); //镜像
        }
//        [self initModelViewAnimationPath];
    }
    return self;
}

//初始化小鱼 git动画时长
- (void)initViewWithType:(FishModelImageViewType)type andDuration:(double)time andInitialPosition:(CGPoint)initialPosition{
    
    self.fishType = type;
    switch (type) {
        case FishModelImageViewTypeXHY://小黄鱼
            self.duration = 6.0;
            self.frame = CGRectMake(0, 0, 35, 40); //鱼的大小要定义好
            self.center = CGPointMake(ScreenWidth/2, ScreenHeight/2);
            self.image = [UIImage animatedImageNamed:@"xhy" duration:time];
            break;
        case FishModelImageViewTypeSBY://石斑鱼
            self.duration = 7.0;
            self.frame = CGRectMake(0, 0, 50, 50);
            self.image = [UIImage animatedImageNamed:@"sby" duration:time];
            self.center = initialPosition;
            break;
        case FishModelImageViewTypeHSY://红杉鱼
            self.duration = 8.0;
            self.frame = CGRectMake(0, 0, 50, 40);
            self.image = [UIImage animatedImageNamed:@"hsy" duration:time];
            self.center = initialPosition;
            break;
        case FishModelImageViewTypeBWY://斑纹鱼
            self.duration = 8.5;
            self.frame = CGRectMake(0, 0, 65, 53);
            self.image = [UIImage animatedImageNamed:@"bwy" duration:time];
            self.center = initialPosition;
            break;
        case FishModelImageViewTypeSHY://珊瑚鱼
            self.duration = 9.0;
            self.frame = CGRectMake(0, 0, 55, 55);
            self.image = [UIImage animatedImageNamed:@"shy" duration:time];
            self.center = initialPosition;
            break;
        case FishModelImageViewTypeSY://鲨鱼
            self.duration = 11.0;
            self.frame = CGRectMake(0, 0, 145, 90);
            self.image = [UIImage animatedImageNamed:@"sy" duration:time];
            self.center = initialPosition;
            break;
    }
}
#pragma mark - 模型鱼
- (void)initModelViewAnimationPathForFinger{
   
}



#pragma mark - 模型鱼(路径动画)
- (void)initModelViewAnimationPath{
    
    //Y可变高度范围
    _randomRange = (int) (ScreenHeight - self.frame.size.height - OffSetYRange);
    
    _mOffsetX = self.frame.size.width;
    _mOffsetY = arc4random()%_randomRange + OffSetYRange;
    
    //计算速度
    self.speed = (ScreenWidth + _mOffsetX)/self.duration;
    
    //位移动画
    _animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    _fishPath = [UIBezierPath bezierPath];
    
    if (self.direction == FishModelImageViewFromLeft){
        CGFloat fromX = -_mOffsetX - arc4random()%100;//随机开始位置，避免鱼同时出现
        [_fishPath moveToPoint:CGPointMake(fromX, _mOffsetY)];
        [_fishPath addLineToPoint:CGPointMake(ScreenWidth + _mOffsetX, _mOffsetY)];
        
        _animation.duration = (ScreenWidth + _mOffsetX - fromX)/self.speed;
    }else {
        CGFloat fromX = ScreenWidth + arc4random()%100;
        [_fishPath moveToPoint:CGPointMake(fromX, _mOffsetY)];
        [_fishPath addLineToPoint:CGPointMake(-_mOffsetX, _mOffsetY)];
        _animation.duration = (fromX + _mOffsetX)/self.speed;
    }
    
    //移动路径
    _animation.path = _fishPath.CGPath;
    _animation.autoreverses = NO;
//    _animation.delegate = self;
    _animation.repeatCount = 1;
    _animation.calculationMode = kCAAnimationPaced;
    [_animation setValue:kModelFishAnimationValue forKey:kModelFishAnimationKey];
    [self.layer addAnimation:_animation forKey:kModelFishAnimationKey];
}

@end
