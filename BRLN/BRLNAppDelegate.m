//
//  BRLNAppDelegate.m
//  BRLN
//
//  Created by Weronika Zawila-Bromirska on 7/22/13.
//  Copyright (c) 2013 home. All rights reserved.
//

#import "BRLNAppDelegate.h"

#import "StylesHelper.h"
#import "DatabaseHelper.h"

#import "CategoriesViewController.h"
#import "MapViewController.h"
#import "FavoritesViewController.h"
#import "InfoViewController.h"
#import "StyleguideViewController.h"

#import "AKTabBarController.h"

@implementation BRLNAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
    [StylesHelper applyStyle];
    
    [self initWindows];
        
    self.window.backgroundColor = [UIColor _whiteColor];
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
    [[DatabaseHelper sharedInstance] saveContext];
}



#pragma mark - Init Windows

- (void)initWindows
{
    // ### CONTROLLERS: LIST / CATEGORIES ###
    UINavigationController *listController = [[UINavigationController alloc] init];
    
    CategoriesViewController *cvc = [[CategoriesViewController alloc] init];
    [listController setViewControllers:[NSArray arrayWithObjects:cvc, nil]];
    
    
    // ### CONTROLLERS: MAP ###
    UINavigationController *mapViewController = [[UINavigationController alloc] init];

    MapViewController *mvc = [[MapViewController alloc] init];
    [mapViewController setViewControllers:[NSArray arrayWithObjects:mvc, nil]];
    
    
    // ### CONTROLLERS: FAVORITES ###
    UINavigationController *favoritesController = [[UINavigationController alloc] init];
    
    FavoritesViewController *fvc = [[FavoritesViewController alloc] init];
    [favoritesController setViewControllers:[NSArray arrayWithObjects:fvc, nil]];
    
    // ### CONTROLLERS: INFO ###
    InfoViewController *infoController = [[InfoViewController alloc] init];
    
    // ### CONTROLLERS: STYLEGUIDE ###
//    StyleguideViewController *styleguideController = [[StyleguideViewController alloc] init];
    
    // ### MAIN: TABBAR ###
    AKTabBarController *tabBarController = [[AKTabBarController alloc] initWithTabBarHeight:50];
    [tabBarController setBackgroundImageName:@"tabbar"];
    [tabBarController setSelectedBackgroundImageName:@"tabbar-highlighted"];
    [tabBarController setIconGlossyIsHidden:YES];
    [tabBarController setIconShadowColor:[UIColor clearColor]];
    [tabBarController setIconColors:[NSArray arrayWithObjects:[UIColor colorWithRed:89.0/255.0 green:95.0/255.0 blue:106.0/255.0 alpha:1.0], [UIColor colorWithRed:89.0/255.0 green:95.0/255.0 blue:106.0/255.0 alpha:1.0], nil]];
    [tabBarController setSelectedIconColors:[NSArray arrayWithObjects:[UIColor _whiteColor], [UIColor _whiteColor], nil]];
    
    [tabBarController setTabTitleIsHidden:YES];
    [tabBarController setTabStrokeColor:[UIColor clearColor]];
    [tabBarController setTabInnerStrokeColor:[UIColor clearColor]];
    [tabBarController setTabEdgeColor:[UIColor clearColor]];
    [tabBarController setSelectedIconOuterGlowColor:[UIColor clearColor]];
    [tabBarController setTabColors:[NSArray arrayWithObjects:[UIColor clearColor], [UIColor clearColor], nil]];
    
    [tabBarController setViewControllers:[NSMutableArray arrayWithObjects:listController, mapViewController, favoritesController, infoController, nil]];    
    [[self window] setRootViewController:tabBarController];
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    if ([viewController isKindOfClass:[UINavigationController class]]) {
        [(UINavigationController*)viewController popToRootViewControllerAnimated:NO];
    }
}

@end
