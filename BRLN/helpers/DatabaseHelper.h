//
//  DatabaseHelper.h
//  BRLN
//
//  Created by Weronika Zawila-Bromirska on 8/6/13.
//  Copyright (c) 2013 home. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface DatabaseHelper : NSObject
{
    NSPersistentStoreCoordinator *persistentStoreCoordinator;
    NSManagedObjectModel *managedObjectModel;
    NSManagedObjectContext *managedObjectContext;
}

// ### CORE DATA ###

@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory;
- (NSManagedObjectContext *)managedObjectContext;

+ (id)sharedInstance;
- (void)saveContext;



@end
