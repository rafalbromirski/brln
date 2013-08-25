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

#import "BRLNFavoriteButton.h"
#import "BRLNFlatButton.h"
#import "TTTAttributedLabel.h"

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
    [placeImageView setClipsToBounds:YES];
    [placeWrapperView addSubview:placeImageView];
    
    
    UIView *placeDetailsView = [[UIView alloc] initWithFrame:CGRectMake(0, 200, self.view.frame.size.width, 300)];
    [placeDetailsView setBackgroundColor:[UIColor _whiteColor]];
    [placeWrapperView addSubview:placeDetailsView];
    
    
    favoriteButton = [BRLNFavoriteButton buttonWithType:UIButtonTypeCustom];
    [favoriteButton setFrame:CGRectMake(self.view.frame.size.width - 45, 20, 25, 25)];
    [favoriteButton setSelected:([place favorited] ? YES : NO)];
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

    
    UIImageView *placeAddressIcon = [[UIImageView alloc] initWithFrame:CGRectMake(20, placeNameLabel.frame.origin.y + placeNameLabel.frame.size.height + 5, 11, 15)];
    [placeAddressIcon setImage:[UIImage imageNamed:@"icon-address"]];
    [placeDetailsView addSubview:placeAddressIcon];

    UILabel *placeAddressLabel = [[UILabel alloc] initWithFrame:CGRectMake(35, placeNameLabel.frame.origin.y + placeNameLabel.frame.size.height + 6, self.view.frame.size.width - 40, 14)];
    [placeAddressLabel setText:[place placeAddress]];
    [placeAddressLabel setBackgroundColor:[UIColor clearColor]];
    [placeAddressLabel setTextColor:[UIColor colorWithRed:97.0/255.0 green:106.0/255.0 blue:119.0/255.0 alpha:1.0]];
    [placeAddressLabel setFont:[UIFont fontWithName:@"Lato-Bold" size:10.0]];
    [placeAddressLabel setNumberOfLines:0];
    [placeAddressLabel sizeToFit];
    [placeDetailsView addSubview:placeAddressLabel];


    TTTAttributedLabel *placeDescriptionText = [[TTTAttributedLabel alloc] initWithFrame:CGRectMake(20, placeAddressLabel.frame.origin.y + placeAddressLabel.frame.size.height + 20, self.view.frame.size.width - 40, 100)];
    [placeDescriptionText setFont:[UIFont fontWithName:@"Lato-Regular" size:10.0]];
    [placeDescriptionText setTextColor:[UIColor colorWithRed:97.0/255.0 green:106.0/255.0 blue:119.0/255.0 alpha:1.0]];
    [placeDescriptionText setBackgroundColor:[UIColor clearColor]];
    [placeDescriptionText setNumberOfLines:0];
    [placeDescriptionText setVerticalAlignment:TTTAttributedLabelVerticalAlignmentTop];
    [placeDescriptionText setLineHeightMultiple:1.25f];
//    [placeDescriptionText setText:[place placeDescription]];
    [placeDescriptionText setText:@"Proin sit amet dapibus purus, sit amet tempor erat. Suspendisse at enim vel lectus aliquet varius vel sed massa. Nunc bibendum scelerisque magna, id imperdiet nulla aliquam non. Nullam sed augue vestibulum, tincidunt orci sed, accumsan lectus. Phasellus non ornare leo, vel rhoncus quam. Donec id diam aliquet, lobortis sem nec, semper diam. Vivamus in eros nunc. Aenean tempor pretium lorem. Proin fringilla. Proin sit amet dapibus purus, sit amet tempor erat. Suspendisse at enim vel lectus aliquet varius vel sed massa. Nunc bibendum scelerisque magna, id imperdiet nulla aliquam non. Nullam sed augue vestibulum, tincidunt orci sed, accumsan lectus. Phasellus non ornare leo, vel rhoncus quam. Donec id diam aliquet, lobortis sem nec, semper diam. Vivamus in eros nunc. Aenean tempor pretium lorem. Proin fringilla. Proin sit amet dapibus purus, sit amet tempor erat."];
    [placeDescriptionText sizeToFit];
    [placeDetailsView addSubview:placeDescriptionText];
    
    UIView *placeButtonsView = [[UIView alloc] initWithFrame:CGRectMake(20, placeDescriptionText.frame.origin.y + placeDescriptionText.frame.size.height, self.view.frame.size.width - 40, 35)];
    [placeDetailsView addSubview:placeButtonsView];
    
    BRLNFlatButton *placeShareButton = [BRLNFlatButton buttonWithType:UIButtonTypeCustom];
    [placeShareButton setFrame:CGRectMake(0, 0, placeButtonsView.frame.size.width/2 - 5, placeButtonsView.frame.size.height)];
    [placeShareButton setTitle:@"Share via email" forState:UIControlStateNormal];
    [placeShareButton addTarget:self action:@selector(shareViaEmail:) forControlEvents:UIControlEventTouchUpInside];
    [placeButtonsView addSubview:placeShareButton];
    
    
    BRLNFlatButton *placeWebsiteButton = [BRLNFlatButton buttonWithType:UIButtonTypeCustom];
    [placeWebsiteButton setFrame:CGRectMake(placeButtonsView.frame.size.width/2 + 5, 0, placeButtonsView.frame.size.width/2 - 5, placeButtonsView.frame.size.height)];
    [placeWebsiteButton setTitle:@"Visit website" forState:UIControlStateNormal];
    [placeWebsiteButton addTarget:self action:@selector(openLink:) forControlEvents:UIControlEventTouchUpInside];
    [placeWebsiteButton setEnabled:([[place placeUrl] isEqualToString:@"-"] ? NO : YES)];
    [placeButtonsView addSubview:placeWebsiteButton];

    
    [placeDetailsView setFrame:CGRectMake(0, 200, self.view.frame.size.width, placeButtonsView.frame.origin.y + placeButtonsView.frame.size.height + 20)];
    [placeWrapperView setFrame:CGRectMake(0, 0, self.view.frame.size.width, placeDetailsView.frame.origin.y + placeDetailsView.frame.size.height)];
    [scrollView addSubview:placeWrapperView];
    [scrollView setContentSize:CGSizeMake(placeWrapperView.frame.size.width, placeDetailsView.frame.size.height + placeDetailsView.frame.origin.y)];
    [scrollView setBackgroundColor:[UIColor _whiteColor]];
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

- (void)showMap:(id)sender
{
    MapViewController *mvc = [[MapViewController alloc] init];
    [mvc setPlaces:[[NSMutableArray alloc] initWithObjects:place, nil]];
    [mvc setMapAnnotatesClickable:NO];
    
    [self.navigationController pushViewController:mvc animated:YES];
}

- (void)toggleFavorite:(id)sender
{
    if ([place favorited])
    {
        [place setFavorited:NO];
    } else
    {
        [place setFavorited:YES];
    }
    
    NSError *error = nil;
    [managedObjectContext save:&error];
    
    if (error) {
        NSLog(@"ERROR: Save request raised an error - %@", [error description]);
    }
}

- (void)openLink:(id)sender
{
    NSString *url = [place placeUrl];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
}

- (void)shareViaEmail:(id)sender
{
    MFMailComposeViewController *emailController = [[MFMailComposeViewController alloc] init];
    [emailController setMailComposeDelegate:self];
	[emailController setSubject:[NSString stringWithFormat:@"BRLN - %@", [place placeName]]];
	[emailController setMessageBody:[place placeDescription] isHTML:NO];
	[self presentViewController:emailController animated:YES completion:nil];
}

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
	[self becomeFirstResponder];
	[self dismissViewControllerAnimated:YES completion:nil];
}

# pragma mark - helpers


@end
