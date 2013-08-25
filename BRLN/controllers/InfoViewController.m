//
//  InfoViewController.m
//  BRLN
//
//  Created by Weronika Zawila-Bromirska on 7/22/13.
//  Copyright (c) 2013 home. All rights reserved.
//

#import "InfoViewController.h"

#import "BRLNFlatButton.h"

@implementation InfoViewController

//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
//{
//    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//    if (self) {
//        // Custom initialization      
//    }
//    return self;
//}

- (id)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    
    [[self view] setBackgroundColor:[UIColor _primaryColor]];
    
    UILabel *logo = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, screenWidth, 150)];
    [logo setFont:[UIFont fontWithName:@"Lato-Light" size:50.0]];
    [logo setTextColor:[UIColor _whiteColor]];
    [logo setBackgroundColor:[UIColor clearColor]];
    [logo setTextAlignment:NSTextAlignmentCenter];
    [logo setText:@"B  R  L  N"];
    
    UILabel *version = [[UILabel alloc] initWithFrame:CGRectMake(0, 110, screenWidth, 20)];
    [version setFont:[UIFont fontWithName:@"Lato-Light" size:9.0]];
    [version setTextColor:[UIColor _whiteColor]];
    [version setBackgroundColor:[UIColor clearColor]];
    [version setTextAlignment:NSTextAlignmentCenter];
    [version setText:@"v 1.0"];
    
    
    UIView *buttonsView = [[UIView alloc] initWithFrame:CGRectMake(20, screenHeight - 215, screenWidth - 40, 125)];
    
    BRLNFlatButton *rateButton = [[BRLNFlatButton alloc] initWithFrame:CGRectMake(0, 0, buttonsView.frame.size.width, 35)];
    [rateButton setText:@"Rate on AppStore"];
    [rateButton setBackgroundColor:[UIColor _primaryColor]];
    [rateButton setBackgroundHighlightedColor:[UIColor whiteColor]];
    [rateButton setBorderColor:[[UIColor whiteColor] colorWithAlphaComponent:0.4]];
    [rateButton setBorderHighlightedColor:[UIColor whiteColor]];
    [rateButton setTextColor:[UIColor _whiteColor]];
    [rateButton setTextHighlightedColor:[UIColor _primaryColor]];
    [buttonsView addSubview:rateButton];

    BRLNFlatButton *websiteButton = [[BRLNFlatButton alloc] initWithFrame:CGRectMake(0, 45, buttonsView.frame.size.width, 35)];
    [websiteButton setText:@"Visit our website"];
    [websiteButton setBackgroundColor:[UIColor _primaryColor]];
    [websiteButton setBackgroundHighlightedColor:[UIColor whiteColor]];    
    [websiteButton setBorderColor:[[UIColor whiteColor] colorWithAlphaComponent:0.3]];
    [websiteButton setBorderHighlightedColor:[UIColor whiteColor]];
    [websiteButton setTextColor:[UIColor _whiteColor]];
    [websiteButton setTextHighlightedColor:[UIColor _primaryColor]];
    [buttonsView addSubview:websiteButton];    
    
    BRLNFlatButton *contactButton = [[BRLNFlatButton alloc] initWithFrame:CGRectMake(0, 90, buttonsView.frame.size.width, 35)];
    [contactButton setText:@"Contact us: support@xyz.com"];
    [contactButton setBackgroundColor:[UIColor _primaryColor]];
    [contactButton setBackgroundHighlightedColor:[UIColor whiteColor]];        
    [contactButton setBorderColor:[[UIColor whiteColor] colorWithAlphaComponent:0.4]];
    [contactButton setBorderHighlightedColor:[UIColor whiteColor]];
    [contactButton setTextColor:[UIColor _whiteColor]];
    [contactButton setTextHighlightedColor:[UIColor _primaryColor]];
    [buttonsView addSubview:contactButton];
    
    [[self view] addSubview:logo];
    [[self view] addSubview:version];
    [[self view] addSubview:buttonsView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSString *)tabImageName
{
	return @"icon-info";
}

@end
