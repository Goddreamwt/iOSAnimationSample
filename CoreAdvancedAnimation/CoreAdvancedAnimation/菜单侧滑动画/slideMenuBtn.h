//
//  slideMenuBtn.h
//  CoreAdvancedAnimation
//
//  Created by mac on 2018/8/8.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface slideMenuBtn : UIView

-(id)initWithTitle:(NSString *)title;

@property(nonatomic,copy)void (^btnClickBlock)(void);

@end
