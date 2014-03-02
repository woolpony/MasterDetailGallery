//
//  Image.h
//  MasterDetailGallery
//
//  Created by pony wu on 14-3-2.
//  Copyright (c) 2014年 pony wu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Station;

@interface Image : NSManagedObject

@property (nonatomic, retain) id image;
@property (nonatomic, retain) Station *station;

@end
