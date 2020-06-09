//
//  TimeViewController.m
//  ding
//
//  Created by mac on 2020/6/9.
//  Copyright © 2020 wangsong. All rights reserved.
//

#import "TimeViewController.h"

@interface TimeViewController ()
@property (weak, nonatomic) IBOutlet UIDatePicker *datapicker;
@property (weak, nonatomic) IBOutlet UIButton *start;
- (IBAction)start:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *continue1;
- (IBAction)continue1:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *stop;
- (IBAction)stop:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *finish;
- (IBAction)finish:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *lefttime;

@end

@implementation TimeViewController
NSTimer *timer;
NSInteger leftSeconds;

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




- (IBAction)start:(id)sender {
    leftSeconds = self.datapicker.countDownDuration;
    self.datapicker.enabled = NO;
    [sender setEnabled:NO];
    NSString *message =  [NSString stringWithFormat: @"开始倒计时？您还剩下【%ld】秒", (long)leftSeconds];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"开始倒计时？" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *certain = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:certain];
        [self presentViewController:alert animated:YES completion:nil];
        timer = [NSTimer scheduledTimerWithTimeInterval:1
        target:self selector:@selector(tickDown)
        userInfo:nil repeats:YES];
    
}
- (IBAction)continue1:(id)sender {
    [timer setFireDate:[NSDate distantPast]];
}
- (IBAction)stop:(id)sender {
    [timer setFireDate:[NSDate distantFuture]];
}
- (IBAction)finish:(id)sender {
    [timer invalidate];
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"倒计时结束！" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *certain = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    [alertC addAction:certain];
    [self presentViewController:alertC animated:YES completion:nil];
    self.datapicker.enabled = YES;
    self.start.enabled = YES;
    self.lefttime.text=@"剩余时间:";
}
- (void) tickDown{
    leftSeconds -= 1;
    self.datapicker.countDownDuration = leftSeconds;
    NSString *s = [NSString stringWithFormat:@"剩余时间：%ld秒",leftSeconds];
    self.lefttime.text=s;
    if(leftSeconds <= 0)    {
        [timer invalidate];
        self.datapicker.enabled = YES;
        self.start.enabled = YES;
    }
}
@end
