//
//  ViewController.m
//  CoreAdvancedAnimation
//
//  Created by mac on 2018/8/7.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "ViewController.h"
#import "HiddenAnimationViewController.h"
#import "JitterViewController.h"
#import "TransitionViewController.h"
#import "SkidViewController.h"
#import "LinkViewController.h"
#import "MatchstickMenViewController.h"
#import "SublayerViewController.h"
#import "CustomTransitionViewController.h"
#import "NumberAnimationViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor whiteColor];
   
    CGFloat width =100;
    CGFloat height = 20;
    CGFloat l_space = 20;
    CGFloat v_space = 20;
    CGFloat top = 80;
    
    
    UIButton * hiddenBtn =[[UIButton alloc]initWithFrame:CGRectMake(l_space, top, width, height)];
    [self createButton:hiddenBtn setTitle:@"隐式动画" addAction:@selector(hiddenBtnClick:)];
    
    UIButton * jitterBtn =[[UIButton alloc]initWithFrame:CGRectMake(l_space+width+l_space, top, width, height)];
    [self createButton:jitterBtn setTitle:@"关键帧动画" addAction:@selector(jitterBtnClick:)];
    
    UIButton * transition =[[UIButton alloc]initWithFrame:CGRectMake(l_space+(width+l_space)*2, top, width, height)];
    [self createButton:transition setTitle:@"转场动画" addAction:@selector(transitionClick:)];
    
    UIButton * skid =[[UIButton alloc]initWithFrame:CGRectMake(l_space, top+height+v_space, width, height)];
    [self createButton:skid setTitle:@"侧滑动画" addAction:@selector(skidClick:)];
    
    UIButton * likeBtn =[[UIButton alloc]initWithFrame:CGRectMake(l_space+width+l_space, top+height+v_space, width, height)];
    [self createButton:likeBtn setTitle:@"点赞动画" addAction:@selector(likeBtnClick:)];
    
    UIButton * matchstickMenBtn =[[UIButton alloc]initWithFrame:CGRectMake(l_space+width+l_space, top+height+v_space, width, height)];
    [self createButton:matchstickMenBtn setTitle:@"火柴人图形" addAction:@selector(matchstickMenBtnClick:)];
    
    UIButton * subLayerBtn =[[UIButton alloc]initWithFrame:CGRectMake(l_space+(width+l_space)*2, top+height+v_space, width, height)];
    [self createButton:subLayerBtn setTitle:@"子图层" addAction:@selector(subLayerBtnClick:)];
    
    UIButton *customTransitionBtn =[[UIButton alloc]initWithFrame:CGRectMake(l_space, top+(height+v_space)*2, width, height)];
    [self createButton:customTransitionBtn setTitle:@"自定义转场" addAction:@selector(customTransitionBtnClick:)];
    
    UIButton *numberAnimationBtn =[[UIButton alloc]initWithFrame:CGRectMake(l_space+width+l_space, top+(height+v_space)*2, width, height)];
    [self createButton:numberAnimationBtn setTitle:@"数字跳动" addAction:@selector(numberAnimationBtnClick:)];
}
-(void)createButton:(UIButton *)btn setTitle:(NSString *)title addAction:(SEL)action{
    [btn setTitle:title forState:UIControlStateNormal];
    [btn addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    btn.titleLabel.font =[UIFont systemFontOfSize:12.0];
    [btn setBackgroundColor:[UIColor grayColor]];
    [self.view addSubview:btn];
}
#pragma mark --隐式动画
-(void)hiddenBtnClick:(UIButton *)btn{
    HiddenAnimationViewController * controller =[[HiddenAnimationViewController alloc]init];
    [self.navigationController pushViewController:controller animated:NO];
}

#pragma mark --抖动效果-关键帧动画
-(void)jitterBtnClick:(UIButton *)btn{
    JitterViewController * controller =[[JitterViewController alloc]init];
    [self.navigationController pushViewController:controller animated:NO];
}

#pragma mark --转场动画
-(void)transitionClick:(UIButton *)btn{
    TransitionViewController * controller =[[TransitionViewController alloc]init];
    [self.navigationController pushViewController:controller animated:NO];
}

#pragma mark --侧滑
-(void)skidClick:(UIButton *)btn{
    SkidViewController * controller =[[SkidViewController alloc]init];
    [self.navigationController pushViewController:controller animated:NO];
}

#pragma mark --点赞
-(void)likeBtnClick:(UIButton *)btn{
    LinkViewController * controller =[[LinkViewController alloc]init];
    [self.navigationController pushViewController:controller animated:NO];
}

#pragma mark --赛贝尔绘制火柴人
-(void)matchstickMenBtnClick:(UIButton *)btn{
    MatchstickMenViewController * controller =[[MatchstickMenViewController alloc]init];
    [self.navigationController pushViewController:controller animated:NO];
}

#pragma mark --子图层(渐变+3D+富文本等)
-(void)subLayerBtnClick:(UIButton *)btn{
    SublayerViewController * controller =[[SublayerViewController alloc]init];
    [self.navigationController pushViewController:controller animated:NO];
}

#pragma mark --自定义转场动画
-(void)customTransitionBtnClick:(UIButton *)btn{
    CustomTransitionViewController * controller =[[CustomTransitionViewController alloc]init];
    [self.navigationController pushViewController:controller animated:NO];
}

#pragma mark --数字跳动动画
-(void)numberAnimationBtnClick:(UIButton *)btn{
    NumberAnimationViewController * controller =[[NumberAnimationViewController alloc]init];
    [self.navigationController pushViewController:controller animated:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
