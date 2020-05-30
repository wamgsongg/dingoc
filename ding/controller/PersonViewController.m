//
//  PersonViewController.m
//  ding
//
//  Created by wangsong on 2020/5/31.
//  Copyright © 2020 wangsong. All rights reserved.
//

#import "PersonViewController.h"

@interface PersonViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *dep;
@property (weak, nonatomic) IBOutlet UILabel *sex;
@property (weak, nonatomic) IBOutlet UILabel *tel;
@property (weak, nonatomic) IBOutlet UILabel *email;
@property (weak, nonatomic) IBOutlet UILabel *qq;
@property (weak, nonatomic) IBOutlet UILabel *wechat;

@end

@implementation PersonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.name.text = [_data valueForKey:@"userName"];
    self.dep.text = [_data valueForKey:@"userDepartment"];
    self.sex.text = [_data valueForKey:@"userSex"];
    self.tel.text = [_data valueForKey:@"userTel"];
    self.email.text = [_data valueForKey:@"userEmail"];
    self.qq.text = [_data valueForKey:@"userQq"];
    self.wechat.text = [_data valueForKey:@"userWechat"];
}

@end
