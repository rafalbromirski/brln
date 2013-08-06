//
//  CategoryStore.h
//  BRLN
//
//  Created by Weronika Zawila-Bromirska on 8/5/13.
//  Copyright (c) 2013 home. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface CategoryStore : NSObject
{
    NSManagedObjectContext *managedObjectContext;
    
    NSMutableArray *allCategories;
}

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

+ (CategoryStore *)defaultStore;
- (NSArray *)allCategories;

- (void)importData;

@end
