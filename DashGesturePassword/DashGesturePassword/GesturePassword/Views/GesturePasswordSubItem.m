//
//  GesturePasswordSubItem.m
//  Loans
//
//  Created by 耿大帅 on 2016/11/1.
//  Copyright © 2016年 Huoqiwang. All rights reserved.
//

#import "GesturePasswordSubItem.h"
#import "MacroConst.h"
#import "UIConst.h"

@implementation GesturePasswordSubItem

#pragma mark - Init Methods

/**
 初始化视图对象
 
 @param frame 视图框架
 @return 返回初始化后的视图对象
 */
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initViews];
    }
    return self;
}

/**
 初始化页面
 */
- (void)initViews {
    for (int i = 0; i < 9; i++) {
        int row        = i / 3 ;
        int column     = i % 3 ;
        CGFloat x_or_y = (SubItemTotalWidthHeight - 3 * SubItemWidthHeight) / 4 ;
        CGFloat posX   = x_or_y * (column + 1) + column * SubItemWidthHeight ;
        CGFloat posY   = x_or_y * (row + 1) + row * SubItemWidthHeight ;
        
        UIView *myView = [[UIView alloc] initWithFrame:CGRectMake( posX, posY, SubItemWidthHeight, SubItemWidthHeight)];
        myView.tag = i + SubItemTag;
        [self addSubview:myView];
        [self drawCircle:myView color:[UIColor clearColor]];
    }
}

#pragma mark - Draw UI Methods

/**
 绘制圆形

 @param myView 页面
 @param color 颜色
 */
- (void)drawCircle:(UIView *)myView color:(UIColor *)color {
    if (color == [UIColor clearColor]) {
        myView.backgroundColor = [UIColor whiteColor];
    } else {
        myView.backgroundColor = color;
    }
    
    CAShapeLayer *shape = [CAShapeLayer layer];
    shape.frame = CGRectMake(1 , 1 , SubItemWidthHeight - 2, SubItemWidthHeight - 2);
    shape.fillColor = color.CGColor;
    if (color == [UIColor clearColor]) {
        shape.strokeColor = [UIColor whiteColor].CGColor;
    } else {
        shape.strokeColor = color.CGColor;
    }
    shape.lineWidth = 1;
    myView.layer.mask = shape;
    
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:shape.bounds];
    shape.path = path.CGPath;
}

/**
 返回数组

 @param array 数组
 @param color 填充颜色
 */
- (void)resultArr:(NSArray *)array fillColor:(UIColor *)color {
    [self.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
        if ([array containsObject:[NSString stringWithFormat:@"%lu", (unsigned long)idx]]) {
            // 如果array里包含idx，填充为白色
            UIView *myView = (UIView *)[self viewWithTag:(idx + SubItemTag)];
            [self drawCircle:myView color:color];
            
            [self performSelector:@selector(drawCleanCircle:) withObject:myView afterDelay:2];
        }
    }];
}

/**
 绘制清空的圆形

 @param myView 页面
 */
- (void)drawCleanCircle:(UIView *)myView {
    [self drawCircle:myView color:[UIColor clearColor]];
}

@end
