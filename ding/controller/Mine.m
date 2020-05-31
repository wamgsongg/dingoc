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
    if (![app.usr.userTel isKindOfClass:[NSNull class]]) {
        _phone.text = app.usr.userTel;
    }
    if (![app.usr.userEmail isKindOfClass:[NSNull class]]) {
        _email.text = app.usr.userEmail;
    }
    if (![app.usr.userQQ isKindOfClass:[NSNull class]]) {
         _qq.text = app.usr.userQQ;
    }
    if (![app.usr.userWechat isKindOfClass:[NSNull class]]) {
        _wechat.text = app.usr.userWechat;
    }
    if (![app.usr.userDepartment isKindOfClass:[NSNull class]]) {
         _dep.text = app.usr.userDepartment;
    }
   if (![app.usr.userSex isKindOfClass:[NSNull class]]) {
        _sex.text = app.usr.userSex;
    }

}


- (IBAction)loginout:(id)sender {
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    app.usr = nil;
    app.works = nil;
      [self dismissModalViewControllerAnimated:true];
}

@end
