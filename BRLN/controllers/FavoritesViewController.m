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

#import "Place.h"

@implementation FavoritesViewController

@synthesize managedObjectContext;
@synthesize places;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        [self setTitle:@"Favorites"];
        
        [[self navigationItem] setLeftBarButtonItem:[self editButtonItem]];    
        
        UIBarButtonItem *location = [[UIBarButtonItem alloc] initWithTitle:@"Map" style:UIBarButtonItemStyleBordered target:self action:@selector(showOnMap:)];
        [[self navigationItem] setRightBarButtonItem:location];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // set context - DatabaseHelper
    [self setManagedObjectContext:[[DatabaseHelper sharedInstance] managedObjectContext]];
    
//    [self getFavoritedPlaces];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self getFavoritedPlaces];
    [[self tableView] reloadData];
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
    static NSString *CellIdentifier = @"FavoriteCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    NSString *cellName = [[places objectAtIndex:[indexPath row]] placeName];
    [[cell textLabel] setText:cellName];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [places objectAtIndex:[indexPath row]];
        [places removeObjectAtIndex:[indexPath row]];
        
        NSError *error = nil;
        [managedObjectContext save:&error];
        
        if (error) {
            NSLog(@"ERROR: Remove request raised an error - %@", [error description]);
        }
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailsViewController *detailsViewController = [[DetailsViewController alloc] initWithNibName:@"DetailsViewController" bundle:nil];
    [detailsViewController setPlace:[places objectAtIndex:[indexPath row]]];
    
    [self.navigationController pushViewController:detailsViewController animated:YES];
}

#pragma mark - Table view actions

- (void)showOnMap:(id)sender
{
    NSLog(@"Show on map!");
    [[self tableView] reloadData];
}

#pragma mark - CoreData - helpers

- (void)getFavoritedPlaces
{
    NSEntityDescription *placeEntity = [NSEntityDescription entityForName:@"Place" inManagedObjectContext:managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:placeEntity];
    
    NSPredicate *placePredicate = [NSPredicate predicateWithFormat:@"favorited == YES"];
    [request setPredicate:placePredicate];
    
    NSError *error;
    NSArray *results = [managedObjectContext executeFetchRequest:request error:&error];
    
    if (!results || error) {
        NSLog(@"ERROR: Fetch request raised an error - %@", [error description]);
    }
    
    places = [[NSMutableArray alloc] initWithArray:results]; 
}

@end
