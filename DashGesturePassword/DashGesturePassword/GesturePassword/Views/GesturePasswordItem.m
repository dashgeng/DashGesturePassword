//
//  GesturePasswordItem.m
//  Loans
//
//  Created by 耿大帅 on 2016/11/1.
//  Copyright © 2016年 Huoqiwang. All rights reserved.
//

#import "GesturePasswordItem.h"
#import "MacroConst.h"
#import "UIConst.h"

@implementation GesturePasswordItem

#pragma mark - Init Methods

/**
 初始化视图对象
 
 @param frame 视图框架
 @return 返回初始化后的视图对象
 */
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initViewsss];
    }
    return self;
}

/**
 初始化页面
 */
- (void)initViewsss {
    [self.layer addSublayer:self.outterLayer];
    [self.layer addSublayer:self.innerLayer];
    [self.layer addSublayer:self.triangleLayer];
    self.triangleLayer.hidden = YES;
}

/**
 初始化内层

 @return 返回初始化后的 innerLayer
 */
- (CAShapeLayer *)innerLayer {
    if (_innerLayer == nil) {
        _innerLayer = [CAShapeLayer layer];
        _innerLayer.frame = CGRectMake((self.frame.size.width - ItemInternalDiameter) / 2, (self.frame.size.width - ItemInternalDiameter) / 2, ItemInternalDiameter, ItemInternalDiameter);
        _innerLayer.fillColor = [UIColor clearColor].CGColor;
        
        UIBezierPath *innerLayer = [UIBezierPath bezierPathWithOvalInRect:self.innerLayer.bounds];
        _innerLayer.path = innerLayer.CGPath;
    }
    return _innerLayer;
}

/**
 初始化外层

 @return 返回初始化后的 outterLayer
 */
- (CAShapeLayer *)outterLayer {
    if (_outterLayer == nil) {
        _outterLayer = [CAShapeLayer layer];
        _outterLayer.frame = CGRectMake((self.frame.size.width - ItemOutsideDiameter) / 2, (self.frame.size.width - ItemOutsideDiameter) / 2, ItemOutsideDiameter, ItemOutsideDiameter);
        _outterLayer.fillColor = kGesturePasswordViewBackgroundColor.CGColor;
        _outterLayer.strokeColor = [UIColor whiteColor].CGColor;
        _outterLayer.lineWidth = ItemLineWidth;
        
        UIBezierPath *outterLayer = [UIBezierPath bezierPathWithOvalInRect:self.outterLayer.bounds];
        _outterLayer.path = outterLayer.CGPath;
    }
    return _outterLayer;
}

/**
 初始化三角层
 
 @return 返回初始化后的 triangleLayer
 */
- (CAShapeLayer *)triangleLayer {
    if (_triangleLayer == nil) {
        _triangleLayer = [CAShapeLayer layer];
        _triangleLayer.frame = CGRectZero;
        _triangleLayer.fillColor = kPointSelectColor.CGColor;
        
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint:CGPointMake(self.frame.size.width / 2, self.innerLayer.frame.origin.y - 10)];
        [path addLineToPoint:CGPointMake(self.frame.size.width / 2 - 5, self.innerLayer.frame.origin.y - 3)];
        [path addLineToPoint:CGPointMake(self.frame.size.width / 2 + 5, self.innerLayer.frame.origin.y - 3)];
        _triangleLayer.path = path.CGPath;
    }
    return _triangleLayer;
}

#pragma mark - Set UI Methods

/**
 设置模式

 @param model 模式
 */
- (void)setModel:(selectStyleModel)model {
    switch (model) {
        case normalStyle:
            [self normalUI];
            break;
            
        case selectStyle:
            [self selectUI];
            break;
            
        case wrongStyle:
            [self wrongUI];
            break;
            
        default:
            break;
    }
}

/**
 正常模式的界面
 */
- (void)normalUI {
    self.innerLayer.fillColor    = [UIColor clearColor].CGColor;
    self.outterLayer.strokeColor = [UIColor whiteColor].CGColor;
}

/**
 选中模式的界面
 */
- (void)selectUI {
    self.innerLayer.fillColor    = kPointSelectColor.CGColor;
    self.outterLayer.strokeColor = kPointSelectColor.CGColor;
}

/**
 错误模式的界面
 */
- (void)wrongUI {
    self.innerLayer.fillColor    = kPointWrongColor.CGColor;
    self.outterLayer.strokeColor = kPointWrongColor.CGColor;
}

/**
 合法的方向操作

 @param x1 起点X轴坐标
 @param y1 起点Y轴坐标
 @param x2 终点X轴坐标
 @param y2 终点Y轴坐标
 @param isHidden 是否隐藏
 */
- (void)judegeDirectionActionx1:(CGFloat)x1 y1:(CGFloat)y1 x2:(CGFloat)x2 y2:(CGFloat)y2 isHidden:(BOOL)isHidden {
    if (isHidden) {
        self.triangleLayer.hidden = YES;
        return;
    }
    if (x1 == x2 && y1 == y2) {
        return;
    }
    if (x1 == 0 && y1 == 0) {
        return;
    }
    if (x2 == 0 && y2 == 0) {
        return;
    }
    if (self.triangleLayer.hidden == NO) {
        return;
    }
    
    self.triangleLayer.hidden = NO;
    CGFloat angle ;
    
    if (x1 < x2 && y1 > y2) {
        // 左上
        angle = M_PI_4;
    } else if (x1 < x2 && y1 == y2) {
        // 左
        angle = M_PI_2;
    } else if (x1 < x2 && y1 < y2) {
        // 左下
        angle = M_PI_4 * 3;
    } else if (x1 == x2 && y1 < y2) {
        // 下
        angle = M_PI;
    } else if (x1 > x2 && y1 < y2) {
        // 右下
        angle = -M_PI_4 * 3;
    } else if (x1 > x2 && y1 == y2) {
        // 右
        angle = -M_PI_2;
    } else if (x1 > x2 && y1 > y2) {
        // 右上
        angle = -M_PI_4 *3 ;
    } else {
        // 上
        angle = .0f;
    }
    
    //NSLog(@"..................... angle = [%f]", angle);
    self.transform = CGAffineTransformMakeRotation(angle);
}

@end
