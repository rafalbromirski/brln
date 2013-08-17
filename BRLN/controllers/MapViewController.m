//
//  MapViewController.m
//  BRLN
//
//  Created by Weronika Zawila-Bromirska on 7/22/13.
//  Copyright (c) 2013 home. All rights reserved.
//

#import "DatabaseHelper.h"

#import "MapViewController.h"
#import "DetailsViewController.h"
#import "PlacesViewController.h"

#import "Place.h"
#import "PlaceLocation.h"
#import "PlaceAnnotation.h"

static double location_lat = 52.52426800;
static double location_long = 13.40629000;
static double location_distance = 7000;


@implementation MapViewController

@synthesize managedObjectContext;
@synthesize places;
@synthesize mapAnnotatesClickable;
@synthesize mapPredicateType;

- (id)init
{
    self = [super init];
    if (self) {
        [self setMapAnnotatesClickable:YES];
        
        locationManager = [[CLLocationManager alloc] init];
        [locationManager setDelegate:self];
        [locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
        NSLog(@"init");
    }
    return self;
}

- (id)initWithMapPredicateType:(NSString *)predicateType
{
    self = [super init];
    if (self) {
        [self setMapAnnotatesClickable:YES];
        [self setMapPredicateType:predicateType];
    }
    return self;
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setTitle:@"Map"];    
    
    // set context - DatabaseHelper
    [self setManagedObjectContext:[[DatabaseHelper sharedInstance] managedObjectContext]];
    
    
    if (!places) {
        [self initPlaces];
    }
    [self initMapView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];    
    [mapView deselectAnnotation:[mapView.selectedAnnotations objectAtIndex:0] animated:NO];    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [locationManager setDelegate:nil];
}

- (NSString *)tabImageName
{
	return @"icon-map";
}

#pragma mark - custom inits

- (void)initPlaces
{
    NSEntityDescription *placeEntity = [NSEntityDescription entityForName:@"Place" inManagedObjectContext:managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:placeEntity];
    
    if ([[self mapPredicateType] isEqualToString:@"favorites"]) {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"favorited == YES"];
        [request setPredicate:predicate];
    }
    
    NSError *error;
    NSArray *results = [managedObjectContext executeFetchRequest:request error:&error];
    
    if (!results || error) {
        NSLog(@"ERROR: Fetch request raised an error - %@", [error description]);
    }
    
    places = [[NSMutableArray alloc] initWithArray:results];
}

- (void)initMapView
{
    // TODO - CONST file
    CLLocationCoordinate2D loc = CLLocationCoordinate2DMake(location_lat, location_long);
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(loc, location_distance, location_distance);
    [mapView setRegion:region];
    [mapView setShowsUserLocation:YES];
    [mapView addAnnotations:[self getPlacesAnnotations]];
}

#pragma mark - CoreLocation helpers

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    NSLog(@"location: %@", locations);
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"Could not find location: %@", error);
}

#pragma mark - MapKit

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    NSLog(@"user location: %@", userLocation);
}

- (MKAnnotationView *)mapView:(MKMapView *)map viewForAnnotation:(id<MKAnnotation>)annotation
{
    // If it's the user location, just return nil.
    if ([annotation isKindOfClass:[MKUserLocation class]])
    {
        return nil;
    }

    // If it's the PlaceAnnotation then style it!    
    if ([annotation isKindOfClass:[PlaceAnnotation class]])
    {
        // try to dequeue an existing pin view first
        static NSString *PlaceAnnotationIdentifier = @"PlaceAnnodationIdentifier";
        MKPinAnnotationView *annotationView = (MKPinAnnotationView *) [map dequeueReusableAnnotationViewWithIdentifier:PlaceAnnotationIdentifier];
        
        if (annotationView == nil)
        {
            // if an existing pin view was not available, create one
            MKPinAnnotationView *customAnnotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:PlaceAnnotationIdentifier];
            [customAnnotationView setCanShowCallout:YES];
            [customAnnotationView setAnimatesDrop:YES];
            
            if ([self mapAnnotatesClickable])
            {
                UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
                [rightButton addTarget:nil action:nil forControlEvents:UIControlEventTouchUpInside];
            
                [customAnnotationView setRightCalloutAccessoryView:rightButton];
            }
            
            return customAnnotationView;
        }
        else
        {
            annotationView.annotation = annotation;
        }
        
        return annotationView;
    }
    
    return nil;
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    PlaceAnnotation *annotation = [view annotation];
    
    DetailsViewController *detailsViewController = [[DetailsViewController alloc] initWithNibName:@"DetailsViewController" bundle:nil];
    [detailsViewController setPlace:[annotation place]];
    [detailsViewController setMapButtonVisible:NO];
    
    [self.navigationController pushViewController:detailsViewController animated:YES];
}

#pragma mark - helpers

- (NSArray *)getPlacesAnnotations
{
    NSMutableArray *annotations = [[NSMutableArray alloc] init];
    
    for (Place *place in places)
    {        
        PlaceAnnotation *pa = [[PlaceAnnotation alloc] initWithPlace:place];
        [annotations addObject:pa];
    }
    
    return annotations;
}

@end
