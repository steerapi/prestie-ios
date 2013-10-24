//
//  MenuViewController.h
//  SlideMenu
//
//  Created by Aryan Gh on 4/24/13.
//  Copyright (c) 2013 Aryan Ghassemi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SlideNavigationController.h"
#import <FacebookSDK/FacebookSDK.h>

@interface MenuViewController : UIViewController <UITableViewDelegate>

@property (nonatomic, strong) NSString *cellIdentifier;
@property (nonatomic, strong) UIViewController *feedbackvc;
@property (nonatomic, strong) UIViewController *prestievc;

@end
