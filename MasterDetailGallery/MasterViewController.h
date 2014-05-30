//
//  MasterViewController.h
//  MasterDetailGallery
//
//  Created by pony wu on 14-2-14.
//  Copyright (c) 2014年 pony wu. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <CoreData/CoreData.h>
#import "AddClockViewController.h"
#import "GADBannerView.h"

@class Clock;
@interface MasterViewController : UITableViewController <NSFetchedResultsControllerDelegate,UIAlertViewDelegate>{
    
    // 将其中一个声明为实例变量
    GADBannerView *bannerView_;

@private
    NSFetchedResultsController *fetchedResultsController;
    NSManagedObjectContext *managedObjectContext;

}

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end
