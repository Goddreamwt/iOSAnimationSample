//
//  UIScrollView+WTSpringHeader.m
//  CoreAdvancedAnimation
//
//  Created by mac on 2018/8/27.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "UIScrollView+WTSpringHeader.h"
#import <objc/runtime.h>

@implementation UIScrollView (WTSpringHeader)

static char WTHeaderView;
static char WTHeaderEffectView;
static char WTTitleLabel;

-(void)setHeaderView:(WTSpringHeaderView *)headerView
{
    objc_setAssociatedObject(self, &WTHeaderView,
                             headerView,
                             OBJC_ASSOCIATION_ASSIGN);
}

-(WTSpringHeaderView *)headerView
{
    return objc_getAssociatedObject(self, &WTHeaderView);
}

-(void)setHeaderEffectView:(UIVisualEffectView *)headerEffectView
{
    objc_setAssociatedObject(self, &WTHeaderEffectView,
                             headerEffectView,
                             OBJC_ASSOCIATION_ASSIGN);
}
-(UIVisualEffectView *)headerEffectView
{
    return objc_getAssociatedObject(self, &WTHeaderEffectView);
}


-(void)setTitleLabel:(UILabel *)titleLabel
{
    objc_setAssociatedObject(self, &WTTitleLabel,
                             titleLabel,
                             OBJC_ASSOCIATION_ASSIGN);
    
}


-(UILabel *)titleLabel
{
    return objc_getAssociatedObject(self, &WTTitleLabel);
    
}

- (void)handleSpringHeadView:(WTSpringHeaderView *)view
{
    self.contentInset = UIEdgeInsetsMake(view.bounds.size.height, 0, 0, 0);
    view.frame = CGRectMake(0, -view.bounds.size.height, view.bounds.size.width, view.bounds.size.height);
    self.headerView = view;
    [view.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if ([obj isKindOfClass:[UIVisualEffectView class]])
        {
            self.headerEffectView = obj;
            
        }
        
        if ([obj isKindOfClass:[UILabel class]])
        {
            self.titleLabel = obj;
        }
        
    }];
    
    //使用kvo监听scrollView的滚动
    [self addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    [self yl_scrollViewDidScroll:self];
}

- (void)yl_scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    CGFloat offsetY = scrollView.contentOffset.y;
    
    if (offsetY>=-kNavHeight)
    {
        offsetY=-kNavHeight;
        
        if (self.headerView.frame.size.height!=kNavHeight)
        {
            self.headerView.frame = CGRectMake(0, 0, self.headerView.bounds.size.width, kNavHeight);
            [UIView animateWithDuration:0.25 animations:^{
                self.titleLabel.frame = CGRectMake(35, 20, self.bounds.size.width-35*2, 44);
                self.titleLabel.alpha = 1;
            }];
        }
        
    }else
    {
        self.headerView.frame = CGRectMake(0, 0, self.headerView.bounds.size.width, -offsetY);
        if (self.titleLabel.alpha!=0)
        {
            [UIView animateWithDuration:0.25 animations:^{
                self.titleLabel.frame = CGRectMake(35, 40, self.bounds.size.width-35*2, 44);
                self.titleLabel.alpha = 0;
            }];
            
        }
        
    }
    
    CGFloat alpha ;
    
    if (self.headerView.frame.size.height>=kWindowWidth/2)
    {
        alpha = 0;
        
    }else
    {
        alpha = 1-((self.headerView.frame.size.height-kNavHeight)/(kWindowWidth/2-kNavHeight));
    }
    
    if (alpha>=0&&alpha<=1)
    {
        self.headerEffectView.alpha = alpha;
    }
    
    
}

@end
