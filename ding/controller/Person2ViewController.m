//
//  Person2ViewController.m
//  ding
//
//  Created by wangsong on 2020/5/31.
//  Copyright © 2020 wangsong. All rights reserved.
//

#import "Person2ViewController.h"

@interface Person2ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *dep;
@property (weak, nonatomic) IBOutlet UILabel *sex;
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *tel;
@property (weak, nonatomic) IBOutlet UILabel *email;
@property (weak, nonatomic) IBOutlet UILabel *qq;
@property (weak, nonatomic) IBOutlet UILabel *wechat;

@end

@implementation Person2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (![_data[@"userName"] isKindOfClass:[NSNull class]]) {
          self.name.text = [_data valueForKey:@"userName"];

      }
      if (![_data[@"userDepartment"] isKindOfClass:[NSNull class]]) {
         self.dep.text = [_data valueForKey:@"userDepartment"];

      }
      if (![_data[@"userSex"] isKindOfClass:[NSNull class]]) {
          self.sex.text = [_data valueForKey:@"userSex"];

      }
      if (![_data[@"userTel"] isKindOfClass:[NSNull class]]) {
          self.tel.text = [_data valueForKey:@"userTel"];

      }
      NSLog(@"%@",[_data valueForKey:@"userQq"]);
      if (![_data[@"userEmail"] isKindOfClass:[NSNull class]]) {
         self.email.text = [_data valueForKey:@"userEmail"];

      }
      if (![_data[@"userQq"] isKindOfClass:[NSNull class]]) {
          self.qq.text = [_data valueForKey:@"userQq"];

      }
      if (![_data[@"userWechat"] isKindOfClass:[NSNull class]]) {
          self.wechat.text = [_data valueForKey:@"userWechat"];
      }
}



@end
