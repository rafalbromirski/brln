//
//  StyleguideViewController.m
//  BRLN
//
//  Created by Weronika Zawila-Bromirska on 8/24/13.
//  Copyright (c) 2013 home. All rights reserved.
//

#import "StyleguideViewController.h"

@interface StyleguideViewController ()

@end

@implementation StyleguideViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        UILabel *whiteColorLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
        [whiteColorLabel setTextAlignment:NSTextAlignmentCenter];
        [whiteColorLabel setText:@"_whiteColor"];
        [whiteColorLabel setBackgroundColor:[UIColor _whiteColor]];
        
        UILabel *grayLightColorLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 44 * 1, self.view.frame.size.width, 44)];
        [grayLightColorLabel setTextAlignment:NSTextAlignmentCenter];
        [grayLightColorLabel setText:@"_grayLightColor"];
        [grayLightColorLabel setBackgroundColor:[UIColor _grayLightColor]];
        
        UILabel *grayColorLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 44 * 2, self.view.frame.size.width, 44)];
        [grayColorLabel setTextAlignment:NSTextAlignmentCenter];
        [grayColorLabel setText:@"_grayColor"];
        [grayColorLabel setBackgroundColor:[UIColor _grayColor]];
        
        UILabel *grayDarkColorLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 44 * 3, self.view.frame.size.width, 44)];
        [grayDarkColorLabel setTextAlignment:NSTextAlignmentCenter];
        [grayDarkColorLabel setText:@"_grayDarkColor"];
        [grayDarkColorLabel setBackgroundColor:[UIColor _grayDarkColor]];
        
        UILabel *blackColorLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 44 * 4, self.view.frame.size.width, 44)];
        [blackColorLabel setTextAlignment:NSTextAlignmentCenter];
        [blackColorLabel setText:@"_blackColor"];
        [blackColorLabel setBackgroundColor:[UIColor _blackColor]];
        
        UILabel *primaryColorLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 44 * 5, self.view.frame.size.width, 44)];
        [primaryColorLabel setTextAlignment:NSTextAlignmentCenter];
        [primaryColorLabel setText:@"_primaryColor"];
        [primaryColorLabel setBackgroundColor:[UIColor _primaryColor]];
        
        [[self view] addSubview:whiteColorLabel];
        [[self view] addSubview:grayLightColorLabel];
        [[self view] addSubview:grayColorLabel];
        [[self view] addSubview:grayDarkColorLabel];
        [[self view] addSubview:blackColorLabel];
        
        [[self view] addSubview:primaryColorLabel];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
