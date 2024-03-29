//
//  FavoritesViewController.m
//  BRLN
//
//  Created by Weronika Zawila-Bromirska on 7/22/13.
//  Copyright (c) 2013 home. All rights reserved.
//
#import "DatabaseHelper.h"

#import "FavoritesViewController.h"
#import "DetailsViewController.h"
#import "MapViewController.h"

#import "PlaceViewCell.h"

#import "Category.h"
#import "Place.h"

@implementation FavoritesViewController

@synthesize managedObjectContext;
@synthesize fetchedResultsController = _fetchedResultsController;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Custom initialization
    [self setTitle:@"Favorites"];
    
    [[self navigationItem] setLeftBarButtonItem:[self editButtonItem]];
    
    UIBarButtonItem *location = [[UIBarButtonItem alloc] initWithTitle:@"Map" style:UIBarButtonItemStyleBordered target:self action:@selector(showOnMap:)];
    [[self navigationItem] setRightBarButtonItem:location];
    
    // set context - DatabaseHelper
    [self setManagedObjectContext:[[DatabaseHelper sharedInstance] managedObjectContext]];
    
    NSError *error;
    if (![[self fetchedResultsController] performFetch:&error]) {
        // update to handle the error
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
    }
}

- (void)viewWillAppear
{ 
    [[self tableView] reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSString *)tabImageName
{
	return @"icon-favorites";
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [[self.fetchedResultsController sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    id <NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:section];
    return [sectionInfo numberOfObjects];
}

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    // Display the category names as section headings
//    return [[[self.fetchedResultsController sections] objectAtIndex:section] name];
//}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"PlaceViewCellIdentifier";
    PlaceViewCell *cell = (PlaceViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        NSArray *nibObjects = [[NSBundle mainBundle] loadNibNamed:@"PlaceViewCell" owner:nil options:nil];
        
        for (id currentObject in nibObjects)
        {
            if ([currentObject isKindOfClass:[PlaceViewCell class]])
            {
                cell = (PlaceViewCell *)currentObject;
            }
        }
    }
    
    // Configure the cell...
    [self configureCell:cell atIndexPath:indexPath];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [[_fetchedResultsController objectAtIndexPath:indexPath] setFavorited:NO];
        
        NSError *error = nil;
        [managedObjectContext save:&error];
        
        if (error) {
            NSLog(@"ERROR: Save request raised an error - %@", [error description]);
        }
    }
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailsViewController *detailsViewController = [[DetailsViewController alloc] initWithNibName:@"DetailsViewController" bundle:nil];
    [detailsViewController setPlace:[_fetchedResultsController objectAtIndexPath:indexPath]];
    
    [self.navigationController pushViewController:detailsViewController animated:YES];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectZero];
    [headerView setBackgroundColor:[UIColor _grayLightColor]];

    NSString *headerText = [NSString stringWithString:[[[self.fetchedResultsController sections] objectAtIndex:section] name]];
    
    UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, tableView.frame.size.width - 40, 20)];
    [headerLabel setText:headerText];
    [headerLabel setBackgroundColor:[UIColor clearColor]];
    [headerLabel setFont:[UIFont fontWithName:@"Lato-Bold" size:12.0]];
    [headerLabel setTextColor:[UIColor colorWithRed:57.0/255.0 green:65.0/255.0 blue:76.0/255.0 alpha:0.6]];
    [headerView addSubview:headerLabel];
    
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 22.0;
}

#pragma mark - FetchResultsController delegate

- (NSFetchedResultsController *)fetchedResultsController
{
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Place" inManagedObjectContext:managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSSortDescriptor *sort = [[NSSortDescriptor alloc] initWithKey:@"placeName" ascending:YES];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"favorited == YES"];
    
    [request setEntity:entity];
    [request setSortDescriptors:[NSArray arrayWithObject:sort]];
    [request setPredicate:predicate];
    [request setFetchBatchSize:20];
    
    NSFetchedResultsController *theFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:managedObjectContext sectionNameKeyPath:@"category.categoryName" cacheName:nil];
    
    [self setFetchedResultsController:theFetchedResultsController];
    [_fetchedResultsController setDelegate:self];
    
    return _fetchedResultsController;
}

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
    // The fetch controller is about to start sending change notifications, so prepare the table view for updates.
    // bug? when updating favorites from detailsViewController app crashed ;(
    [self.tableView beginUpdates];
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
            [self configureCell:(PlaceViewCell *)[tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
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

- (void)configureCell:(PlaceViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    [[cell placeNameLabel] setText:[[_fetchedResultsController objectAtIndexPath:indexPath] placeName]];
}

- (void)showOnMap:(id)sender
{
    MapViewController *mvc = [[MapViewController alloc] initWithMapPredicateType:@"favorites"];
    [mvc setMapAnnotatesClickable:NO];
    
    [self.navigationController pushViewController:mvc animated:YES];
}


@end
