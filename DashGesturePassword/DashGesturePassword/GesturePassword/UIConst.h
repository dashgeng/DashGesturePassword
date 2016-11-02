//
//  UIConst.h
//  Loans
//
//  Created by 耿大帅 on 16/10/31.
//  Copyright © 2016年 Huoqiwang. All rights reserved.
//

#ifndef UIConst_h
#define UIConst_h

/******************************************************************************
 *  用户界面(View)上的相关常量
 ******************************************************************************/

/**
 *  启动页到引导页
 */
static NSString * const SegueLaunchScreenToGuidePage = @"LaunchScreenToGuidePage";

/**
 *  启动页到手势密码页
 */
static NSString * const SegueLaunchScreenToGesturePassword = @"LaunchScreenToGesturePassword";

/**
 *  启动页到TabBar
 */
static NSString * const SegueLaunchScreenToTabBar = @"LaunchScreenToTabBar";


/******************************************************************************
 *  手势密码页面的相关常量
 ******************************************************************************/

/**
 *  九宫格中点的外部直径长度
 */
static const int ItemOutsideDiameter = 70;

/**
 *  九宫格中点的内部直径长度
 */
static const int ItemInternalDiameter = 20;

/**
 *  九宫格中点的边线宽度
 */
static const int ItemLineWidth = 1;

/**
 *  九宫格中每个点的宽高值
 */
static const int ItemWidthHeight = 70;

/**
 *  九宫格顶点位置 Y轴
 */
static const int ItemTopPosition = 250;

/**
 *  显示用小九宫格整体的宽高值
 */
static const int SubItemTotalWidthHeight = 50;

/**
 *  显示用小九宫格中每个点的宽高值
 */
static const int SubItemWidthHeight = 12;

/**
 *  显示用小九宫格顶点位置 Y轴
 */
static const int SubItemTopPosition = 80;

/**
 *  显示用小九宫格标签起始值
 */
static const int SubItemTag = 30;

#endif /* UIConst_h */
