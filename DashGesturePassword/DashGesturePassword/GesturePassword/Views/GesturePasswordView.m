//
//  GesturePasswordView.m
//  Loans
//
//  Created by 耿大帅 on 2016/11/1.
//  Copyright © 2016年 Huoqiwang. All rights reserved.
//

#import "GesturePasswordView.h"
#import "MacroConst.h"
#import "MessageConst.h"
#import "UIConst.h"
#import "GesturePasswordItem.h"
#import "GesturePasswordSubItem.h"
#import "GesturePasswordManager.h"

@interface GesturePasswordView()

@property (nonatomic, strong) NSMutableArray *pointList;
@property (nonatomic, strong) GesturePasswordSubItem *subItem;
@property (nonatomic, strong) UILabel *reminderLabel;
@property (nonatomic, assign) CGPoint lastPoint;
@property (nonatomic, assign) CGPoint movePoint;
@property (nonatomic) int validationCount;

@end

@implementation GesturePasswordView

#pragma mark - UIView Methods

/**
 绘制页面矩形

 @param rect 矩形
 */
- (void)drawRect:(CGRect)rect {
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    for (int i = 0; i < self.pointList.count; i++) {
        GesturePasswordItem *item = (GesturePasswordItem *)self.pointList[i];
        if (i == 0) {
            [path moveToPoint:item.center];
        } else {
            [path addLineToPoint:item.center];
        }
    }
    
    if (_movePoint.x != 0 &&
        _movePoint.y != 0 &&
        NSStringFromCGPoint(_movePoint)) {
        [path addLineToPoint:_movePoint];
    }
    [path setLineCapStyle:kCGLineCapRound];
    [path setLineJoinStyle:kCGLineJoinRound];
    [path setLineWidth:1.0f];
    [kPointSelectColor setStroke];
    [path stroke];
}

#pragma mark - Init Methods

/**
 初始化视图对象
 
 @param frame 视图框架
 @return 返回初始化后的视图对象
 */
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}

/**
 初始化页面
 */
- (void)initView {
    self.backgroundColor = kGesturePasswordViewBackgroundColor;
    self.subItem.backgroundColor = [UIColor clearColor];
    self.reminderLabel.backgroundColor = [UIColor clearColor];
    _lastPoint = CGPointMake(0, 0);
    // 设置验证次数
    _validationCount = 3;
    
    [self createNinePoint];
}

/**
 初始化 GesturePasswordSubItem
 
 @return 返回初始化后的 GesturePasswordSubItem
 */
- (GesturePasswordSubItem *)subItem {
    if (_subItem == nil) {
        _subItem = [[GesturePasswordSubItem alloc] initWithFrame:CGRectMake((self.frame.size.width - SubItemTotalWidthHeight) / 2, SubItemTopPosition, SubItemTotalWidthHeight, SubItemTotalWidthHeight)];
        [self addSubview:_subItem];
    }
    return _subItem;
}

/**
 初始化按钮数组

 @return 返回初始化后的按钮数组
 */
- (NSMutableArray *)pointList {
    if (_pointList == nil) {
        _pointList = [NSMutableArray array];
    }
    return _pointList;
}

/**
 初始化标签

 @return 返回初始化后的标签
 */
- (UILabel *)reminderLabel {
    if (_reminderLabel == nil) {
        _reminderLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.subItem.frame.origin.y + 50, kScreenWidth, 40)];
        _reminderLabel.textAlignment = NSTextAlignmentCenter;
        _reminderLabel.textColor = [UIColor whiteColor];
        _reminderLabel.text = SetPassword;
        [self addSubview:_reminderLabel];
    }
    return _reminderLabel;
}

#pragma mark - Touch Event

/**
 触摸事件开始

 @param touches 触摸
 @param event 事件
 */
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    CGPoint point = [self touchLocation:touches];
    [self isContainItem:point];
}

/**
 触摸点移动

 @param touches 触摸
 @param event 事件
 */
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesMoved:touches withEvent:event];
    CGPoint point = [self touchLocation:touches];
    [self isContainItem:point];
    [self touchMoveTriangleAction];
    [self setNeedsDisplay];
}

/**
 触摸结束

 @param touches 触摸
 @param event 事件
 */
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    [self touchEndAction];
    [self setNeedsDisplay];
}

#pragma mark - Total Method

/**
 *  九宫格上的九个点
 */
- (void)createNinePoint {
    for (int i = 0; i < 9; i++) {
        int row    = i / 3;
        int column = i % 3;
        
        CGFloat spaceFloat = (kScreenWidth - 3 * ItemWidthHeight) / 4;             // 每个item的间距是等宽的
        CGFloat pointX = spaceFloat * (column + 1) + ItemWidthHeight * column;       // 起点X
        CGFloat pointY = ItemTopPosition + ItemWidthHeight * row + spaceFloat * row; // 起点Y
        
        // 对每一个item的frame的布局
        GesturePasswordItem *item = [[GesturePasswordItem alloc] initWithFrame:CGRectMake( pointX, pointY, ItemWidthHeight, ItemWidthHeight)];
        item.userInteractionEnabled = YES;
        item.backgroundColor = [UIColor clearColor];
        item.isSelect = NO;
        item.tag = ItemTag + i;
        [self addSubview:item];
        
        //NSLog(@"item.frame = [%@]", NSStringFromCGPoint(item.center));
    }
}

/**
 触摸开始移动

 @param touches 触摸
 @return 移动后的点
 */
- (CGPoint)touchLocation:(NSSet *)touches {
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    _movePoint = point;
    return point;
}

/**
 判断是否移动到某个点上并设置状态

 @param point 坐标位置
 */
- (void)isContainItem:(CGPoint)point {
    for (GesturePasswordItem *item in self.subviews) {
        if (![item isKindOfClass:[GesturePasswordSubItem class]] &&
            [item isKindOfClass:[GesturePasswordItem class]]) {
            BOOL isContain = CGRectContainsPoint(item.frame, point);
            if (isContain && item.isSelect == NO) {
                [self.pointList addObject:item];
                item.isSelect = YES;
                item.model = selectStyle;
            }
        }
    }
}


/**
 绘制时设置三角
 */
- (void)touchMoveTriangleAction {
    NSString *resultData = [self getResultPassword];
    if (resultData && resultData.length > 0) {
        NSArray *resultArr = [resultData componentsSeparatedByString:@"A"];
        if ([resultArr isKindOfClass:[NSArray class]] &&
            resultArr.count > 2) {
            NSString *lastTag    = resultArr[resultArr.count - 1];
            NSString *lastTwoTag = resultArr[resultArr.count - 2];
            
            CGPoint lastP = CGPointMake(0.0f, 0.0f);
            CGPoint lastTwoP = CGPointMake(0.0f, 0.0f);
            GesturePasswordItem *lastItem;
            for (GesturePasswordItem *item in self.pointList) {
                if (item.tag - ItemTag == lastTag.intValue) {
                    lastP = item.center;
                }
                if (item.tag - ItemTag == lastTwoTag.intValue) {
                    lastTwoP = item.center;
                    lastItem = item;
                }
                
                CGFloat x1 = lastTwoP.x;
                CGFloat y1 = lastTwoP.y;
                CGFloat x2 = lastP.x;
                CGFloat y2 = lastP.y;
                
                [lastItem judegeDirectionActionx1:x1 y1:y1 x2:x2 y2:y2 isHidden:NO];
            }
        }
    }
}

/**
 触摸结束处理
 */
- (void)touchEndAction {
    for (GesturePasswordItem *item in self.pointList) {
        [item judegeDirectionActionx1:0 y1:0 x2:0 y2:0 isHidden:NO];
    }
    
    // if (判断格式少于4个点) [处理密码数据]
    if ([self judgeFormat]) {
       [self setGesturePassword:[self getResultPassword]];
    }
    
    // 数组清空
    [self.pointList removeAllObjects];
    
    // 选中样式
    for (GesturePasswordItem *item in self.subviews) {
        if (![item isKindOfClass:[GesturePasswordSubItem class]] &&
            [item isKindOfClass:[GesturePasswordItem class]]) {
            item.isSelect = NO;
            item.model = normalStyle;
            [item judegeDirectionActionx1:0 y1:0 x2:0 y2:0 isHidden:YES];
        }
    }
}

/**
 是否少于4个点的判断

 @return YES:不少于4个点  NO:少于4个点
 */
- (BOOL)judgeFormat {
    if (self.pointList.count <= 3) {
        // 不合法
        self.reminderLabel.textColor = kWrongInfoColor;
        self.reminderLabel.text      = PasswordWrong;
        [self shake:self.reminderLabel];
        return NO;
    }
    return YES;
}

/**
 对设置的手势密码进行处理

 @return 处理后的手势密码
 */
- (NSString *)getResultPassword {
    NSMutableString *resultData = [NSMutableString string];
    
    for (GesturePasswordItem *item in self.pointList) {
        if (![item isKindOfClass:[GesturePasswordSubItem class]] &&
            [item isKindOfClass:[GesturePasswordItem class]]) {
            [resultData appendString:@"A"];
            [resultData appendString:[NSString stringWithFormat:@"%ld", (long)item.tag - ItemTag]];
        }
    }
    
    return (NSString *)resultData;
}

#pragma mark - 处理修改，设置，登录的业务逻辑

/**
 手势密码的修改，设置，登录

 @param gesturePasswordValue 用户设置的手势密码
 */
- (void)setGesturePassword:(NSString *)gesturePasswordValue {
    // 默认为蓝色
    UIColor *color = kPointSelectColor;
    // 没有任何记录，第一次登录
    BOOL isSaved = [GesturePasswordManager isFirstDraw:gesturePasswordValue];
    if (isSaved) {
        // 第一次输入之后，显示的文字
        self.reminderLabel.text = ResetPassword;
        self.reminderLabel.textColor = [UIColor whiteColor];
    } else {
        // 密码已经存在
        if (self.gestureModel == SetPasswordModel) {
            // 设置密码
            color = [self setPasswordJudgeAction:color value:gesturePasswordValue];
        } else if (self.gestureModel == AlertPasswordModel) {
            // 修改密码
            color = [self alertPasswordJudgeAction:color value:gesturePasswordValue];
        } else if (self.gestureModel == ValidatePasswordModel) {
            // 验证密码
            color = [self validatePasswordJudgeAction:color value:gesturePasswordValue];
        }
    }
    
    // 设置小九宫格的颜色
    [self.subItem resultArr:(NSArray *)[gesturePasswordValue componentsSeparatedByString:@"A"] fillColor:color];
}

/**
 设置手势密码
 
 @param color 错误提示颜色
 @param gesturePasswordValue 手势密码
 @return 返回验证后的错误提示颜色
 */
- (UIColor *)setPasswordJudgeAction:(UIColor *)color value:(NSString *)gesturePasswordValue {
    BOOL isRight = [GesturePasswordManager isSecondRightDraw:gesturePasswordValue];
    if (isRight) {
        // 验证成功
        self.reminderLabel.text = PasswordSuccess;
        self.reminderLabel.textColor = [UIColor whiteColor];
        NSString *resultData = PasswordSuccess;
        [self performSelector:@selector(blockAction:) withObject:resultData afterDelay:.5];
    } else {
        // 失败
        self.reminderLabel.text = PasswordFailed;
        self.reminderLabel.textColor = kWrongInfoColor;
        [self shake:self.reminderLabel];
        color = kWrongInfoColor;
    }
    return color;
}

/**
 修改手势密码

 @param color 错误提示颜色
 @param gesturePasswordValue 手势密码
 @return 返回验证后的错误提示颜色
 */
- (UIColor *)alertPasswordJudgeAction:(UIColor *)color value:(NSString *)gesturePasswordValue {
    BOOL isValidate = [GesturePasswordManager isSecondRightDraw:gesturePasswordValue];
    if (isValidate) {
        // 如果验证成功
        [GesturePasswordManager forgotGesturePassword];
        self.reminderLabel.text = InputNewPassword;
        self.reminderLabel.textColor = [UIColor whiteColor];
        _gestureModel = SetPasswordModel;
    } else {
        // 验证失败
        self.reminderLabel.text = PasswordFailed;
        self.reminderLabel.textColor = kWrongInfoColor;
        [self shake:self.reminderLabel];
        color = kWrongInfoColor;
    }
    return color;
}

/**
 验证并登录手势密码

 @param color 错误提示颜色
 @param gesturePasswordValue 手势密码
 @return 返回验证后的错误提示颜色
 */
- (UIColor *)validatePasswordJudgeAction:(UIColor *)color value:(NSString *)gesturePasswordValue {
    BOOL isValidate = [GesturePasswordManager isSecondRightDraw:gesturePasswordValue];
    if (isValidate) {
        // 如果验证成功
        self.reminderLabel.text = ValidateSuccess;
        self.reminderLabel.textColor = [UIColor whiteColor];
        NSString *resultData = ValidateSuccess;
        [self performSelector:@selector(blockAction:) withObject:resultData afterDelay:.5];
    } else {
        // 失败
        _validationCount--;
        if (_validationCount <= 0) {
            self.reminderLabel.text = ValidationFailed;
            NSString *resultData = ValidationFailed;
            [self performSelector:@selector(blockAction:) withObject:resultData afterDelay:.5];
        } else {
            self.reminderLabel.text = [NSString stringWithFormat:PasswordErrorCount, _validationCount];
        }
        self.reminderLabel.textColor = kWrongInfoColor;
        [self shake:self.reminderLabel];
        color = kWrongInfoColor;
    }
    return color;
}

/**
 成功的block回调

 @param resultData 返回处理后的手势密码
 */
- (void)blockAction:(NSString *)resultData {
    if (self.gesturePasswordBlock) {
        _gestureModel = NoneModel;
        self.gesturePasswordBlock([resultData stringByReplacingOccurrencesOfString:@"A" withString:@"__"]);
    }
}

/**
 摇动提示信息

 @param infoLabel 视图
 */
- (void)shake:(UILabel *)infoLabel {
    int offset = 8 ;
    CALayer *labelLayer = [infoLabel layer];
    CGPoint labelPosition = [labelLayer position];
    CGPoint y = CGPointMake(labelPosition.x - offset, labelPosition.y);
    CGPoint x = CGPointMake(labelPosition.x + offset, labelPosition.y);
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:Position];
    [animation setTimingFunction:[CAMediaTimingFunction
                                  functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [animation setFromValue:[NSValue valueWithCGPoint:x]];
    [animation setToValue:[NSValue valueWithCGPoint:y]];
    [animation setAutoreverses:YES];
    [animation setDuration:0.06];
    [animation setRepeatCount:2];
    [labelLayer addAnimation:animation forKey:nil];
}

/**
 设置手势密码的模式
 
 @param gestureModel 模式
 */
- (void)setGestureModel:(GestureModel)gestureModel {
    _gestureModel = gestureModel;
    self.reminderLabel.textColor = [UIColor whiteColor];
    
    switch (gestureModel) {
            
        case AlertPasswordModel:
            // 修改密码
            self.reminderLabel.text = InputOldPassword; // 请输入原始密码
            break;
            
        case SetPasswordModel:
            // 重置密码
            self.reminderLabel.text = SetPassword; // 请滑动设置密码
            break;
            
        case ValidatePasswordModel:
            // 验证密码
            self.reminderLabel.text = ValidatePassword; // 验证密码
            break;
            
        case DeletePasswordModel:
            // 删除密码
            [GesturePasswordManager forgotGesturePassword];
            break;
            
        default:
            break;
    }
}

/**
 添加返回和重置按钮
 */
- (void)addCancelAndResetButton {
    
    if (_gestureModel == SetPasswordModel) {
        UIButton *goBackButton = [UIButton buttonWithType:UIButtonTypeCustom];
        goBackButton.frame = CGRectMake(0, 0, 64, 64);
        [goBackButton setTitle:@"返回" forState:UIControlStateNormal];
        [goBackButton setTitle:@"返回" forState:UIControlStateHighlighted];
        [goBackButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [goBackButton setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
        [goBackButton addTarget:self action:@selector(cancelSetup) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:goBackButton];
        
        UIButton *resetButton = [UIButton buttonWithType:UIButtonTypeCustom];
        resetButton.frame = CGRectMake(kScreenWidth - 64, 0, 64, 64);
        [resetButton setTitle:@"重置" forState:UIControlStateNormal];
        [resetButton setTitle:@"重置" forState:UIControlStateHighlighted];
        [resetButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [resetButton setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
        [resetButton addTarget:self action:@selector(resetGesturePassword) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:resetButton];
    }
}

/**
 向调用页面发送取消设置的消息
 */
- (void)cancelSetup {
    [self performSelector:@selector(blockAction:) withObject:CancelOperation afterDelay:0];
}

/**
 重置手势密码并刷新页面
 */
- (void)resetGesturePassword {
    [GesturePasswordManager forgotGesturePassword];
    self.reminderLabel.textColor = [UIColor whiteColor];
    self.reminderLabel.text = SetPassword;
}

@end
