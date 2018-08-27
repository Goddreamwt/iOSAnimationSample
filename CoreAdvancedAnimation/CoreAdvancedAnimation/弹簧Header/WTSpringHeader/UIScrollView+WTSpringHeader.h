//
//  UIScrollView+WTSpringHeader.h
//  CoreAdvancedAnimation
//
//  Created by mac on 2018/8/27.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WTSpringHeaderView.h"

#define kNavHeight 64
#define kWindowWidth        [UIScreen mainScreen].bounds.size.width
#define kWindowHeight       [UIScreen mainScreen].bounds.size.height

@interface UIScrollView (WTSpringHeader)

@property (nonatomic, weak) WTSpringHeaderView *headerView;
@property (nonatomic, weak) UIVisualEffectView *headerEffectView;
@property (nonatomic, weak) UILabel *titleLabel;

- (void)handleSpringHeadView:(WTSpringHeaderView *)view;

@end
