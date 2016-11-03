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

/*
 * 手势密码代理
 */
@protocol GesturePasswordManagerDelegate <NSObject>

/**
 手势密码验证失败的消息处理
 */
- (void)validationFailedMessage;

@end

@interface GesturePasswordManager : NSObject

/*
 * 手势密码代理的对象
 */
@property (nonatomic, weak) id<GesturePasswordManagerDelegate> delegate;

#pragma mark - Operation KeychainItemWrapper Method

+ (void)setObject:(id)object forKey:(id)key;

+ (id)objectForKey:(id)key;

+ (void)removeObjectForKey:(id)key;

#pragma mark - GesturePassword Method

+ (BOOL)isHaveGesturePassword;

+ (BOOL)isFirstDraw:(NSString *)gesturePasswordValue;

+ (BOOL)isSecondRightDraw:(NSString *)gesturePasswordValue;

+ (void)forgotGesturePassword;

+ (void)setGesturePassword:(NSString *)gesturePasswordValue;

#pragma mark - Call GesturePasswordView Method

- (void)setupGesturePassword:(UIViewController *)viewController;

- (void)validationGesturePassword:(UIViewController *)viewController;

@end
