//
//  UIControl+UIControl_XY.h
//  iOSanimation
//
//  Created by biyabi on 15/9/29.
//  Copyright © 2015年 caijunrong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>

@interface UIControl (UIBarButtonItem)
@property (nonatomic, assign) NSTimeInterval cjr_acceptEventInterval;// 可以用这个给重复点击加间隔
@end
