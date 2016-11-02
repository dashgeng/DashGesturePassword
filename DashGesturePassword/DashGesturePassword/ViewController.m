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

@interface ViewController ()<UIAlertViewDelegate> {
    //GesturePasswordView *gesturePasswordView;
}

@property (nonatomic, strong) GesturePasswordView *gesturePasswordView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [GesturePasswordManager forgotGesturePassword];
//    self.gesturePasswordView = [[GesturePasswordView alloc] initWithFrame:self.view.bounds];
//    self.gesturePasswordView.gestureModel = SetPasswordModel;
//    __weak ViewController *weakSelf = self;
//    self.gesturePasswordView.gesturePasswordBlock = ^(NSString *resultData) {
//        if ([resultData isEqualToString:PasswordSuccess]) {
//            [weakSelf.gesturePasswordView removeFromSuperview];
//        } else {
//            [weakSelf performSelector:@selector(message:) withObject:nil afterDelay:0.5];
//        }
//    };
    

    self.gesturePasswordView = [[GesturePasswordView alloc] initWithFrame:self.view.bounds];
    self.gesturePasswordView.gestureModel = ValidatePasswordModel;
    __weak ViewController *weakSelf = self;
    self.gesturePasswordView.gesturePasswordBlock = ^(NSString *resultData) {
        if (![resultData isEqualToString:ValidationFailed]) {
            [weakSelf.gesturePasswordView removeFromSuperview];
        } else {
            [weakSelf performSelector:@selector(message:) withObject:nil afterDelay:0.5];
        }
    };
    
    [self.view addSubview:self.gesturePasswordView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)message:(id)sender {
    UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:@"手势密码已失效" message:@"请重新登录" delegate:self cancelButtonTitle:nil otherButtonTitles:@"重新登录", nil];
    alterView.tag = 800;
    [alterView show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag == 800) {
        [self.gesturePasswordView removeFromSuperview];
    }
}
@end
