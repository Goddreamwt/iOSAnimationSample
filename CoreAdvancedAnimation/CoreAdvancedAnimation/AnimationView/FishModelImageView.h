//
//  FishModelImageView.h
//  ShanHaiJing-Trip
//
//  Created by mac on 2018/8/16.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,FishModelImageViewDirection){
    FishModelImageViewFromLeft,  //从左往右
    FishModelImageViewFromRight, //从右往左
};

typedef NS_ENUM(NSInteger,FishModelImageViewType){
    FishModelImageViewTypeXHY = 0, //小黄鱼
    FishModelImageViewTypeSBY = 1, //石斑鱼
    FishModelImageViewTypeHSY = 2, //红杉鱼
    FishModelImageViewTypeBWY = 3, //斑纹鱼
    FishModelImageViewTypeSHY = 4, //珊瑚鱼
    FishModelImageViewTypeSY  = 5, //鲨鱼
};

@interface FishModelImageView : UIImageView

/**
 初始化模型鱼
 
 @param type 鱼的种类
 @param dir 游动方向
 @return view
 */
- (instancetype)initModelFishWithType:(FishModelImageViewType)type andDirection:(FishModelImageViewDirection)dir;


@end
