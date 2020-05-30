//
//  Mine.m
//  ding
//
//  Created by wangsong on 2020/5/25.
//  Copyright © 2020 wangsong. All rights reserved.
//

#import "Mine.h"
#import "AppDelegate.h"

@interface Mine ()
@property (weak, nonatomic) IBOutlet UILabel *username;
@property (weak, nonatomic) IBOutlet UIButton *quit;
@property (weak, nonatomic) IBOutlet UILabel *phone;
@property (weak, nonatomic) IBOutlet UILabel *email;
@property (weak, nonatomic) IBOutlet UILabel *qq;
@property (weak, nonatomic) IBOutlet UILabel *wechat;
@property (weak, nonatomic) IBOutlet UILabel *dep;
@property (weak, nonatomic) IBOutlet UILabel *sex;

@end

@implementation Mine

- (void)viewDidLoad {
    [super viewDidLoad];
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    _username.text = app.usr.user_name;
    _quit.layer.borderColor = [[UIColor redColor]CGColor];
    NSLog(@"%@",app.usr.userTel);
    if (app.usr.userTel!=nil) {
        _phone.text = app.usr.userTel;
    }
    if (app.usr.userEmail!=nil) {
        _email.text = app.usr.userEmail;
    }
    if (app.usr.userQQ!=nil) {
        _qq.text = app.usr.userQQ;
    }
    if (app.usr.userWechat!=nil) {
        _wechat.text = app.usr.userWechat;
    }
    
    if (app.usr.userDepartment!=nil) {
        _dep.text = app.usr.userDepartment;
    }
    if (app.usr.userSex!=nil) {
        _sex.text = app.usr.userSex;
    }
}


- (IBAction)loginout:(id)sender {
      [self dismissModalViewControllerAnimated:true];
}

@end
