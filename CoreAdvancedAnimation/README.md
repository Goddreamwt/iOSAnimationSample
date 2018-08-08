## coreAnimation


![这里写图片描述](https://img-blog.csdn.net/20180806144935321?watermark/2/text/aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3d0ZGFzaw==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70)

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

##隐式动画


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

![这里写图片描述](https://img-blog.csdn.net/20180808103330390?watermark/2/text/aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3d0ZGFzaw==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70)

在iOS中，我们改变UIView中的frame，bound，conter分别对应改变layer中的frame，bound，position
anchorpoint是layer中的锚点，取的是单位坐标。默认的是在视图的中间位置（0.5,0.5）

![这里写图片描述](https://img-blog.csdn.net/20180808103959526?watermark/2/text/aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3d0ZGFzaw==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70)

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

![这里写图片描述](https://img-blog.csdn.net/20180808112601653?watermark/2/text/aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3d0ZGFzaw==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70)
