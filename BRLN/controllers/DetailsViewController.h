//
//  DetailsViewController.h
//  BRLN
//
//  Created by Weronika Zawila-Bromirska on 8/3/13.
//  Copyright (c) 2013 home. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Place;
@class BRLNFavoriteButton;

@interface DetailsViewController : UIViewController
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

- (CGRect)makeFrameWithHeight:(CGFloat)height prevElement:(UIView *)element paddingTop:(CGFloat)pt;

@end
