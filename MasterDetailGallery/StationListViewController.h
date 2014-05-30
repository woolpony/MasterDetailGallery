//
//  MasterViewController.h
//  MasterDetailGallery
//
//  Created by pony wu on 14-2-14.
//  Copyright (c) 2014年 pony wu. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <CoreData/CoreData.h>
#import "GADBannerView.h"

@class Clock;

@interface StationListViewController : UITableViewController <NSFetchedResultsControllerDelegate>{

    // 将其中一个声明为实例变量
    GADBannerView *bannerView_;
}



@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) Clock *clock;
@property (strong, nonatomic) id detailItem;
@property (strong, nonatomic) NSMutableArray *stations;

@property (nonatomic, retain) IBOutlet UIView *tableHeaderView;
@property (weak, nonatomic) IBOutlet UIButton *imageButton;
@property (weak, nonatomic) IBOutlet UIButton *clockNameButton;

- (IBAction)tapheadButton:(id)sender;


-(void) configData;

@end
