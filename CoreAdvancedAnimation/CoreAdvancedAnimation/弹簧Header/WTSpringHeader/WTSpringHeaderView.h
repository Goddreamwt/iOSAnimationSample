//
//  WTSpringHeaderView.h
//  CoreAdvancedAnimation
//
//  Created by mac on 2018/8/27.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^LeftClickBlock)(UIButton *btn);
typedef void(^RightClickBlock) (UIButton *btn);

@interface WTSpringHeaderView : UIView

/** 头部图片  **/
@property(nonatomic,strong)UIImage * headerImage;
/** 头部标题  **/
@property(nonatomic,copy)NSString * title;
/** 是否显示返回按钮  **/
@property(nonatomic,assign)BOOL isShowLeftBtn;
/** 是否显示更多按钮  **/
@property(nonatomic,assign)BOOL isShowRightBtn;
/** 点击返回按钮回调  **/
@property(nonatomic,copy)LeftClickBlock leftClickBlock;
/** 点击更多按钮的回调  **/
@property(nonatomic,copy)RightClickBlock rightClickBlock;

@end
