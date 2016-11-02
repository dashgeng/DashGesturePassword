//
//  MacroConst.h
//  Loans
//
//  Created by 耿大帅 on 16/10/31.
//  Copyright © 2016年 Huoqiwang. All rights reserved.
//

#ifndef MacroConst_h
#define MacroConst_h

/******************************************************************************
 *  通用宏定义
 ******************************************************************************/

/**
 * 获取当前屏幕宽度（非像素）
 */
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

/**
 * 获取当前屏幕高度（非像素）
 */
#define kScreenWidth  [UIScreen mainScreen].bounds.size.width

/******************************************************************************
 *  手势密码页面相关宏定义
 ******************************************************************************/

/**
 * 手势密码页面背景色  深蓝色
 */
#define kGesturePasswordViewBackgroundColor [UIColor colorWithRed:84/255.0 green:155/255.0 blue:204/255.0 alpha:1.0]

/**
 * 手势密码页面九宫格的点被选中的颜色  深蓝色
 */
#define kPointSelectColor [UIColor colorWithRed:0.13 green:0.7 blue:0.96 alpha:1]

/**
 * 手势密码页面九宫格的点选择错的颜色  红色
 */
#define kPointWrongColor [UIColor colorWithRed:1 green:0 blue:0 alpha:1]

/**
 * 手势密码页面错误提示和的颜色  浅红色
 */
#define kWrongInfoColor [UIColor colorWithRed:0.94 green:0.31 blue:0.36 alpha:1]

#endif /* MacroConst_h */
