//
//  GesturePasswordView.h
//  Loans
//
//  Created by 耿大帅 on 2016/11/1.
//  Copyright © 2016年 Huoqiwang. All rights reserved.
//

#import <UIKit/UIKit.h>

/*
 * 手势密码的模式
 */
typedef enum {
    AlertPasswordModel,    // 修改密码 (需要先输入老密码)
    SetPasswordModel,      // 重置密码（无论存不存老密码都一并删除，再重新设置密码）
    ValidatePasswordModel, // 验证密码 (输入一遍，进行验证)
    DeletePasswordModel,   // 删除密码
    NoneModel
} GestureModel;

typedef void (^PasswordBlock) (NSString *passwordString);

@interface GesturePasswordView : UIView
/*
 * 手势密码的模式
 */
@property (nonatomic, assign) GestureModel gestureModel;

/*
 * 手势密码的回调
 */
@property (nonatomic, strong) PasswordBlock gesturePasswordBlock;

@end
