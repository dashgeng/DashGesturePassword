//
//  GesturePasswordItem.h
//  Loans
//
//  Created by 耿大帅 on 2016/11/1.
//  Copyright © 2016年 Huoqiwang. All rights reserved.
//

#import <UIKit/UIKit.h>

/*
 * 选择样式的模式
 */
typedef enum {
    wrongStyle,     // 错误模式
    selectStyle,    // 选中模式
    normalStyle     // 正常模式
} selectStyleModel;

@interface GesturePasswordItem : UIView

@property (nonatomic, assign) selectStyleModel model;
@property (nonatomic, strong) CAShapeLayer *innerLayer;
@property (nonatomic, strong) CAShapeLayer *outterLayer;
@property (nonatomic, strong) CAShapeLayer *triangleLayer;
@property (nonatomic, assign) BOOL isSelect;

- (void)judegeDirectionActionx1:(CGFloat)x1 y1:(CGFloat)y1 x2:(CGFloat)x2 y2:(CGFloat)y2 isHidden:(BOOL)isHidden;

@end
