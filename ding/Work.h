//
//  Work.h
//  ding
//
//  Created by wangsong on 2020/5/26.
//  Copyright © 2020 wangsong. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Work : NSObject
@property (nonatomic) int wid;
@property (nonatomic) int wCreateId;
@property (nonatomic) NSString *wCreateName;
@property (nonatomic) NSString *wDepartment;
@property (nonatomic) NSString *wTitle;
@property (nonatomic) NSString *wContent;
@property (nonatomic) NSString *wCreateDate;
@property (nonatomic) NSString *wEndDate;
@property (nonatomic) NSString *wStatus;

@end

NS_ASSUME_NONNULL_END
