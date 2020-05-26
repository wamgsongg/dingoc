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
@property int wid;
@property int wCreateId;
@property NSString *wCreateName;
@property NSString *wDepartment;
@property NSString *wTitle;
@property NSString *wContent;
@property NSDate* wCreateDate;
@property NSDate* wEndDate;
@property NSString *wStatus;

@end

NS_ASSUME_NONNULL_END
