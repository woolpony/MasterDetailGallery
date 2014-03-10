//
//  PhotoViewController.m
//  MasterDetailGallery
//
//  Created by pony wu on 14-2-22.
//  Copyright (c) 2014年 pony wu. All rights reserved.
//

#import "PhotoViewController.h"

#import "Station.h"
#import "ImageHelper-Files.h"

@interface PhotoViewController ()

@end

@implementation PhotoViewController

@synthesize imageView,station, clockNameLabel;


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
    self.clockNameLabel.lineBreakMode = NSLineBreakByWordWrapping;

}

- (void)viewWillAppear:(BOOL)animated {
    imageView.image = [ImageHelper imageNamed:station.imageName];
    self.clockNameLabel.text = station.stationName;
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (void)viewWillDisappear:(BOOL)animated
{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
