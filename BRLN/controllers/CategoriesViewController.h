//
//  CategoriesViewController.h
//  BRLN
//
//  Created by Weronika Zawila-Bromirska on 7/22/13.
//  Copyright (c) 2013 home. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CategoriesViewController : UITableViewController <NSFetchedResultsControllerDelegate>

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;

- (NSInteger)numberOfPlacesForCategory:(NSString *)categoryName atIndexPath:(NSIndexPath *)indexPath;

@end
