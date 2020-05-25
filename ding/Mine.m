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

@end

@implementation Mine

- (void)viewDidLoad {
    [super viewDidLoad];
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    _username.text = app.usr.user_name;
   
}



@end
