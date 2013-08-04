//
//  CategoriesViewController.m
//  BRLN
//
//  Created by Weronika Zawila-Bromirska on 7/22/13.
//  Copyright (c) 2013 home. All rights reserved.
//

#import "CategoriesViewController.h"
#import "PlacesViewController.h"

#import "Category.h"
#import "Place.h"
#import "PlaceLocation.h"

@implementation CategoriesViewController

@synthesize managedObjectContext;
@synthesize categories;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        [self setTitle:@"Categories"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    [self getAllCategories];    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [categories count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CategoryCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    NSString *cellName = [[categories objectAtIndex:[indexPath row]] categoryName];
    [[cell textLabel] setText:cellName];
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{    
    PlacesViewController *placesViewController = [[PlacesViewController alloc] initWithStyle:UITableViewStylePlain];
    [placesViewController setManagedObjectContext:[self managedObjectContext]];
    [placesViewController setCurrentCategory:[[categories objectAtIndex:[indexPath row]] categoryName]];
    
    [self.navigationController pushViewController:placesViewController animated:YES];
}

#pragma mark - CoreData - helpers

- (void)getAllCategories
{
    NSEntityDescription *categoryEntity = [NSEntityDescription entityForName:@"Category" inManagedObjectContext:managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:categoryEntity];
    
    NSError *error;
    NSArray *results = [managedObjectContext executeFetchRequest:request error:&error];
    
    if (!results || error) {
        NSLog(@"ERROR: Fetch request raised an error - %@", [error description]);
    }
    
    if ([results count] == 0) {
        [self importData];
    } else {
        categories = [[NSMutableArray alloc] initWithArray:results];
    }
}

- (void)importData
{
    categories = [[NSMutableArray alloc] init];
    
    NSError *jsonError;
    NSString *jsonDataPath = [[NSBundle mainBundle] pathForResource:@"data" ofType:@"json"];
    NSDictionary *jsonResults = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:jsonDataPath] options:kNilOptions error:&jsonError];
    
    NSEnumerator *enumeratorCategories = [[jsonResults objectForKey:@"data"] objectEnumerator];
    id enumeratorCategory;

    while (enumeratorCategory = [enumeratorCategories nextObject]) {
        Category *c = [NSEntityDescription insertNewObjectForEntityForName:@"Category" inManagedObjectContext:managedObjectContext];
        [c setCategoryName:[enumeratorCategory valueForKey:@"categoryName"]];
        
        NSEnumerator *enumeratorPlaces = [[enumeratorCategory objectForKey:@"places"] objectEnumerator];
        id enumeratorPlace;
        
        while (enumeratorPlace = [enumeratorPlaces nextObject]) {
            Place *place = [NSEntityDescription insertNewObjectForEntityForName:@"Place" inManagedObjectContext:managedObjectContext];
            [place setPlaceName:[enumeratorPlace valueForKey:@"placeName"]];
            [place setPlaceDescription:[enumeratorPlace valueForKey:@"placeDescription"]];
            [place setPlaceUrl:[enumeratorPlace valueForKey:@"placeUrl"]];

            PlaceLocation *placeLocation = [NSEntityDescription insertNewObjectForEntityForName:@"PlaceLocation" inManagedObjectContext:managedObjectContext];
            [placeLocation setLatitude:[[[enumeratorPlace objectForKey:@"placeLocation"] valueForKey:@"lat"] doubleValue]];
            [placeLocation setLongitude:[[[enumeratorPlace objectForKey:@"placeLocation"] valueForKey:@"long"] doubleValue]];

            [place setPlaceLocation:placeLocation];
            NSLog(@"IMPORT: added place location");
            
            [c addPlacesObject:place];
            NSLog(@"IMPORT: added place");
        }
        
        NSError *error;
        [managedObjectContext save:&error];

        if (error) {
            NSLog(@"ERROR: Save raised an error - %@", [error description]);
        }
        
        [categories addObject:c];
        NSLog(@"IMPORT: added category");
    }
    
    [[self tableView ] reloadData];
}

@end
