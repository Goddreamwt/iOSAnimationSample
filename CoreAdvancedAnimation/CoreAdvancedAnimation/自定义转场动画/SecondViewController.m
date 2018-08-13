//
//  SecondViewController.m
//  CoreAdvancedAnimation
//
//  Created by mac on 2018/8/10.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UIImageView * bgView =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    bgView.image =[UIImage imageNamed:@"view1"];
    [self.view addSubview:bgView];
    
    UIButton *customTransitionBtn =[[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width -100,self.view.frame.size.height -100, 60, 60)];
    [customTransitionBtn setBackgroundColor:[UIColor redColor]];
    [customTransitionBtn.layer setMasksToBounds:YES];
    [customTransitionBtn.layer setCornerRadius:30];[customTransitionBtn addTarget:self action:@selector(customTransitionBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:customTransitionBtn];
    
}
-(void)customTransitionBtnClick:(UIButton *)btn{
    [self.navigationController popViewControllerAnimated:NO];
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
