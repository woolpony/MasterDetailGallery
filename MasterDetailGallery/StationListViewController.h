//
//  MasterViewController.h
//  MasterDetailGallery
//
//  Created by pony wu on 14-2-14.
//  Copyright (c) 2014年 pony wu. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <CoreData/CoreData.h>


@class Clock;

@interface StationListViewController : UITableViewController <NSFetchedResultsControllerDelegate>{}

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) Clock *clock;
@property (strong, nonatomic) id detailItem;
@property (strong, nonatomic) NSMutableArray *stations;


-(void) configData;

@end
