//
//  PRAppDelegate.h
//  Prestie
//
//  Created by Surat Teerapittayanon on 10/5/13.
//  Copyright (c) 2013 Surat Teerapittayanon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>

@interface PRAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

+ (void)sessionStateChanged:(FBSession *)session
                      state:(FBSessionState) state
                      error:(NSError *)error;
+ (void)openSessionWithBlock:(void (^)(FBSession*, FBSessionState, NSError*))block;

@end
