//
//  MasterViewController.m
//  MasterDetailGallery
//
//  Created by pony wu on 14-2-14.
//  Copyright (c) 2014年 pony wu. All rights reserved.
//

#import "StationListViewController.h"
#import "DetailViewController.h"
#import "Clock.h"
#import "Station.h"
#import "ImageHelper-Files.h"
#import "AddClockViewController.h"
#import "Constants.h"

@interface StationListViewController ()
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;
@end

@implementation StationListViewController

@synthesize clock, stations, tableHeaderView, imageButton, clockNameButton;

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        clock = _detailItem;
        
        // Update the view.
        id delegate = [[UIApplication sharedApplication] delegate];
        self.managedObjectContext = [delegate managedObjectContext];
//        [self init];
    }
}

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    
    NSArray *buttonArray = [[NSArray alloc] initWithObjects:addButton,self.editButtonItem,nil];
    
    self.navigationItem.rightBarButtonItems = buttonArray;
    self.navigationItem.title = clock.clockName;
    
    // Create and set the table header view.
    if (tableHeaderView == nil) {
        [[NSBundle mainBundle] loadNibNamed:@"StationListHeader" owner:self options:nil];
        //self.tableView.tableHeaderView = tableHeaderView;
        self.tableView.allowsSelectionDuringEditing = YES;
        
        [self.imageButton setImage:clock.thumbNailImage forState:UIControlStateNormal];
        [self.clockNameButton setTitle:clock.clockName forState:UIControlStateNormal];
    }
    
    [self configData];
    
    
}

-(void) viewWillAppear:(BOOL)animated
{
    [self.imageButton setImage:clock.thumbNailImage forState:UIControlStateNormal];
    [self.clockNameButton setTitle:clock.clockName forState:UIControlStateNormal];
    [self configData];
    [self.tableView reloadData];
}

- (IBAction)tapheadButton:(id)sender {
    if (self.tableView.editing) {
        NSLog(@"Editing");
        AddClockViewController *addController = [[AddClockViewController alloc] initWithNibName:@"AddClockView" bundle:nil];
        addController.clock = self.clock;
        
        [self.navigationController pushViewController:addController animated:YES];
    }
    else{
        NSLog(@"Not Editing");
    }
}

-(void) configData
{
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"stationName" ascending:YES];
	NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:&sortDescriptor count:1];
	
	NSMutableArray *sortedStations = [[NSMutableArray alloc] initWithArray:[clock.clocktostation allObjects]];
	[sortedStations sortUsingDescriptors:sortDescriptors];
	self.stations = sortedStations;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)insertNewObject:(id)sender
{
    
    UIStoryboard * storyboard = [ UIStoryboard storyboardWithName:@"Main" bundle:nil ];
    
    DetailViewController *nextViewController = [storyboard instantiateViewControllerWithIdentifier:@"DetailViewController" ];
    nextViewController.clock = self.clock;
    nextViewController.textView.text = @"";
    
    [self.navigationController pushViewController:nextViewController animated:YES];
    
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [clock.clocktostation count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"StationCell" forIndexPath:indexPath];
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        Station *station = [stations objectAtIndex:indexPath.row];
        [clock removeClocktostationObject:station];
        [stations removeObject:station];
        

        NSManagedObjectContext *context = station.managedObjectContext;
        
        NSString *filePath = [[ImageHelper documentsFolder] stringByAppendingPathComponent:station.imageName];
        [ImageHelper listFile:[ImageHelper documentsFolder]];
        
        //delete file from documents directory
        [ImageHelper removeFile:filePath];
        //delete file from context
        
        [ImageHelper listFile:[ImageHelper documentsFolder]];
        
        [context deleteObject:station];
        
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationTop];
    }   
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // The table view should not be re-orderable.
    return NO;
}

- (CGFloat)tableView:(UITableView *)tableView
heightForHeaderInSection:(NSInteger)section
{
    CGFloat height = 50.0; // this should be the height of your admob view
    
    return height;
}

- (UIView *)tableView:(UITableView *)tableView
viewForHeaderInSection:(NSInteger)section
{
    // 在屏幕顶部创建标准尺寸的视图。
    // 在GADAdSize.h中对可用的AdSize常量进行说明。
    bannerView_ = [[GADBannerView alloc] initWithAdSize:kGADAdSizeBanner];
    
    // 指定广告单元ID。
    bannerView_.adUnitID = ADID;
    
    // 告知运行时文件，在将用户转至广告的展示位置之后恢复哪个UIViewController
    // 并将其添加至视图层级结构。
    bannerView_.rootViewController = self;
    
    GADRequest *request = [GADRequest request];
    
    // 请求测试广告。填入模拟器
    // 以及接收测试广告的任何设备的标识符。
    request.testDevices = [NSArray arrayWithObjects:
                           GAD_SIMULATOR_ID,
                           @"1beb37d2f9cc5b882e43f7e6b98ec508",
                           nil];
    
    // 启动一般性请求并在其中加载广告。
    [bannerView_ loadRequest:request];
    
    UIView *headerView = bannerView_; // init your view or reference your admob view
    
    return headerView;
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSManagedObject *object = [self.stations objectAtIndex:indexPath.row];
        ((DetailViewController *)[segue destinationViewController]).clock = self.clock;
        [[segue destinationViewController] setDetailItem:object];
    }
}

#pragma mark - Fetched results controller

- (NSFetchedResultsController *)fetchedResultsController
{
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    // Edit the entity name as appropriate.
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Station" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    // Set the batch size to a suitable number.
    [fetchRequest setFetchBatchSize:20];
    
    // Edit the sort key as appropriate.
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"stationName" ascending:NO];
    NSArray *sortDescriptors = @[sortDescriptor];
    
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    // Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:@"Master"];
    aFetchedResultsController.delegate = self;
    self.fetchedResultsController = aFetchedResultsController;
    
	NSError *error = nil;
	if (![self.fetchedResultsController performFetch:&error]) {
	     // Replace this implementation with code to handle the error appropriately.
	     // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
	    NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
	    abort();
	}
    
    return _fetchedResultsController;
}    

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView beginUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type
{
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath
{
    UITableView *tableView = self.tableView;
    
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
            [self configureCell:[tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
            break;
            
        case NSFetchedResultsChangeMove:
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView endUpdates];
}

/*
// Implementing the above methods to update the table view in response to individual changes may have performance implications if a large number of changes are made simultaneously. If this proves to be an issue, you can instead just implement controllerDidChangeContent: which notifies the delegate that all section and object changes have been processed. 
 
 - (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    // In the simplest, most efficient, case, reload the table view.
    [self.tableView reloadData];
}
 */

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    Station *station = [stations objectAtIndex:indexPath.row];
    cell.textLabel.text = station.stationName;
    cell.imageView.image = station.thumbnailimage;
    
}



@end
