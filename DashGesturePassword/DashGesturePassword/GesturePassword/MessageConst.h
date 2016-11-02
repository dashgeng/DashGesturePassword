//
//  MessageConst.h
//  Loans
//
//  Created by 耿大帅 on 16/10/31.
//  Copyright © 2016年 Huoqiwang. All rights reserved.
//

#ifndef MessageConst_h
#define MessageConst_h

/******************************************************************************
 *  页面显示相关常量
 ******************************************************************************/
/**
 *  请设置手势密码
 */
static NSString * const SetPassword = @"请绘制手势密码";

/**
 *  请设置手势密码
 */
static NSString * const ResetPassword = @"请再次绘制手势密码";

/**
 *  手势密码设置成功
 */
static NSString * const PasswordSuccess = @"手势密码设置成功";

/**
 *  密码错误，请再次绘制
 */
static NSString * const PasswordFailed = @"密码错误，请再次绘制";

/**
 *  密码错误，还可以再绘制n次
 */
static NSString *PasswordErrorCount = @"密码错误，还可以再绘制%d次";

/**
 *  至少连续绘制四个点
 */
static NSString * const PasswordWrong = @"至少连续绘制四个点";

/**
 *  请绘制原始手势密码
 */
static NSString * const InputOldPassword = @"请绘制原始手势密码";

/**
 *  请绘制新的手势密码
 */
static NSString * const InputNewPassword = @"请绘制新的手势密码";

/**
 *  验证密码
 */
static NSString * const ValidatePassword = @"验证手势密码";

/**
 *  手势密码验证成功
 */
static NSString * const ValidateSuccess = @"手势密码验证成功";

/**
 *  手势密码验证失败
 */
static NSString * const ValidationFailed = @"手势密码验证失败";

#endif /* MessageConst_h */
