//
//  CategoriesViewController.m
//  BRLN
//
//  Created by Weronika Zawila-Bromirska on 7/22/13.
//  Copyright (c) 2013 home. All rights reserved.
//

#import "DatabaseHelper.h"

#import "CategoriesViewController.h"
#import "PlacesViewController.h"

#import "Category.h"
//#import "Place.h"
//#import "PlaceLocation.h"

@implementation CategoriesViewController

@synthesize managedObjectContext;
@synthesize fetchedResultsController = _fetchedResultsController;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setTitle:@"Categories"];

    // set context - DatabaseHelper
    [self setManagedObjectContext:[[DatabaseHelper sharedInstance] managedObjectContext]];
    
    NSError *error;
    if (![[self fetchedResultsController] performFetch:&error]) {
        // update to handle the error
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        exit(-1); //Fail
    }
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
    id sectionInfo = [[_fetchedResultsController sections] objectAtIndex:section];
    return [sectionInfo numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CategoryCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    [self configureCell:cell atIndexPath:indexPath];
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{    
    PlacesViewController *placesViewController = [[PlacesViewController alloc] initWithStyle:UITableViewStylePlain];
    [placesViewController setCurrentCategory:[[_fetchedResultsController objectAtIndexPath:indexPath] categoryName]];
    
    [self.navigationController pushViewController:placesViewController animated:YES];
}

#pragma mark - FetchResultsController delegate

- (NSFetchedResultsController *)fetchedResultsController
{
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Category" inManagedObjectContext:managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSSortDescriptor *sort = [[NSSortDescriptor alloc] initWithKey:@"categoryName" ascending:YES];
    
    [request setEntity:entity];
    [request setSortDescriptors:[NSArray arrayWithObject:sort]];
    [request setFetchBatchSize:20];
    
    NSFetchedResultsController *theFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:managedObjectContext sectionNameKeyPath:nil cacheName:@"Root"];
    
    [self setFetchedResultsController:theFetchedResultsController];
    [_fetchedResultsController setDelegate:self];
    
    return _fetchedResultsController;
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath
{
    UITableView *tableView = [self tableView];
    
    switch(type)
    {            
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
            [self configureCell:[tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];            
            break;
            
        case NSFetchedResultsChangeMove:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id )sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
    
    switch(type)
    {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}


- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    // The fetch controller has sent all current change notifications, so tell the table view to process all updates.
    [self.tableView endUpdates];
}

#pragma mark - Controller helpers

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    NSString *cellName = [[_fetchedResultsController objectAtIndexPath:indexPath] categoryName];
    [[cell textLabel] setText:cellName];
}

#pragma mark - CoreData - helpers / imports

//- (void)getAllCategories
//{
//    NSEntityDescription *categoryEntity = [NSEntityDescription entityForName:@"Category" inManagedObjectContext:managedObjectContext];
//    NSFetchRequest *request = [[NSFetchRequest alloc] init];
//    [request setEntity:categoryEntity];
//    
//    NSError *error;
//    NSArray *results = [managedObjectContext executeFetchRequest:request error:&error];
//    
//    if (!results || error) {
//        NSLog(@"ERROR: Fetch request raised an error - %@", [error description]);
//    }
//    
//    if ([results count] == 0) {
//        [self importData];
//    } else {
//        categories = [[NSMutableArray alloc] initWithArray:results];
//    }
//}

// TODO: extract logic from the controller into separate class

//- (void)importData
//{
//    categories = [[NSMutableArray alloc] init];
//    
//    NSError *jsonError;
//    NSString *jsonDataPath = [[NSBundle mainBundle] pathForResource:@"data" ofType:@"json"];
//    NSDictionary *jsonResults = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:jsonDataPath] options:kNilOptions error:&jsonError];
//    
//    NSEnumerator *enumeratorCategories = [[jsonResults objectForKey:@"data"] objectEnumerator];
//    id enumeratorCategory;
//
//    while (enumeratorCategory = [enumeratorCategories nextObject]) {
//        Category *c = [NSEntityDescription insertNewObjectForEntityForName:@"Category" inManagedObjectContext:managedObjectContext];
//        [c setCategoryName:[enumeratorCategory valueForKey:@"categoryName"]];
//        
//        NSEnumerator *enumeratorPlaces = [[enumeratorCategory objectForKey:@"places"] objectEnumerator];
//        id enumeratorPlace;
//        
//        while (enumeratorPlace = [enumeratorPlaces nextObject]) {
//            Place *place = [NSEntityDescription insertNewObjectForEntityForName:@"Place" inManagedObjectContext:managedObjectContext];
//            [place setPlaceName:[enumeratorPlace valueForKey:@"placeName"]];
//            [place setPlaceDescription:[enumeratorPlace valueForKey:@"placeDescription"]];
//            [place setPlaceUrl:[enumeratorPlace valueForKey:@"placeUrl"]];
//
//            PlaceLocation *placeLocation = [NSEntityDescription insertNewObjectForEntityForName:@"PlaceLocation" inManagedObjectContext:managedObjectContext];
//            [placeLocation setLatitude:[[[enumeratorPlace objectForKey:@"placeLocation"] valueForKey:@"lat"] doubleValue]];
//            [placeLocation setLongitude:[[[enumeratorPlace objectForKey:@"placeLocation"] valueForKey:@"long"] doubleValue]];
//
//            [place setPlaceLocation:placeLocation];
//            NSLog(@"IMPORT: added place location");
//            
//            [c addPlacesObject:place];
//            NSLog(@"IMPORT: added place");
//        }
//        
//        NSError *error;
//        [managedObjectContext save:&error];
//
//        if (error) {
//            NSLog(@"ERROR: Save raised an error - %@", [error description]);
//        }
//        
//        [categories addObject:c];
//        NSLog(@"IMPORT: added category");
//    }
//    
//    [[self tableView ] reloadData];
//}

@end
