//
//  WorksTableViewCell.h
//  ding
//
//  Created by wangsong on 2020/5/26.
//  Copyright © 2020 wangsong. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WorksTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *create;
@property (weak, nonatomic) IBOutlet UILabel *status;
@property (weak, nonatomic) IBOutlet UILabel *endDate;

@end

NS_ASSUME_NONNULL_END
