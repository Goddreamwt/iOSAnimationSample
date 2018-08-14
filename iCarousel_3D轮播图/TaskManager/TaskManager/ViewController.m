//
//  ViewController.m
//  TaskManager
//
//  Created by mac on 2017/7/25.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "ViewController.h"
#import "iCarousel.h"

@interface ViewController ()<iCarouselDelegate,iCarouselDataSource>

@property (nonatomic,strong)iCarousel * carousel;
@property (nonatomic,assign)CGSize taskSize;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    CGFloat taskWidth = [UIScreen mainScreen].bounds.size.width * 5.0f /6.0f;
    self.taskSize = CGSizeMake(taskWidth,200);
//     taskWidth*16.0f/9.0f
    [self.view setBackgroundColor:[UIColor whiteColor]];
    self.carousel =[[iCarousel alloc]initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 200)];
    [self.view addSubview:self.carousel];
    [self.carousel setDelegate:self];
    [self.carousel setDataSource:self];
    [self.carousel setType:iCarouselTypeRotary];
    [self.carousel setBounceDistance:0.1f];
    
}

- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel{

    return 8;
}

-(UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view{

    UIView * taskView =view;
    if (!taskView) {
        taskView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.taskSize.width, self.taskSize.height)];
        UIImageView * imageView =[[UIImageView alloc]initWithFrame:taskView.bounds];
        [taskView addSubview:imageView];
        [imageView setContentMode:UIViewContentModeScaleAspectFill];
        [imageView setBackgroundColor:[UIColor whiteColor]];
        
        UIImage * taskImage =[UIImage imageNamed:[NSString stringWithFormat:@"%ld.png",(long)(index+1)]];
        [imageView setImage:taskImage];
        
        [taskView.layer setShadowPath:[UIBezierPath bezierPathWithRoundedRect:imageView.frame cornerRadius:5.0f].CGPath];
        [taskView.layer setShadowRadius:3.0f];
        [taskView.layer setShadowColor:[UIColor blackColor].CGColor];
        [taskView.layer setShadowOffset:CGSizeZero];
        CAShapeLayer *layer =[CAShapeLayer layer];
        [layer setFrame:imageView.bounds];
        [layer setPath:[UIBezierPath bezierPathWithRoundedRect:imageView.frame cornerRadius:5.0f].CGPath];
        [imageView.layer setMask:layer];
        
        
        UILabel * lable =[[UILabel alloc]initWithFrame:taskView.frame];
//        [lable setText:[@(index) stringValue]];
        [lable setFont:[UIFont systemFontOfSize:50]];
        [lable setTextAlignment:NSTextAlignmentCenter];
        [taskView addSubview:lable];
    }
    return taskView;
}

//计算缩放
-(CGFloat)calcScaleWithOffset:(CGFloat)offset{

    return offset * 0.04f + 1.0f;
}

//计算位移
-(CGFloat)calcTransLationWithOffset:(CGFloat)offset{

    CGFloat z = 5.0f/4.0f;
    CGFloat a = 5.0f/8.0f;
    
    //移出屏幕
    if (offset >=z/a) {
        
        return 2.0f;
    }
    
    return 1/(z-a*offset)-1/z;
}

-(CATransform3D)carousel:(iCarousel *)carousel itemTransformForOffset:(CGFloat)offset baseTransform:(CATransform3D)transform{

    CGFloat scale =[self calcScaleWithOffset:offset];
    CGFloat translation = [self calcTransLationWithOffset:offset];
    
    return CATransform3DScale(CATransform3DTranslate(transform, translation * self.taskSize.width, 0,offset), scale, scale, 0);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
