//
//  PlacesViewController.m
//  BRLN
//
//  Created by Weronika Zawila-Bromirska on 7/23/13.
//  Copyright (c) 2013 home. All rights reserved.
//

#import "PlacesViewController.h"
#import "DetailsViewController.h"

#import "Category.h"
#import "Place.h"

@implementation PlacesViewController

@synthesize managedObjectContext;
@synthesize places;
@synthesize currentCategory;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        [self setTitle:@"Places"];
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
    [self getPlacesWith:currentCategory];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [places count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"PlaceCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    NSString *cellName = [[places objectAtIndex:[indexPath row]] placeName];
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
    DetailsViewController *detailsViewController = [[DetailsViewController alloc] initWithNibName:@"DetailsViewController" bundle:nil];
    [detailsViewController setPlace:[places objectAtIndex:[indexPath row]]];
    [detailsViewController setManagedObjectContext:managedObjectContext];
    
    [self.navigationController pushViewController:detailsViewController animated:YES];
}

#pragma mark - CoreData - helpers

- (void)getAllPlaces
{
    NSEntityDescription *placeEntity = [NSEntityDescription entityForName:@"Place" inManagedObjectContext:managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:placeEntity];

    NSError *error;
    NSArray *results = [managedObjectContext executeFetchRequest:request error:&error];
    
    if (!results || error) {
        NSLog(@"ERROR: Fetch request raised an error - %@", [error description]);
    }
    
    places = [[NSMutableArray alloc] initWithArray:results];
}

- (void)getPlacesWith:(NSString *)categoryName
{
    NSEntityDescription *placeEntity = [NSEntityDescription entityForName:@"Place" inManagedObjectContext:managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:placeEntity];
    
    NSPredicate *placePredicate = [NSPredicate predicateWithFormat:@"category.categoryName like %@", categoryName];
    [request setPredicate:placePredicate];
    
    NSError *error;
    NSArray *results = [managedObjectContext executeFetchRequest:request error:&error];
    
    if (!results || error) {
        NSLog(@"ERROR: Fetch request raised an error - %@", [error description]);
    }
    
    places = [[NSMutableArray alloc] initWithArray:results];
}

@end
