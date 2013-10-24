//
//  PRAppDelegate.m
//  Prestie
//
//  Created by Surat Teerapittayanon on 10/5/13.
//  Copyright (c) 2013 Surat Teerapittayanon. All rights reserved.
//

#import "PRAppDelegate.h"
#import <SinglySDK/SinglySDK.h>
#import "Flurry.h"
#import <FacebookSDK/FacebookSDK.h>
#import "MenuViewController.h"
#import "SlideNavigationController.h"
#import <KinveyKit/KinveyKit.h>

@implementation PRAppDelegate

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    return [FBSession.activeSession handleOpenURL:url];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [[KCSClient sharedClient] initializeKinveyServiceForAppKey:@"kid_TVPsvu3Y5q"
                                                 withAppSecret:@"bbafe395b8f44c03bf292c97f0bd5ff7"
                                                  usingOptions:nil];
    [KCSPing pingKinveyWithBlock:^(KCSPingResult *result) {
        if (result.pingWasSuccessful == YES){
            NSLog(@"Kinvey Ping Success");
        } else {
            NSLog(@"Kinvey Ping Failed");
        }
    }];
    // Override point for customization after application launch.
    [Flurry setCrashReportingEnabled:YES];
    //note: iOS only allows one crash reporting tool per app; if using another, set to: NO
    [Flurry startSession:@"B6S8XFQCD84445B37TB8"];
    //your code

    [FBProfilePictureView class];
    
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main"
															 bundle: nil];
	
//	MenuViewController *rightMenu = (MenuViewController*)[mainStoryboard
//                                                          instantiateViewControllerWithIdentifier: @"MenuViewController"];
//	rightMenu.view.backgroundColor = [UIColor yellowColor];
//	rightMenu.cellIdentifier = @"rightMenuCell";
	
	MenuViewController *leftMenu = (MenuViewController*)[mainStoryboard
                                                         instantiateViewControllerWithIdentifier: @"MenuViewController"];
	leftMenu.view.backgroundColor = [UIColor lightGrayColor];
	leftMenu.cellIdentifier = @"leftMenuCell";
	
//	[SlideNavigationController sharedInstance].righMenu = rightMenu;
	[SlideNavigationController sharedInstance].leftMenu = leftMenu;
    
    UIViewController *vc = [mainStoryboard instantiateViewControllerWithIdentifier: @"PRViewController"];
    [[SlideNavigationController sharedInstance] switchToViewController:vc withCompletion:nil];

    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [FBSession.activeSession handleDidBecomeActive];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

+ (void)sessionStateChanged:(FBSession *)session
                      state:(FBSessionState) state
                      error:(NSError *)error
{
    
    
    if (error) {
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:@"Error"
                                  message:error.localizedDescription
                                  delegate:nil
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
        [alertView show];
    }
}
+ (void)openSessionWithBlock:(void (^)(FBSession*, FBSessionState, NSError*))block
{
    [FBSession openActiveSessionWithReadPermissions:nil
                                       allowLoginUI:YES
                                  completionHandler:
     ^(FBSession *session,
       FBSessionState state, NSError *error) {
         [self sessionStateChanged:session state:state error:error];
         block(session,state,error);
     }];
}

@end
