//
//  DetailsViewController.h
//  BRLN
//
//  Created by Weronika Zawila-Bromirska on 8/3/13.
//  Copyright (c) 2013 home. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@class Place;
@class BRLNFavoriteButton;

@interface DetailsViewController : UIViewController <MFMailComposeViewControllerDelegate>
{
    __weak IBOutlet UIScrollView *scrollView;
    UIBarButtonItem *mapButton;
    BRLNFavoriteButton *favoriteButton;
    BOOL mapButtonVisible;
    
    Place *place;
}

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain) Place *place;

@property (nonatomic) BOOL mapButtonVisible;

- (void)toggleFavorite:(id)sender;
- (void)openLink:(id)sender;
- (void)showMap:(id)sender;

@end
