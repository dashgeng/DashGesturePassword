//
//  GesturePasswordManager.h
//  Loans
//
//  Created by 耿大帅 on 2016/11/2.
//  Copyright © 2016年 Huoqiwang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "GesturePasswordView.h"

@interface GesturePasswordManager : NSObject

/**
 根据 key 将 object 的值设置到 Keychain 中
 
 @param object 要设置的值
 @param key 键
 */
+ (void)setObject:(id)object forKey:(id)key;

/**
 根据 key 检索并获取 Keychain 中相应的值
 
 @param key 键
 @return 返回检索到的值
 */
+ (id)objectForKey:(id)key;

/**
 根据 key 检索并删除 Keychain 中相应的值
 
 @param key 键
 */
+ (void)removeObjectForKey:(id)key;

#pragma mark - GesturePassword Method

/**
 是否存有手势密码
 
 @return 返回判断结果 YES: 是  NO: 否
 */
+ (BOOL)isHaveGesturePassword;

/**
 判断是否为第一次输入手势密码
 
 @param gesturePasswordValue 待验证的手势密码
 @return 返回判断结果 YES: 是  NO: 否
 */
+ (BOOL)isFirstDraw:(NSString *)gesturePasswordValue;

/**
 判断是否为第二次输入手势密码
 
 @param gesturePasswordValue 待验证的手势密码
 @return 返回判断结果 YES: 是  NO: 否
 */
+ (BOOL)isSecondRightDraw:(NSString *)gesturePasswordValue;

/**
 忘记手势密码
 */
+ (void)forgotGesturePassword;

/**
 设置手势密码
 
 @param gesturePasswordValue 手势密码的值
 */
+ (void)setGesturePassword:(NSString *)gesturePasswordValue;

/**
 加载手势密码页面并设置手势密码
 
 @param viewController 请求加载手势密码页面的视图控制器
 */
- (void)setupGesturePassword:(UIViewController *)viewController;

/**
 验证手势密码
 
 @param viewController 请求加载的页面控制器
 */
- (void)validationGesturePassword:(UIViewController *)viewController;

@end
