//
//  PeopleTableViewCell.h
//  ding
//
//  Created by wangsong on 2020/5/31.
//  Copyright © 2020 wangsong. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PeopleTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *name;

@end

NS_ASSUME_NONNULL_END
