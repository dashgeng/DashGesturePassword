//
//  GesturePasswordManager.m
//  Loans
//
//  Created by 耿大帅 on 2016/11/2.
//  Copyright © 2016年 Huoqiwang. All rights reserved.
//

#import "GesturePasswordManager.h"
#import "KeychainItemWrapper.h"
#import "LocalDataConst.h"

@implementation GesturePasswordManager

#pragma mark - Operation KeychainItemWrapper Method

/**
 根据 key 将 object 的值设置到 Keychain 中

 @param object 要设置的值
 @param key 键
 */
+ (void)setObject:(id)object forKey:(id)key {
    KeychainItemWrapper *keyChain = [[KeychainItemWrapper alloc] initWithIdentifier:[NSString stringWithFormat:@"a%@&&a", key] accessGroup:nil];
    [keyChain setObject:object forKey:(__bridge id)kSecAttrAccount];
}

/**
 根据 key 检索并获取 Keychain 中相应的值

 @param key 键
 @return 返回检索到的值
 */
+ (id)objectForKey:(id)key {
    KeychainItemWrapper *keyChain = [[KeychainItemWrapper alloc] initWithIdentifier:[NSString stringWithFormat:@"a%@&&a", key] accessGroup:nil];
    id object = [keyChain objectForKey:(__bridge id)kSecAttrAccount];
    return object;
}

/**
 根据 key 检索并删除 Keychain 中相应的值

 @param key 键
 */
+ (void)removeObjectForKey:(id)key {
    KeychainItemWrapper *keyChain = [[KeychainItemWrapper alloc] initWithIdentifier:[NSString stringWithFormat:@"a%@&&a", key] accessGroup:nil];
    [keyChain resetKeychainItem];
}

#pragma mark - GesturePassword Method

/**
 是否存有手势密码

 @return 返回判断结果 YES: 是  NO: 否
 */
+ (BOOL)isHaveGesturePassword {
    NSString *gesturePasswordValue = [self objectForKey:LocalGesturePassword];
    if (gesturePasswordValue &&
        gesturePasswordValue.length > 0 &&
        [gesturePasswordValue isKindOfClass:[NSString class]]) {
        return YES;
    }
    
    return NO;
}

/**
 判断是否为第一次输入手势密码

 @param gesturePasswordValue 待验证的手势密码
 @return 返回判断结果 YES: 是  NO: 否
 */
+ (BOOL)isFirstDraw:(NSString *)gesturePasswordValue {
    NSString *oldGesturePasswordValue = [self objectForKey:LocalGesturePassword];
    if (oldGesturePasswordValue &&
        oldGesturePasswordValue.length > 0 &&
        [oldGesturePasswordValue isKindOfClass:[NSString class]]) {
        return NO;
    }
    
    [self setObject:gesturePasswordValue forKey:LocalGesturePassword];
    return YES;
}

/**
 判断是否为第二次输入手势密码

 @param gesturePasswordValue 待验证的手势密码
 @return 返回判断结果 YES: 是  NO: 否
 */
+ (BOOL)isSecondRightDraw:(NSString *)gesturePasswordValue {
    NSString *oldGesturePasswordValue = [self objectForKey:LocalGesturePassword];
    
    if ([oldGesturePasswordValue isKindOfClass:[NSNull class]]) {
        return NO;
    } else if (!oldGesturePasswordValue ||
               oldGesturePasswordValue.length < 1 ||
               ![oldGesturePasswordValue isKindOfClass:[NSString class]]) {
        return NO;
    } else if (oldGesturePasswordValue.length == gesturePasswordValue.length &&
               [oldGesturePasswordValue isEqualToString:gesturePasswordValue]) {
        return YES;
    }
    
    return NO;
}

/**
 忘记手势密码
 */
+ (void)forgotGesturePassword {
    [self removeObjectForKey:LocalGesturePassword];
}

/**
 设置手势密码

 @param gesturePasswordValue 手势密码的值
 */
+ (void)setGesturePassword:(NSString *)gesturePasswordValue {
    [self setObject:gesturePasswordValue forKey:LocalGesturePassword];
}

@end
