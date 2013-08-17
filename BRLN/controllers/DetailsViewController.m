//
//  DetailsViewController.m
//  BRLN
//
//  Created by Weronika Zawila-Bromirska on 8/3/13.
//  Copyright (c) 2013 home. All rights reserved.
//

#import "DatabaseHelper.h"

#import "DetailsViewController.h"
#import "MapViewController.h"

#import "Category.h"
#import "Place.h"

@implementation DetailsViewController

@synthesize place;
@synthesize managedObjectContext;
@synthesize mapButtonVisible;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self setMapButtonVisible:YES];
    }
    return self;
}

- (void)loadView
{
    [super loadView];
    
    [self setTitle:[place placeName]];
    
    // set context - DatabaseHelper
    [self setManagedObjectContext:[[DatabaseHelper sharedInstance] managedObjectContext]];
    
    if (mapButtonVisible) {
         mapButton = [[UIBarButtonItem alloc] initWithTitle:@"Map" style:UIBarButtonItemStyleBordered target:self action:@selector(showMap:)];
        [[self navigationItem] setRightBarButtonItem:mapButton];
    }
    
    
    UIView *placeWrapperView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 500)];
    
    UIImageView *placeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 200)];
    [placeImageView setImage:[UIImage imageNamed:@"place.jpg"]];
    [placeImageView setContentMode:UIViewContentModeScaleAspectFill];
    [placeWrapperView addSubview:placeImageView];
    
    
    UIView *placeDetailsView = [[UIView alloc] initWithFrame:CGRectMake(0, 200, self.view.frame.size.width, 500)];
    [placeDetailsView setBackgroundColor:[UIColor colorWithRed:247.0/255.0 green:249.0/255.0 blue:250.0/255.0 alpha:1.0]];
    [placeWrapperView addSubview:placeDetailsView];
    
    
    favoriteButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [favoriteButton setFrame:CGRectMake(self.view.frame.size.width - 60, 20, 40, 40)];
    [favoriteButton setTitle:([place favorited] ? @"Rem" : @"Add") forState:UIControlStateNormal];
    [favoriteButton setUserInteractionEnabled:YES];
    [favoriteButton setMultipleTouchEnabled:YES];
    [favoriteButton addTarget:self action:@selector(toggleFavorite:) forControlEvents:UIControlEventTouchUpInside];
    [placeDetailsView addSubview:favoriteButton];
    
    
    UILabel *placeNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, self.view.frame.size.width - 80, 20)];
    [placeNameLabel setText:[place placeName]];
    [placeNameLabel setBackgroundColor:[UIColor clearColor]];
    [placeNameLabel setTextColor:[UIColor colorWithRed:57.0/255.0 green:65.0/255.0 blue:76.0/255.0 alpha:1.0]];
    [placeNameLabel setFont:[UIFont fontWithName:@"Lato-Bold" size:18.0]];
    [placeNameLabel setNumberOfLines:0];
    [placeNameLabel sizeToFit];
    [placeDetailsView addSubview:placeNameLabel];


    UILabel *placeCategoryLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, placeNameLabel.frame.origin.y + placeNameLabel.frame.size.height + 5, self.view.frame.size.width - 40, 20)];
    [placeCategoryLabel setText:[[place category] categoryName]];
    [placeCategoryLabel setBackgroundColor:[UIColor clearColor]];
    [placeCategoryLabel setTextColor:[UIColor colorWithRed:97.0/255.0 green:106.0/255.0 blue:119.0/255.0 alpha:1.0]];
    [placeCategoryLabel setFont:[UIFont fontWithName:@"Lato-Bold" size:10.0]];
    [placeCategoryLabel setNumberOfLines:0];
    [placeCategoryLabel sizeToFit];
    [placeDetailsView addSubview:placeCategoryLabel];


    UILabel *placeDescriptionText = [[UILabel alloc] initWithFrame:CGRectMake(20, placeCategoryLabel.frame.origin.y + placeCategoryLabel.frame.size.height + 15, self.view.frame.size.width - 40, 20)];
    [placeDescriptionText setText:[place placeDescription]];
    [placeDescriptionText setBackgroundColor:[UIColor clearColor]];
    [placeDescriptionText setTextColor:[UIColor colorWithRed:97.0/255.0 green:106.0/255.0 blue:119.0/255.0 alpha:1.0]];
    [placeDescriptionText setFont:[UIFont fontWithName:@"Lato-Regular" size:10.0]];
    [placeDescriptionText setNumberOfLines:0];
    [placeDescriptionText sizeToFit];
    [placeDetailsView addSubview:placeDescriptionText];
    
    
    

//    UILabel *placeUrlLabel = [[UILabel alloc] initWithFrame:[self makeFrameWithHeight:20 prevElement:placeDescriptionText paddingTop:5]];
//    [placeUrlLabel setText:[place placeUrl]];
//    [placeUrlLabel setFont:[UIFont fontWithName:@"Helvetica" size:14.0]];
//    [placeUrlLabel setNumberOfLines:0];
//    [placeUrlLabel sizeToFit];
//    [placeDetails addSubview:placeUrlLabel];
//    
//    
//    UIView *_lastElement = placeDetails;
//    [mainView setFrame:CGRectMake(0, 0, self.view.frame.size.width, _lastElement.frame.origin.y + _lastElement.frame.size.height + 20)];
    
    [scrollView addSubview:placeWrapperView];
    [scrollView setContentSize:CGSizeMake(placeWrapperView.frame.size.width, placeDetailsView.frame.size.height + placeDetailsView.frame.origin.y)];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)toggleFavorite:(id)sender
{
    if ([place favorited])
    {
        [place setFavorited:NO];
        [favoriteButton setTitle:@"Add" forState:UIControlStateNormal];
    } else
    {
        [place setFavorited:YES];
        [favoriteButton setTitle:@"Rem" forState:UIControlStateNormal];
    }
    
    NSError *error = nil;
    [managedObjectContext save:&error];
    
    if (error) {
        NSLog(@"ERROR: Save request raised an error - %@", [error description]);
    }
}

- (void)showMap:(id)sender
{
    MapViewController *mvc = [[MapViewController alloc] init];
    [mvc setPlaces:[[NSMutableArray alloc] initWithObjects:place, nil]];
    [mvc setMapAnnotatesClickable:NO];
    
    [self.navigationController pushViewController:mvc animated:YES];
}

# pragma mark - helpers

- (CGRect)makeFrameWithHeight:(CGFloat)height prevElement:(UIView *)element paddingTop:(CGFloat)pt
{
    return CGRectMake(10, element.frame.size.height + element.frame.origin.y + pt, self.view.frame.size.width - 20, height);
}

@end
