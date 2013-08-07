//
//  PlacesViewController.h
//  BRLN
//
//  Created by Weronika Zawila-Bromirska on 7/23/13.
//  Copyright (c) 2013 home. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Category;

@interface PlacesViewController : UITableViewController <NSFetchedResultsControllerDelegate>
{
    NSString *currentCategory;
}

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;

@property (nonatomic, retain) NSString *currentCategory;

@end