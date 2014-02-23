//
//  Station.h
//  MasterDetailGallery
//
//  Created by pony wu on 14-2-20.
//  Copyright (c) 2014年 pony wu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Clock;

@interface Station : NSManagedObject

@property (nonatomic, retain) NSDate * createTime;
@property (nonatomic, retain) UIImage * image;
@property (nonatomic, retain) NSString * stationName;
@property (nonatomic, retain) UIImage * thumbnailimage;
@property (nonatomic, retain) Clock *stationtoclock;

@end
