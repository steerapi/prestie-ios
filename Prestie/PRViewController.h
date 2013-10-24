//
//  PRViewController.h
//  Prestie
//
//  Created by Surat Teerapittayanon on 10/5/13.
//  Copyright (c) 2013 Surat Teerapittayanon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>

@interface PRViewController : UIViewController
- (IBAction)selectFriends:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet FBProfilePictureView *userProfileImage;
@property (weak, nonatomic) IBOutlet UILabel *userQuestion;
- (IBAction)answerYes:(id)sender;
- (IBAction)answerNo:(id)sender;

@end
