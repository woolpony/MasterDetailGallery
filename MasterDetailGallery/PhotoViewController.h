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
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *clockNameLabel;

@end
