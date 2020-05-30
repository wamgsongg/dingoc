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


@property (nonatomic) int uid;
@property (nonatomic) int did;
@property (nonatomic) NSString *loginName;
@property (nonatomic) NSString *loginPwd;
@property (nonatomic) NSDate *userIcon;
@property (nonatomic) NSString *userDepartment;
@property (nonatomic) NSString *user_name;
@property (nonatomic) NSString *userSex;
@property (nonatomic) NSString *userTel;
@property (nonatomic) NSString *userEmail;
@property (nonatomic) NSString *userQQ;
@property (nonatomic) NSString *userWechat;
@property (nonatomic) NSDate *userCode;
@property (nonatomic) NSString *userStatus;

@end

NS_ASSUME_NONNULL_END
