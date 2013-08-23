//
//  CategoriesViewController.m
//  BRLN
//
//  Created by Weronika Zawila-Bromirska on 7/22/13.
//  Copyright (c) 2013 home. All rights reserved.
//

#import "DatabaseHelper.h"
#import "ImportDataHelper.h"

#import "CategoriesViewController.h"
#import "PlacesViewController.h"

#import "CategoryViewCell.h"
#import "LKBadgeView.h"

#import "Category.h"

@implementation CategoriesViewController

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
    
    [self setTitle:@"Categories"];

    // set context - DatabaseHelper
    [self setManagedObjectContext:[[DatabaseHelper sharedInstance] managedObjectContext]];
    
    NSError *error;
    if (![[self fetchedResultsController] performFetch:&error]) {
        // update to handle the error
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
    }
    
    if ([[_fetchedResultsController fetchedObjects] count] == 0) {
        [[ImportDataHelper sharedInstance] importData];
        [[self tableView ] reloadData];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSString *)tabImageName
{
	return @"icon-list";
}

#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    id sectionInfo = [[_fetchedResultsController sections] objectAtIndex:section];
    return [sectionInfo numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CategoryViewCellIdentifier";
    CategoryViewCell *cell = (CategoryViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        NSArray *nibObjects = [[NSBundle mainBundle] loadNibNamed:@"CategoryViewCell" owner:nil options:nil];
        
        for (id currentObject in nibObjects)
        {
            if ([currentObject isKindOfClass:[CategoryViewCell class]])
            {
                cell = (CategoryViewCell *)currentObject;
            }
        }
    }

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
    [request setFetchBatchSize:10];
    
    NSFetchedResultsController *theFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:managedObjectContext sectionNameKeyPath:nil cacheName:@"CategoryCache"];
    
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
            // custom cell requires extra (CategoryViewCell *)
            [self configureCell:(CategoryViewCell *)[tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
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

- (void)configureCell:(CategoryViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    [[cell categoryNameLabel] setText:[[_fetchedResultsController objectAtIndexPath:indexPath] categoryName]];
    [[cell categoryDescriptionLabel] setText:[[_fetchedResultsController objectAtIndexPath:indexPath] categoryDescription]];
    [[cell categoryBadge] setText:[NSString stringWithFormat:@"%d", [[[_fetchedResultsController objectAtIndexPath:indexPath] places] count ]]];
}

- (NSInteger)numberOfPlacesForCategory:(NSString *)categoryName atIndexPath:(NSIndexPath *)indexPath
{
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Place" inManagedObjectContext:managedObjectContext];
    NSSortDescriptor *sort = [[NSSortDescriptor alloc] initWithKey:@"placeName" ascending:YES];    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"category.categoryName == %@", [[_fetchedResultsController objectAtIndexPath:indexPath] categoryName]];
    [request setEntity:entity];
    [request setPredicate:predicate];
    [request setSortDescriptors:[NSArray arrayWithObject:sort]];
    [request setIncludesSubentities:NO];
    
    NSError *error = nil;
    NSUInteger recordsCount = [managedObjectContext countForFetchRequest:request error:&error];
    
    return recordsCount;
}

@end
