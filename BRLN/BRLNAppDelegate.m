//
//  BRLNAppDelegate.m
//  BRLN
//
//  Created by Weronika Zawila-Bromirska on 7/22/13.
//  Copyright (c) 2013 home. All rights reserved.
//

#import "BRLNAppDelegate.h"

#import "CategoriesViewController.h"
#import "MapViewController.h"
#import "FavoritesViewController.h"
#import "InfoViewController.h"

#import "CategoryStore.h"

@implementation BRLNAppDelegate

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
    [self initWindows];
        
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

#pragma mark - Core Data stack

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"BRLN" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"BRLN.sqlite"];
    
    // If the expected store doesn't exist, copy the default store.
//    NSFileManager *fileManager = [NSFileManager defaultManager];    
//    if (![fileManager fileExistsAtPath:[storeURL path]]) {
//        NSURL *defaultStoreURL = [[NSBundle mainBundle] URLForResource:@"BRLN" withExtension:@"sqlite"];
//        NSLog(@"defaultStoreURL: %@", defaultStoreURL);
//        if (defaultStoreURL) {
//            [fileManager copyItemAtURL:defaultStoreURL toURL:storeURL error:NULL];
//        }
//    }
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter:
         @{NSMigratePersistentStoresAutomaticallyOption:@YES, NSInferMappingModelAutomaticallyOption:@YES}
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

#pragma mark - Init Windows

- (void)initWindows
{
    // ### CONTROLLERS: LIST / CATEGORIES ###
    UINavigationController *listController = [[UINavigationController alloc] init];
    [[listController tabBarItem] setTitle:@"List"];
    [[listController tabBarItem] setImage:[UIImage imageNamed:@"icon-list"]];
    
    CategoriesViewController *cvc = [[CategoriesViewController alloc] init];
    [listController setViewControllers:[NSArray arrayWithObjects:cvc, nil]];
    
    
    // ### CONTROLLERS: MAP ###
    UINavigationController *mapViewController = [[UINavigationController alloc] init];
    [[mapViewController tabBarItem]setTitle:@"Map"];
    [[mapViewController tabBarItem] setImage:[UIImage imageNamed:@"icon-map"]];

    MapViewController *mvc = [[MapViewController alloc] init];
    [mapViewController setViewControllers:[NSArray arrayWithObjects:mvc, nil]];
    
    
    // ### CONTROLLERS: FAVORITES ###
    UINavigationController *favoritesController = [[UINavigationController alloc] init];
    [[favoritesController tabBarItem] setTitle:@"Favorite"];
    [[favoritesController tabBarItem] setImage:[UIImage imageNamed:@"icon-list"]];
    
    FavoritesViewController *fvc = [[FavoritesViewController alloc] init];
    [favoritesController setViewControllers:[NSArray arrayWithObjects:fvc, nil]];
    
    
    // ### CONTROLLERS: INFO ###
    InfoViewController *infoController = [[InfoViewController alloc] init];
    [[infoController tabBarItem] setTitle:@"Info"];
    [[infoController tabBarItem] setImage:[UIImage imageNamed:@"icon-info"]];
    
    
    // ### MAIN: TABBAR ###
    NSArray *viewControllers = [NSArray arrayWithObjects:listController, mapViewController, favoritesController, infoController, nil];
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    [tabBarController setViewControllers:viewControllers];
    [tabBarController setDelegate:self];    
    
    [[self window] setRootViewController:tabBarController];
    
    // ### COREDATA ###
    NSManagedObjectContext *context = [self managedObjectContext];
    
//    [cvc setManagedObjectContext:context];
//    [mvc setManagedObjectContext:context];
//    [fvc setManagedObjectContext:context];
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    if ([viewController isKindOfClass:[UINavigationController class]]) {
        [(UINavigationController*)viewController popToRootViewControllerAnimated:NO];
    }
}


@end
