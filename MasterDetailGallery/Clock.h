//
//  Clock.h
//  MasterDetailGallery
//
//  Created by pony wu on 14-2-20.
//  Copyright (c) 2014年 pony wu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Station;

@interface Clock : NSManagedObject

@property (nonatomic, retain) NSString * clockName;
@property (nonatomic, retain) NSString * imageName;
@property (nonatomic, retain) NSDate * createtime;
@property (nonatomic, retain) UIImage * thumbNailImage;
@property (nonatomic, retain) NSSet *clocktostation;
@end

@interface Clock (CoreDataGeneratedAccessors)

- (void)addClocktostationObject:(Station *)value;
- (void)removeClocktostationObject:(Station *)value;
- (void)addClocktostation:(NSSet *)values;
- (void)removeClocktostation:(NSSet *)values;

@end
