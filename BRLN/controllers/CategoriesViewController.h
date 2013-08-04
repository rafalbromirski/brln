//
//  CategoriesViewController.h
//  BRLN
//
//  Created by Weronika Zawila-Bromirska on 7/22/13.
//  Copyright (c) 2013 home. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CategoriesViewController : UITableViewController
{
    NSManagedObjectContext *managedObjectContext;
    
    NSMutableArray *categories;
}

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain) NSMutableArray *categories;

-(void)getAllCategories;

-(void)importData;

@end
