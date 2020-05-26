//
//  User.h
//  ding
//
//  Created by wangsong on 2020/5/25.
//  Copyright © 2020 wangsong. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface User : NSObject


@property int uid;
@property int did;
@property NSString *loginName;
@property NSString *loginPwd;
@property NSDate *userIcon;
@property NSString *userDepartment;
@property NSString *user_name;
@property NSString *userSex;
@property NSString *userTel;
@property NSString *userEmail;
@property NSString *userQQ;
@property NSString *userWechat;
@property NSDate *userCode;
@property NSString *userStatus;

@end

NS_ASSUME_NONNULL_END
