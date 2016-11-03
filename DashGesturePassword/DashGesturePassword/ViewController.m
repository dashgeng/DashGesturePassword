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

@interface ViewController ()<UIAlertViewDelegate> {
    //GesturePasswordView *gesturePasswordView;
}

//@property (nonatomic, strong) GesturePasswordView *gesturePasswordView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag == 800) {
        UIView *view = (UIView*)[self.view viewWithTag:888];
        [view removeFromSuperview];
    }
}
@end
