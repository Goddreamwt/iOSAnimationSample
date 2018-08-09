## coreAnimation


![image](https://github.com/Goddreamwt/iOSAnimationSample/blob/master/image/QQ20180806-144917.png)

coreAnimation的功能包括绘图和动画

UIView：界面的展示以及用户的交互
layer：真正绘制

UIView封装了calayer

动画三步骤：
1.初始化动画对象
2.修改动画属性值
3.将动画添加到layer上面

在核心动画中一共有两个图层：模型图层和显示图层
presentationLayer负责显示

presentationLayer演示层

```
@property (strong, nonatomic) IBOutlet UIView *redView;

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
CGPoint p = [[touches anyObject] locationInView:_redView];
//presentationLayer
if (_redView.layer.presentationLayer == [_redView.layer hitTest:p]) {
NSLog(@"1");
}
//修改模型图层
_redView.frame = CGRectMake(50, 400, 100, 100);
CABasicAnimation * anim =[CABasicAnimation animation];
anim.keyPath = @"position.y";
//    anim.toValue = @400;
anim.duration = 1;
anim.removedOnCompletion=NO; //完成是否移除
//    anim.fillMode =kCAFillModeForwards;//保持最后的状态
//    anim.delegate =self;
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
```

## 隐式动画


默认时间0.25s，它的动画效果并不突兀

```
@property(strong,nonatomic)CALayer *layer;

- (void)viewDidLoad {
[super viewDidLoad];
CALayer * layer =[CALayer layer];
layer.frame = CGRectMake(100, 100, 100, 100);
layer.backgroundColor =[UIColor greenColor].CGColor;
_layer = layer;
[self.view.layer addSublayer:layer];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
_layer.frame =CGRectMake(100, 400, 100, 100);
_layer.backgroundColor =[UIColor orangeColor].CGColor;
}
```

关键帧动画-抖动效果
-----

```
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
```

##关键帧动画-过山车动画

注意：在做view旋转时，它的frame和bound是不一致的

![image](https://github.com/Goddreamwt/iOSAnimationSample/blob/master/image/QQ20180808-103305.png)

在iOS中，我们改变UIView中的frame，bound，conter分别对应改变layer中的frame，bound，position
anchorpoint是layer中的锚点，取的是单位坐标。默认的是在视图的中间位置（0.5,0.5）

![image](https://github.com/Goddreamwt/iOSAnimationSample/blob/master/image/QQ20180808-103950.png)

```
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
```

效果

![image](https://github.com/Goddreamwt/iOSAnimationSample/blob/master/image/%E6%95%88%E6%9E%9Cgif/car_gif.gif)

## CATransition

![image](https://github.com/Goddreamwt/iOSAnimationSample/blob/master/image/QQ20180808-141106.png)

核心代码

```
//转场动画:默认淡入淡出
CATransition *anim =[CATransition animation];
anim.type =@"suckEffect";//从父视图的左上角收缩
anim.startProgress =.5;//从动画进程的一半开始
anim.startProgress =.8;//从动画进程的百分之八十结束
[_imgView.layer addAnimation:anim forKey:nil];
```

## 动画组

在不使用动画组的情况下

```
//绘制贝塞尔曲线
UIBezierPath *path =[UIBezierPath bezierPath];
[path moveToPoint:CGPointMake(50, 500)];
[path addCurveToPoint:CGPointMake(350, 500) controlPoint1:CGPointMake(170, 400) controlPoint2:CGPointMake(220, 300) ];
//添加到layer
CAShapeLayer * shapeLayer =[CAShapeLayer layer];
shapeLayer.path = path.CGPath;
shapeLayer.fillColor = nil;
shapeLayer.strokeColor =[UIColor orangeColor].CGColor;
[self.view.layer addSublayer:shapeLayer];

//添加灰色方块
CALayer * colorLayer =[CALayer layer];
colorLayer.frame = CGRectMake(0, 0, 30, 30);
colorLayer.position = CGPointMake(50, 500);
colorLayer.backgroundColor =[UIColor grayColor].CGColor;
[self.view.layer addSublayer:colorLayer];

//添加关键帧动画
CAKeyframeAnimation * anim=[CAKeyframeAnimation animation];
anim.path = path.CGPath;
anim.keyPath =@"position";
anim.duration = 3;
[colorLayer addAnimation:anim forKey:nil];

//添加基础动画-动态改变颜色
CGFloat red =arc4random() /(CGFloat)INT_MAX;
CGFloat green =arc4random() /(CGFloat)INT_MAX;
CGFloat blue =arc4random() /(CGFloat)INT_MAX;
CABasicAnimation * basicAnim =[CABasicAnimation animation];
UIColor * color =[UIColor colorWithRed:red green:green blue:blue alpha:1];
basicAnim.keyPath =@"backgroundColor";
basicAnim.toValue = (id)color.CGColor;
basicAnim.duration = 3;
[colorLayer addAnimation:basicAnim forKey:nil];

//改变大小
CABasicAnimation * anim1 =[CABasicAnimation animation];
anim1.keyPath = @"transform.scale";
anim1.toValue =@.2;
anim1.duration = 3;
[colorLayer addAnimation:anim1 forKey:nil];
```

使用动画组

```
CAAnimationGroup * group =[CAAnimationGroup animation];
group.animations = @[anim1,anim,basicAnim];
group.duration = 3;
[colorLayer addAnimation:group forKey:nil];
```

优点是我们没必要写一些重复的属性.

效果图
![image](https://github.com/Goddreamwt/iOSAnimationSample/blob/master/image/%E6%95%88%E6%9E%9Cgif/groupAnim_gif.gif)

[gitHub代码示例](https://github.com/Goddreamwt/iOSAnimationSample/commit/9463d4e4c508030e801c58f36af9aa0c186cc7a0)

## 侧滑菜单栏动画
我们知道动画是基于绘制的，多次绘制贝塞尔的过程就会形成动画。流畅的动画效果会给用户带来不一样的使用体验，下面我们就让App开发中经常使用到的侧滑动画进行拆分详解。

效果图如下：

![image](https://github.com/Goddreamwt/iOSAnimationSample/blob/master/image/%E6%95%88%E6%9E%9Cgif/slider.gif)

为侧滑动画封装一个slideMenuView
绘制侧滑动画需要下面几个步骤

- 1.添加模糊背景

```
#define menuBlankWidth 50
#define menuBtnHeight 40
#define buttonSpace 30

#import "slideMenuView.h"
#import "slideMenuBtn.h"

@implementation slideMenuView{
UIVisualEffectView *blurView;
UIView *helperSideView;
UIView *helperCenterView;
UIWindow *keyWindow;
BOOL swiched;
CGFloat diff;
UIColor *menuColor;
CADisplayLink *displayLink;
NSInteger animationCount;
}

#pragma mark - lifeCycle
-(id)initWithBtnTitle:(NSArray *)btnTitles{

self =[super init];
if (self) {
menuColor =[UIColor colorWithRed:0 green:0.722 blue:1 alpha:1];
//将模糊背景添加到keyWindow上面，不会被遮挡
keyWindow =[UIApplication sharedApplication].keyWindow;
//灰色模糊背景
blurView =[[UIVisualEffectView alloc]initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleDark]];
blurView.frame = keyWindow.frame;
blurView.alpha = 0.5;

[keyWindow addSubview:self];

}
return self;
}
```

- 2.滑入菜单栏

```
#define menuBlankWidth 50
#define menuBtnHeight 40
#define buttonSpace 30

#import "slideMenuView.h"
#import "slideMenuBtn.h"

@implementation slideMenuView{
UIVisualEffectView *blurView;
UIView *helperSideView;
UIView *helperCenterView;
UIWindow *keyWindow;
BOOL swiched;
CGFloat diff;
UIColor *menuColor;
CADisplayLink *displayLink;
NSInteger animationCount;
}

#pragma mark - lifeCycle
-(id)initWithBtnTitle:(NSArray *)btnTitles{

self =[super init];
if (self) {
menuColor =[UIColor colorWithRed:0 green:0.722 blue:1 alpha:1];
//将模糊背景添加到keyWindow上面，不会被遮挡
keyWindow =[UIApplication sharedApplication].keyWindow;
//灰色模糊背景
blurView =[[UIVisualEffectView alloc]initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleDark]];
blurView.frame = keyWindow.frame;
blurView.alpha = 0.5;

//这是贝塞尔曲线绘制的蓝色矩形下面的背景View
self.frame = CGRectMake(-(CGRectGetWidth(keyWindow.frame)/2+menuBlankWidth), 0, CGRectGetWidth(keyWindow.frame)/2+menuBlankWidth, CGRectGetHeight(keyWindow.frame));
self.backgroundColor =[UIColor clearColor];

[keyWindow addSubview:self];

}
return self;
}
```
上面代码中的 `self.frame`设置的是下面图片中红色的背景View，它比蓝色弹出View多出menuBlankWidth的长度

![image](https://github.com/Goddreamwt/iOSAnimationSample/blob/master/image/QQ20180809-092905.png)
```
//绘制蓝色图层 贝塞尔曲线
-(void)drawRect:(CGRect)rect{
UIBezierPath *path =[UIBezierPath bezierPath];
//初始点 01点
[path moveToPoint:CGPointMake(0, 0)];
//绘制最上面的那条直线 02线
[path addLineToPoint:CGPointMake(CGRectGetWidth(keyWindow.frame)/2, 0)];
/*
一阶曲线
addQuadCurveToPoint终点位置，位于中间 03点
controlPoint  控制点 位于中间 03点
*/
[path addQuadCurveToPoint:CGPointMake(CGRectGetWidth(keyWindow.frame)/2, CGRectGetHeight(keyWindow.frame)) controlPoint:CGPointMake(CGRectGetWidth(keyWindow.frame)/2,  CGRectGetHeight(keyWindow.frame)/2)];
//绘制最下面的那条直线 04线
[path addLineToPoint:CGPointMake(0, CGRectGetHeight(keyWindow.frame))];
//05线 没必要画，可以使用贝塞尔闭合
[path closePath];//矩形绘画完毕

//获取上下文，相当于一个画板
CGContextRef context = UIGraphicsGetCurrentContext();
CGContextAddPath(context, path.CGPath);

//填充颜色-蓝色
[menuColor set];
CGContextFillPath(context);

//矩形绘制好后，如何让它动起来？
}
```
下图是上面代码根据贝塞尔曲线绘制的几个点线位置图
![image](https://github.com/Goddreamwt/iOSAnimationSample/blob/master/image/QQ20180809-092659.png)

- 3.思考：那么我们如何让蓝色的View右边框有类似于弹簧动画的效果呢？
通过2个辅助view helperSideView helperCenterView，求出它们的差值，获取到一组动态的数据

我们需要借助两个小的view在固定区域内做弹簧动画
![image](https://github.com/Goddreamwt/iOSAnimationSample/blob/master/image/QQ20180809-093916.png)
```
#pragma mark - lifeCycle
-(id)initWithBtnTitle:(NSArray *)btnTitles{

self =[super init];
if (self) {

代码略...
helperSideView =[[UIView alloc]initWithFrame:CGRectMake(-40, 0, 40, 40)];
helperSideView.backgroundColor =[UIColor greenColor];
helperCenterView = [[UIView alloc]initWithFrame:CGRectMake(-40, CGRectGetHeight(keyWindow.bounds)/2 -20, 40, 40)];
helperCenterView.backgroundColor =[UIColor orangeColor];
[keyWindow addSubview:helperSideView];
[keyWindow addSubview:helperCenterView];
[keyWindow insertSubview:self belowSubview:helperSideView];

}
return self;
}
```

```
#pragma mark -Action
//点击按钮
-(void)switchAcition{
if (!swiched) {
//1.添加模糊背景
[keyWindow insertSubview:blurView belowSubview:self];
//2.滑入菜单栏
//UIView的滑入动画
[UIView animateWithDuration:.3 animations:^{
//切换frame
self.frame = self.bounds;
}];
//3.添加弹簧动画
/*
Duration：持续时间
delay：延时
usingSpringWithDamping：弹簧阻力
initialSpringVelocity:弹簧的初始化速度
options:UIViewAnimationOptionBeginFromCurrentState:选项 动画选项从当前状态开始
completion:完成以后的操作
*/
[UIView animateWithDuration:.7 delay:0 usingSpringWithDamping:.5 initialSpringVelocity:.9 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
//让helperSideView滑至整屏的中心点位置
self->helperSideView.center = CGPointMake(self->keyWindow.center.x, CGRectGetHeight(self->helperSideView.bounds)/2);
} completion:nil];

[UIView animateWithDuration:.7 delay:0 usingSpringWithDamping:.5 initialSpringVelocity:.9 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
//让helperSideView滑至整屏的中心点位置
self->helperCenterView.center =self->keyWindow.center;
} completion:nil];
swiched = YES;
}else{
[self dismissView];
}
}

//消失
-(void)dismissView{
swiched = NO;
}
```

- 添加模糊背景层手势，使view恢复，然后我们看下效果

```
#pragma mark - lifeCycle
-(id)initWithBtnTitle:(NSArray *)btnTitles{

self =[super init];
if (self) {
省略代码...
//添加手势
UITapGestureRecognizer * tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissView)];
[blurView addGestureRecognizer:tap];
}
return self;
}
```

```
//消失
-(void)dismissView{
swiched = NO;
//消失时同样有一个动画
[UIView animateWithDuration:.3 animations:^{
//回到初始位置
self.frame = CGRectMake(-(CGRectGetWidth(self->keyWindow.frame)/2+menuBlankWidth), 0, CGRectGetWidth(self->keyWindow.frame)/2+menuBlankWidth, CGRectGetHeight(self->keyWindow.frame));
self->blurView.alpha = 0;
self->helperSideView.center = CGPointMake(-20, 20);
self->helperCenterView.center = CGPointMake(-20, CGRectGetHeight(self->keyWindow.bounds)/2);
}];
}
```
![image](https://github.com/Goddreamwt/iOSAnimationSample/blob/master/image/%E6%95%88%E6%9E%9Cgif/slide1.gif)

- CADisplayLink 求差值

修改两个小的view的阻力和初始化速度，那么它们两个之间会产生x差值

```
[UIView animateWithDuration:.7 delay:0 usingSpringWithDamping:.5 initialSpringVelocity:.9 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
//让helperSideView滑至整屏的中心点位置
self->helperSideView.center = CGPointMake(self->keyWindow.center.x, CGRectGetHeight(self->helperSideView.bounds)/2);
} completion:nil];

[UIView animateWithDuration:.7 delay:0 usingSpringWithDamping:.8 initialSpringVelocity:2 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
//让helperSideView滑至整屏的中心点位置
self->helperCenterView.center =self->keyWindow.center;
} completion:nil];
```

使用CADisplayLink类 类似于定时器，60次/进行绘制s

```
#pragma mark - func
//添加定时器
//CADisplayLink定时器获取差值
-(void)getDiff{
if (!displayLink) {
displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(displayLinkAuction:)];
//将displayLink添加到runLoop
[displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
}
}
-(void)displayLinkAuction:(CADisplayLink *)link{
//presentationLayer 实时layer数据
CALayer * layer1 = helperSideView.layer.presentationLayer;
CALayer * layer2 = helperCenterView.layer.presentationLayer;

//获取layer的frame
CGRect r1 = [[layer1 valueForKeyPath:@"frame"] CGRectValue];
CGRect r2 = [[layer2 valueForKeyPath:@"frame"] CGRectValue];

//获取二者之间的差值
diff = r1.origin.x - r2.origin.x;
}

#pragma mark -Action
//点击按钮
-(void)switchAcition{
if (!swiched) {
省略代码...
//获取差值
[self getDiff];

swiched = YES;
}else{
[self dismissView];
}
}
```

- 使用差值，利用赛贝尔曲线进行绘制

```
-(void)displayLinkAuction:(CADisplayLink *)link{
省略代码...
//获取二者之间的差值
diff = r1.origin.x - r2.origin.x;

//重绘
[self setNeedsDisplay];
}
```

```
-(void)drawRect:(CGRect)rect{
省略代码...
[path addQuadCurveToPoint:CGPointMake(CGRectGetWidth(keyWindow.frame)/2, CGRectGetHeight(keyWindow.frame)) controlPoint:CGPointMake(CGRectGetWidth(keyWindow.frame)/2 + diff,  CGRectGetHeight(keyWindow.frame)/2)];
省略代码...
}
```

![image](https://github.com/Goddreamwt/iOSAnimationSample/blob/master/image/%E6%95%88%E6%9E%9Cgif/slide2.gif)

记得在动画完成时，移除定时器

```
#pragma mark - func
//移除定时器
-(void)removeDisplayLink{
[displayLink invalidate];
displayLink = nil;
}
```

```
[UIView animateWithDuration:.7 delay:0 usingSpringWithDamping:.8 initialSpringVelocity:2 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
//让helperSideView滑至整屏的中心点位置
self->helperCenterView.center =self->keyWindow.center;
} completion:^(BOOL finished){
[self removeDisplayLink];
}];
```

- 添加按钮，并给按钮添加动画

```
#pragma mark - lifeCycle
-(id)initWithBtnTitle:(NSArray *)btnTitles{

self =[super init];
if (self) {
省略代码... 
//添加按钮
[self addBtnTitles:btnTitles];
}
return self;
}
```

```
#pragma mark - func
-(void)addBtnAnim{
for (int i=0; i< self.subviews.count; i++) {
UIView *btn = self.subviews[i];
btn.transform = CGAffineTransformMakeTranslation(-100, 0);
[UIView animateWithDuration:.7 delay:i *(0.3/self.subviews.count) usingSpringWithDamping:.6 initialSpringVelocity:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
btn.transform = CGAffineTransformIdentity;
} completion:nil];
}
}

//添加按钮
-(void)addBtnTitles:(NSArray *)titles{
CGFloat space = (CGRectGetHeight(keyWindow.bounds)-titles.count * menuBtnHeight - (titles.count-1)*buttonSpace)/2;
for (int i=0; i < titles.count; i++) {
slideMenuBtn  *btn =[[slideMenuBtn alloc]initWithTitle:titles[i]];
btn.center = CGPointMake(CGRectGetWidth(keyWindow.bounds)/4, space + menuBtnHeight*i + buttonSpace*i);
btn.bounds = CGRectMake(0, 0, CGRectGetWidth(keyWindow.bounds)/2 - 20* 2, menuBtnHeight);
btn.btnClickBlock=^(){
NSLog(@"%@",titles[i]);
};
[self addSubview:btn];
}
}
```

```
#pragma mark -Action
//点击按钮
-(void)switchAcition{
if (!swiched) {
省略代码...
//获取差值
[self getDiff];
//添加按钮的动画
[self addBtnAnim];
swiched = YES;
}else{
[self dismissView];
}
}
```

[gitHub完整代码参考](https://github.com/Goddreamwt/iOSAnimationSample/commit/98b0f90cfa7297b5b9cfd49e8ee57694b325d54c)

