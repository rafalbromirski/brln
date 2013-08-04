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
 
    NSManagedObjectContext *managedObjectContext;    
    NSMutableArray *places;
    
    __weak IBOutlet UINavigationBar *navigationBar;
    __weak IBOutlet MKMapView *mapView;
}

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain) NSMutableArray *places;
@property (nonatomic, retain) NSString *currentCategory;

- (void)initData;
- (void)initMapView;

- (NSArray *)getPlacesAnnotations;

@end
