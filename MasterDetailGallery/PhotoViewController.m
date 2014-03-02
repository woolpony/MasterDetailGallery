//
//  PhotoViewController.m
//  MasterDetailGallery
//
//  Created by pony wu on 14-2-22.
//  Copyright (c) 2014年 pony wu. All rights reserved.
//

#import "PhotoViewController.h"

#import "Station.h"

@interface PhotoViewController ()

@end

@implementation PhotoViewController

@synthesize imageView,station;

+ (id)sharedInstance {
    static id sharedInstance;
    @synchronized(self) {
        if (!sharedInstance)
            sharedInstance = [[PhotoViewController alloc] init];
        return sharedInstance;
    }
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.title = @"Photo";
    
    imageView = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame];
    imageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.backgroundColor = [UIColor blackColor];
    
    self.view = imageView;
}

- (void)viewWillAppear:(BOOL)animated {
    imageView.image = station.image;
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (void)viewWillDisappear:(BOOL)animated
{
    imageView.image = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
