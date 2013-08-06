//
//  DetailsViewController.m
//  BRLN
//
//  Created by Weronika Zawila-Bromirska on 8/3/13.
//  Copyright (c) 2013 home. All rights reserved.
//

#import "DetailsViewController.h"
#import "MapViewController.h"

#import "Category.h"
#import "Place.h"

@implementation DetailsViewController

@synthesize place;
@synthesize managedObjectContext;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)loadView
{
    [super loadView];
    [self setTitle:[place placeName]];
    
    favoriteButton = [[UIBarButtonItem alloc] initWithTitle:([place favorited] ? @"Remove" : @"Add") style:UIBarButtonItemStyleBordered target:self action:@selector(toggleFavorite:)];

    mapButton = [[UIBarButtonItem alloc] initWithTitle:@"Map" style:UIBarButtonItemStyleBordered target:self action:@selector(showMap:)];
    
    [[self navigationItem] setRightBarButtonItems:[NSArray arrayWithObjects:mapButton, favoriteButton, nil]];
    
    UIView *mainView = [[UIView alloc] init];
    
    UIImageView *placeImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 200)];
    [placeImage setImage:[UIImage imageNamed:@"place.jpg"]];
    [placeImage setContentMode:UIViewContentModeScaleAspectFit];
    [mainView addSubview:placeImage];
    
    
    UILabel *placeNameLabel = [[UILabel alloc] initWithFrame:[self makeFrameWithHeight:20 prevElement:placeImage paddingTop:10]];
    [placeNameLabel setText:[place placeName]];
    [placeNameLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18.0]];
    [placeNameLabel setNumberOfLines:0];
    [placeNameLabel sizeToFit];
    [mainView addSubview:placeNameLabel];
    
    
    UILabel *placeCategoryLabel = [[UILabel alloc] initWithFrame:[self makeFrameWithHeight:20 prevElement:placeNameLabel paddingTop:0]];
    [placeCategoryLabel setText:[[place category] categoryName]];
    [placeCategoryLabel setFont:[UIFont fontWithName:@"Helvetica" size:14.0]];
    [placeCategoryLabel setNumberOfLines:0];
    [placeCategoryLabel sizeToFit];
    [mainView addSubview:placeCategoryLabel];


    UITextView *placeDescriptionText = [[UITextView alloc] initWithFrame:[self makeFrameWithHeight:50 prevElement:placeCategoryLabel paddingTop:10]];
    [placeDescriptionText setEditable:NO];
    [placeDescriptionText setScrollEnabled:NO];
    [placeDescriptionText setShowsHorizontalScrollIndicator:NO];
    [placeDescriptionText setShowsVerticalScrollIndicator:NO];
    [placeDescriptionText setContentInset:UIEdgeInsetsMake(-8, -8, -8, -8)];
    [placeDescriptionText setText:[place placeDescription]];
    [placeDescriptionText setFont:[UIFont fontWithName:@"Helvetica" size:14.0]];
    [mainView addSubview:placeDescriptionText];

    CGRect placeDescriptionFrame = placeDescriptionText.frame;
    placeDescriptionFrame.size.height = placeDescriptionText.contentSize.height;
    placeDescriptionText.frame = placeDescriptionFrame;

    
    UILabel *placeUrlLabel = [[UILabel alloc] initWithFrame:[self makeFrameWithHeight:20 prevElement:placeDescriptionText paddingTop:5]];
    [placeUrlLabel setText:[place placeUrl]];
    [placeUrlLabel setFont:[UIFont fontWithName:@"Helvetica" size:14.0]];
    [placeUrlLabel setNumberOfLines:0];
    [placeUrlLabel sizeToFit];
    [mainView addSubview:placeUrlLabel];
    
    
    UIView *_lastElement = placeUrlLabel;
    [mainView setFrame:CGRectMake(0, 0, self.view.frame.size.width, _lastElement.frame.origin.y + _lastElement.frame.size.height + 20)];
    
    [scrollView addSubview:mainView];
    [scrollView setContentSize:CGSizeMake(mainView.frame.size.width, mainView.frame.size.height)];
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
        [favoriteButton setTitle:@"Add"];
    } else
    {
        [place setFavorited:YES];
        [favoriteButton setTitle:@"Remove"];        
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
    [mvc setManagedObjectContext:managedObjectContext];
    
    [self.navigationController pushViewController:mvc animated:YES];
}

# pragma mark - helpers

- (CGRect)makeFrameWithHeight:(CGFloat)height prevElement:(UIView *)element paddingTop:(CGFloat)pt
{
    return CGRectMake(10, element.frame.size.height + element.frame.origin.y + pt, self.view.frame.size.width - 20, height);
}

@end
