//
//  PhotoViewController.h
//  MasterDetailGallery
//
//  Created by pony wu on 14-2-22.
//  Copyright (c) 2014年 pony wu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Station;
@interface PhotoViewController : UIViewController

@property(nonatomic, retain) Station *station;
@property(nonatomic, retain) UIImageView *imageView;
+ (id)sharedInstance;
@end
