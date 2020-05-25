//
//  AppDelegate.h
//  ding
//
//  Created by wangsong on 2020/5/25.
//  Copyright © 2020 wangsong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "User.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;
@property (strong,nonatomic) User *usr;

@end

