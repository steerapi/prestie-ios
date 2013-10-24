//
//  MenuViewController.m
//  SlideMenu
//
//  Created by Aryan Gh on 4/24/13.
//  Copyright (c) 2013 Aryan Ghassemi. All rights reserved.
//

#import "MenuViewController.h"

/*
 *  System Versioning Preprocessor Macros
 */

#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

@implementation MenuViewController
@synthesize cellIdentifier;

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7")) {
        self.view.frame = CGRectMake(0, 20, self.view.frame.size.width, self.view.frame.size.height-20);
    }
    
}

#pragma mark - UITableView Delegate & Datasrouce -

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:self.cellIdentifier];
	
	switch (indexPath.row)
	{
		case 0:
			cell.textLabel.text = @"Prestie";
			break;
			
		case 1:
			cell.textLabel.text = @"Feedback";
			break;
			
		case 2:
			cell.textLabel.text = @"Logout";
			break;
	}
	[cell setSelectionStyle:UITableViewCellSelectionStyleNone];
	return cell;
}

- (void) logout{
    [FBSession.activeSession closeAndClearTokenInformation];
//    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main"
//															 bundle: nil];
//    UIViewController *vc = [mainStoryboard instantiateViewControllerWithIdentifier: @"PRViewController"];
//    [[SlideNavigationController sharedInstance] switchToViewController:vc withCompletion:^{
//       
//    }];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main"
															 bundle: nil];
	
	UIViewController *vc ;
	
	switch (indexPath.row)
	{
		case 0:
        {
			if(_prestievc == nil){
                _prestievc = [mainStoryboard instantiateViewControllerWithIdentifier: @"PRViewController"];
			}
            vc = _prestievc;
            break;
        }
		case 1:
        {
            if(_feedbackvc == nil){
                _feedbackvc = [mainStoryboard instantiateViewControllerWithIdentifier: @"PRFeedbackViewController"];
			}
            vc = _feedbackvc;
			break;
        }
		case 2:{
			[self logout];
			break;
        }
	}
	
    if(vc){
        [[SlideNavigationController sharedInstance] switchToViewController:vc withCompletion:nil];
    }
}

@end
