//
//  StylesHelper.m
//  BRLN
//
//  Created by Weronika Zawila-Bromirska on 8/14/13.
//  Copyright (c) 2013 home. All rights reserved.
//

#import "StylesHelper.h"

#import "CategoryViewCell.h"

@implementation StylesHelper

+ (void)applyStyle
{
    // --------------------------------------------------------------------------------------------------------------
    // NavigationBar ------------------------------------------------------------------------------------------------
    // --------------------------------------------------------------------------------------------------------------
    
    UIImage *navigationBarImage = [UIImage imageNamed:@"navbar"];
    navigationBarImage = [navigationBarImage resizableImageWithCapInsets:UIEdgeInsetsMake(0, 10.0, 0, 10.0)];
    
    UINavigationBar *navigationBarAppearance = [UINavigationBar appearance];
    [navigationBarAppearance setBackgroundImage:navigationBarImage forBarMetrics:UIBarMetricsDefault];    
    [navigationBarAppearance setShadowImage:[[UIImage alloc] init]];
    
    NSDictionary *navigationBarTextAttributes = @{ UITextAttributeTextColor:[UIColor whiteColor],
                                                   UITextAttributeFont:[UIFont fontWithName:@"Lato-Bold" size:18.0],
                                                   UITextAttributeTextShadowColor:[UIColor clearColor] };
    [navigationBarAppearance setTitleTextAttributes:navigationBarTextAttributes];
    
    // NavigationBar / buttons --------------------------------------------------------------------------------------
    
    UIImage *barButtonItemImage = [UIImage imageNamed:@"navbar-button"];
    barButtonItemImage = [barButtonItemImage resizableImageWithCapInsets:UIEdgeInsetsMake(0, 10.0, 0, 10.0)];
    
    UIImage *barButtonItemHighlightedImage = [UIImage imageNamed:@"navbar-button-highlighted"];
    barButtonItemHighlightedImage = [barButtonItemHighlightedImage resizableImageWithCapInsets:UIEdgeInsetsMake(0, 10.0, 0, 10.0)];
    
    UIImage *backBarButtonItemImage = [UIImage imageNamed:@"navbar-button-back"];
    backBarButtonItemImage = [backBarButtonItemImage resizableImageWithCapInsets:UIEdgeInsetsMake(0, 15.0, 0, 10.0)];
    
    UIImage *backBarButtonItemHighlightedImage = [UIImage imageNamed:@"navbar-button-back-highlighted"];
    backBarButtonItemHighlightedImage = [backBarButtonItemHighlightedImage resizableImageWithCapInsets:UIEdgeInsetsMake(0, 15.0, 0, 10.0)];
    
    
    UIBarButtonItem *barButtonItemAppearance = [UIBarButtonItem appearanceWhenContainedIn:[UINavigationBar class], nil];
    [barButtonItemAppearance setBackgroundImage:barButtonItemImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [barButtonItemAppearance setBackgroundImage:barButtonItemHighlightedImage forState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];

    [barButtonItemAppearance setBackButtonBackgroundImage:backBarButtonItemImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [barButtonItemAppearance setBackButtonBackgroundImage:backBarButtonItemHighlightedImage forState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
    
    
    NSDictionary *barButtonTextAttributes = @{ UITextAttributeTextColor:[UIColor whiteColor],
                                               UITextAttributeFont:[UIFont fontWithName:@"Lato-Light" size:12.0],
                                               UITextAttributeTextShadowColor:[UIColor clearColor] };
    
    NSDictionary *barButtonHighlifgtedTextAttributes = @{ UITextAttributeTextColor:[UIColor _primaryColor],
                                               UITextAttributeTextShadowColor:[UIColor clearColor] };
    
    [barButtonItemAppearance setTitleTextAttributes:barButtonTextAttributes forState:UIControlStateNormal];
    [barButtonItemAppearance setTitleTextAttributes:barButtonHighlifgtedTextAttributes forState:UIControlStateHighlighted];
    
    
    // --------------------------------------------------------------------------------------------------------------
    // TabBar -------------------------------------------------------------------------------------------------------
    // --------------------------------------------------------------------------------------------------------------
    
    UIImage *tabBarImage = [UIImage imageNamed:@"tabbar"];
    tabBarImage = [tabBarImage resizableImageWithCapInsets:UIEdgeInsetsMake(0, 10.0, 0, 10.0)];
    
    UITabBar *tabBarAppearance = [UITabBar appearance];
    [tabBarAppearance setBackgroundImage:tabBarImage];
    [tabBarAppearance setShadowImage:[[UIImage alloc] init]];
    [tabBarAppearance setSelectionIndicatorImage:[[UIImage alloc] init]];
    
    
    // --------------------------------------------------------------------------------------------------------------
    // TableView ----------------------------------------------------------------------------------------------------
    // --------------------------------------------------------------------------------------------------------------
    
    UITableView *tableViewAppearance = [UITableView appearance];
    [tableViewAppearance setBackgroundColor:[UIColor _whiteColor]];
    [tableViewAppearance setSeparatorColor:[UIColor _grayLightColor]];
    [tableViewAppearance setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    
    UILabel *tableViewHeaderAppearance = [UILabel appearanceWhenContainedIn:[UITableViewHeaderFooterView class], nil];
    [tableViewHeaderAppearance setFont:[UIFont fontWithName:@"Lato-Bold" size:12.0]];
    [tableViewHeaderAppearance setShadowColor:[UIColor clearColor]];
}

@end