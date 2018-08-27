//
//  SpringHeaderViewController.m
//  CoreAdvancedAnimation
//
//  Created by mac on 2018/8/27.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "SpringHeaderViewController.h"
#import "WTSpringHeaderView.h"
#import "UIScrollView+WTSpringHeader.h"
#import <WebKit/WebKit.h>

@interface SpringHeaderViewController ()

@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, strong) WTSpringHeaderView *headerView;

@end

@implementation SpringHeaderViewController

-(void)dealloc
{
    [self.webView.scrollView removeObserver:self.webView.scrollView forKeyPath:@"contentOffset"];
    NSLog(@"释放监听者");
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor whiteColor];
    self.webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, kWindowWidth, kWindowHeight)];
    self.webView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.webView];
    
    NSURL * url = [NSURL URLWithString:@"https://github.com/Goddreamwt"];
    NSMutableURLRequest *re = [NSMutableURLRequest requestWithURL:url];
    [self.webView loadRequest:re];
    
    //初始化header
    self.headerView.headerImage = [UIImage imageNamed:@"saber"];
    self.headerView.title = @"十二指环的技术博客";
    self.headerView.isShowLeftBtn = YES;
    self.headerView.isShowRightBtn = YES;
    __weak typeof(self) weakSelf = self;
    self.headerView.leftClickBlock = ^(UIButton *btn){
        [weakSelf.navigationController popViewControllerAnimated:YES];
    };
    self.headerView.rightClickBlock  = ^(UIButton *btn){
        NSLog(@"点击了分享");
    };
    
    [self.webView.scrollView handleSpringHeadView:self.headerView];
}


#pragma mark - Getter

-(WTSpringHeaderView *)headerView
{
    if (!_headerView)
    {
        _headerView = [[WTSpringHeaderView alloc] initWithFrame:CGRectMake(0, 0, kWindowWidth, kWindowWidth/2)];
        [self.view addSubview:_headerView];
    }
    
    return _headerView;
}

@end
