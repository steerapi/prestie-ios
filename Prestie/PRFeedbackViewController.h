//
//  PRFeedbackViewController.h
//  Prestie
//
//  Created by Surat Teerapittayanon on 10/7/13.
//  Copyright (c) 2013 Surat Teerapittayanon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PRFeedbackViewController : UITableViewController
- (IBAction)submitFeedback:(id)sender;
@property (weak, nonatomic) IBOutlet UITextView *feedbackTxt;

@end
