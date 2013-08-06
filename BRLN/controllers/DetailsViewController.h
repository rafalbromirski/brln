//
//  DetailsViewController.h
//  BRLN
//
//  Created by Weronika Zawila-Bromirska on 8/3/13.
//  Copyright (c) 2013 home. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Place;

@interface DetailsViewController : UIViewController
{
    NSManagedObjectContext *managedObjectContext;
    
    __weak IBOutlet UIScrollView *scrollView;
    UIBarButtonItem *favoriteButton;
    UIBarButtonItem *mapButton;
    
    Place *place;
}

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain) Place *place;

- (CGRect)makeFrameWithHeight:(CGFloat)height prevElement:(UIView *)element paddingTop:(CGFloat)pt;

@end
