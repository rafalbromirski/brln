//
//  FavoritesViewController.h
//  BRLN
//
//  Created by Weronika Zawila-Bromirska on 7/22/13.
//  Copyright (c) 2013 home. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FavoritesViewController : UITableViewController
{
    NSManagedObjectContext *managedObjectContext;

    NSMutableArray *places;
}

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain) NSMutableArray *places;

-(void)getFavoritedPlaces;

@end
