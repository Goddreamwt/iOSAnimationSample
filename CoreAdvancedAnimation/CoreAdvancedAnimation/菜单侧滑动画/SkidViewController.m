//
//  SkidViewController.m
//  CoreAdvancedAnimation
//
//  Created by mac on 2018/8/8.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "SkidViewController.h"
#import "slideMenuView.h"

@interface SkidViewController ()
@property(nonatomic,strong)slideMenuView *menuView;
@property(nonatomic,strong)UIButton *showBtn;
@end

@implementation SkidViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor whiteColor];
     _menuView = [[slideMenuView alloc] initWithBtnTitle:@[@"视频", @"图片", @"设置", @"我的", @"退出"]];
    _showBtn =[[UIButton alloc]initWithFrame:CGRectMake(300, 500, 100, 40)];
    [_showBtn setBackgroundColor:[UIColor grayColor]];
    [_showBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_showBtn setTitle:@"点击滑动" forState:UIControlStateNormal];
    [self.view addSubview:_showBtn];
    
}
-(void)btnClick:(UIButton *)btn{
    [_menuView switchAcition];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
