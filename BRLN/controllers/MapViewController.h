//
//  MapViewController.h
//  BRLN
//
//  Created by Weronika Zawila-Bromirska on 7/22/13.
//  Copyright (c) 2013 home. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

#import "Place.h"

@interface MapViewController : UIViewController <CLLocationManagerDelegate, MKMapViewDelegate>
{
    CLLocationManager *locationManager;
 
    NSMutableArray *places;
    
    __weak IBOutlet UINavigationBar *navigationBar;
    __weak IBOutlet MKMapView *mapView;
    
    BOOL mapAnnotatesClickable;
    NSString *mapPredicateType;
}

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain) NSMutableArray *places;
@property (nonatomic) BOOL mapAnnotatesClickable;
@property (nonatomic) NSString *mapPredicateType;

- (id)initWithMapPredicateType:(NSString *)predicateType;

- (void)initPlaces;
- (void)initMapView;

- (NSArray *)getPlacesAnnotations;

@end
