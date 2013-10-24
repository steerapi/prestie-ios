//
//  PRViewController.m
//  Prestie
//
//  Created by Surat Teerapittayanon on 10/5/13.
//  Copyright (c) 2013 Surat Teerapittayanon. All rights reserved.
//

#import "PRViewController.h"
#import "PRLoginViewController.h"
#import "Flurry.h"
#import "SlideNavigationController.h"
#import <KinveyKit/KinveyKit.h>
#import "PRAppDelegate.h"

@interface PRViewController () <FBFriendPickerDelegate, SlideNavigationControllerDelegate, UISearchBarDelegate>

@property (strong, nonatomic) FBFriendPickerViewController *friendPickerController;
@property (strong, nonatomic) NSArray* selectedFriends;
@property (strong, nonatomic) UISearchBar *searchBar;
@property (strong, nonatomic) NSString *searchText;

@end

@implementation PRViewController

#pragma mark - SlideNavigationController Methods -

- (BOOL)slideNavigationControllerShouldDisplayLeftMenu
{
	return YES;
}

- (BOOL)slideNavigationControllerShouldDisplayRightMenu
{
	return NO;
}

/*
 * Event: Done button clicked
 */
- (void)facebookViewControllerDoneWasPressed:(id)sender {
//    FBFriendPickerViewController *friendPickerController =
//    (FBFriendPickerViewController*)sender;
//    NSLog(@"Selected friends: %@", friendPickerController.selection);
//    self.selectedFriends = friendPickerController.selection;
    
//    int friendCount = self.selectedFriends.count;
//    if(friendCount > 0){
//        NSDictionary<FBGraphUser> *randomFriend =
//        [self.selectedFriends objectAtIndex:arc4random() % friendCount];
//        
//        NSLog(@"%@",randomFriend);
//        self.userName.text = randomFriend.name;
//        self.userProfileImage.profileID = randomFriend.id;
//    }
    
    // Dismiss the friend picker
    [[self navigationController] popViewControllerAnimated:YES];
}

- (void)friendPickerViewControllerSelectionDidChange:
(FBFriendPickerViewController *)friendPicker
{
    self.selectedFriends = self.friendPickerController.selection;
    
    int friendCount = self.selectedFriends.count;
    if(friendCount > 0){
        NSDictionary<FBGraphUser> *randomFriend =
        [self.selectedFriends objectAtIndex:arc4random() % friendCount];
        
        NSLog(@"%@",randomFriend);
        self.userName.text = randomFriend.name;
        self.userProfileImage.profileID = randomFriend.id;
    }
}

- (BOOL)friendPickerViewController:(FBFriendPickerViewController *)friendPicker
                 shouldIncludeUser:(id<FBGraphUser>)user
{
    if (self.searchText && ![self.searchText isEqualToString:@""]) {
        NSRange result = [user.name
                          rangeOfString:self.searchText
                          options:NSCaseInsensitiveSearch];
        if (result.location != NSNotFound) {
            return YES;
        } else {
            return NO;
        }
    } else {
        return YES;
    }
    return YES;
}


//-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
//    if ([[segue identifier] isEqualToString:@"login"])
//    {
//        // Get reference to the destination view controller
//        PRLoginViewController *vc = [segue destinationViewController];
//        
//        // Pass any objects to the view controller here, like...
//        [vc setSender:sender];
//    }
//}


- (IBAction)answerYes:(id)sender {
}

- (IBAction)answerNo:(id)sender {
}



/*
 * Event: Decide if a given user should be displayed
 */
//- (BOOL)friendPickerViewController:(FBFriendPickerViewController *)friendPicker
//                 shouldIncludeUser:(id <FBGraphUser>)user
//{
//    // Filtering example: only show users who have
//    // "ch" in their names
//    NSRange result = [user.name rangeOfString:@"ch"
//                                      options:NSCaseInsensitiveSearch];
//    if (result.location != NSNotFound) {
//        return YES;
//    } else {
//        return NO;
//    }
//}
- (void) handleBack:(id)sender
{
    // pop to root view controller
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (void)addSearchBarToFriendPickerView
{
    if (self.searchBar == nil) {
        CGFloat searchBarHeight = 44.0;
        CGFloat statusBarHeight = [[UIApplication sharedApplication] statusBarFrame].size.height;
        
        self.searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, searchBarHeight)];
        self.searchBar.autoresizingMask = self.searchBar.autoresizingMask | UIViewAutoresizingFlexibleWidth;
        self.searchBar.delegate = self;
        self.searchBar.showsCancelButton = YES;
        
//        [self.view addSubview:self.searchBar];
        
        [self.friendPickerController.view addSubview:self.searchBar];
        UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back"
                                                                       style:UIBarButtonItemStyleBordered
                                                                      target:self
                                                                      action:@selector(handleBack:)];
        self.friendPickerController.navigationItem.leftBarButtonItem = backButton;
        CGRect newFrame = self.friendPickerController.view.bounds;
        newFrame.size.height -= searchBarHeight;
        newFrame.origin.y = searchBarHeight - statusBarHeight;
        self.friendPickerController.tableView.frame = newFrame;
        
    }
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [PRAppDelegate openSessionWithBlock:^(FBSession *session, FBSessionState state, NSError *err) {
        switch (state) {
            case FBSessionStateOpen: {
                
                [KCSUser loginWithSocialIdentity:KCSSocialIDFacebook
                                accessDictionary:@{ KCSUserAccessTokenKey : [[[FBSession activeSession] accessTokenData] accessToken]}
                             withCompletionBlock:^(KCSUser *user, NSError *errorOrNil, KCSUserActionResult result) {
                                 if (errorOrNil) {
                                     return;
                                 }
//                                 if([self.selectedFriends count] == 0){
//                                     [self selectFriends:self];
//                                 }
                                 NSLog(@"Loggedin!");
                                 //                                         [self dismissViewControllerAnimated:YES completion:nil];
                             }];
                //                [[FBRequest requestForMe] startWithCompletionHandler:
                //                 ^(FBRequestConnection *connection,
                //                   NSDictionary<FBGraphUser> *user,
                //                   NSError *error) {
                //                     if (!error) {
                //                         NSLog(@"user.name: %@",user.name);
                //                         NSLog(@"user.id: %@",user.id);
                //                     }
                //                 }];
                
                break;
            }
            case FBSessionStateClosed:
            case FBSessionStateClosedLoginFailed:{
                UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];

                UIViewController *lvc = [mainStoryboard instantiateViewControllerWithIdentifier:@"PRLoginViewController"];
                [self presentViewController:lvc animated:YES completion:nil];
                break;
            }
            default:
                break;
        }
    }];
//    NSDictionary *articleParams =
//    [NSDictionary dictionaryWithObjectsAndKeys:
//     @"John Q", @"Author", // Capture author info
//     @"Registered", @"User_Status", // Capture user status
//     nil];
    
//    [Flurry logEvent:@"Article_Read" withParameters:articleParams];

	// Do any additional setup after loading the view, typically from a nib.
//    SinglySession *session = [SinglySession sharedSession];
//    session.clientID = @"2feee9fedf6cd945f4b154a29446f563";
//    session.clientSecret = @"ad5308ff2c5d8aee7f2d74aa0d6c1678";
//
    

//    id<FBGraphUser> randomFriend =
//    [self.selectedFriends objectAtIndex:arc4random() % friendCount];
//    [session startSessionWithCompletion:^(BOOL isReady, NSError *error) {
//        if (isReady) {
//            // The session is ready to go!
//        } else {
//            // A valid session could not be started. You will need to authenticate
//            // with a service (from a view controller) to establish a valid
//            // session.
////            SinglyLoginPickerViewController *viewController = [[SinglyLoginPickerViewController alloc] init];
////            viewController.services = @[@"facebook"];
////            [self presentViewController:viewController animated:YES completion:^{
////            
////            }];
//            [self performSegueWithIdentifier:@"login" sender:self];
//        }
//    }];
//    SinglyService *service = [SinglyService serviceWithIdentifier:@"facebook"];
//    service.delegate = self;
//    [service requestAuthorizationFromViewController:self];
//    
    
}

- (void) handleSearch:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
    self.searchText = searchBar.text;
    [self.friendPickerController updateView];
}

- (void)searchBarSearchButtonClicked:(UISearchBar*)searchBar
{
    [self handleSearch:searchBar];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar {
    self.searchText = nil;
    [self.friendPickerController updateView];
    [searchBar resignFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)selectFriends:(id)sender {
    if (self.friendPickerController == nil) {
        self.friendPickerController = [[FBFriendPickerViewController alloc]
                                       initWithNibName:nil bundle:nil];
        self.friendPickerController.delegate = self;
        self.friendPickerController.title = @"Select Friends";
        [self.friendPickerController loadData];
        [self addSearchBarToFriendPickerView];
    }
    [self.navigationController pushViewController:self.friendPickerController
                                         animated:YES];
}

//- (IBAction)logout:(id)sender {
//    [FBSession.activeSession closeAndClearTokenInformation];
//}

@end
