//
//  ViewController.m
//  DashGesturePassword
//
//  Created by 耿大帅 on 2016/11/2.
//
//

#import "ViewController.h"
#import "GesturePasswordView.h"
#import "GesturePasswordManager.h"
#import "MessageConst.h"
#import "MacroConst.h"

@interface ViewController ()<UIAlertViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)setGP:(id)sender {
    GesturePasswordManager *gesturePasswordManager = [[GesturePasswordManager alloc] init];
        [gesturePasswordManager setupGesturePassword:self];
}
- (IBAction)valGP:(id)sender {
    GesturePasswordManager *gesturePasswordManager = [[GesturePasswordManager alloc] init];
    [gesturePasswordManager validationGesturePassword:self];
}

/**
 手势密码验证失败的消息处理
 */
- (void)validationFailedMessage {
    UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:@"手势密码已失效" message:@"请重新登录" delegate:self cancelButtonTitle:nil otherButtonTitles:@"重新登录", nil];
    alterView.tag = 800;
    [alterView show];
}

/**
 *  消息对话框的响应处理方法
 *
 *  @param alertView   消息对话框的视图
 *  @param buttonIndex 按钮索引
 */
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag == 800) {
        UIView *view = (UIView*)[self.view viewWithTag:888];
        [view removeFromSuperview];
    }
}
@end
