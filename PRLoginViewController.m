//
//  PRLoginViewController.m
//  Prestie
//
//  Created by Surat Teerapittayanon on 10/7/13.
//  Copyright (c) 2013 Surat Teerapittayanon. All rights reserved.
//

#import "PRLoginViewController.h"
#import "PRAppDelegate.h"
#import <KinveyKit/KinveyKit.h>

@interface PRLoginViewController ()
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;
@end

@implementation PRLoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (IBAction)loginWithFacebook:(UIButton *)sender {
    [self.spinner startAnimating];
    
    [PRAppDelegate openSessionWithBlock:^(FBSession *session, FBSessionState state, NSError *err) {
        switch (state) {
            case FBSessionStateOpen: {
                
                //                [[FBRequest requestForMe] startWithCompletionHandler:
                //                 ^(FBRequestConnection *connection,
                //                   NSDictionary<FBGraphUser> *user,
                //                   NSError *error) {
                //                     if (!error) {
                //                         NSLog(@"user.name: %@",user.name);
                //                         NSLog(@"user.id: %@",user.id);
                //                     }
                //                 }];
                [self dismissViewControllerAnimated:YES completion:nil];

                break;
            }
            case FBSessionStateClosed:
            case FBSessionStateClosedLoginFailed:{
                break;
            }
            default:
                break;
        }
    }];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
