//
//  AddClockViewController.m
//  MasterDetailGallery
//
//  Created by pony wu on 14-2-18.
//  Copyright (c) 2014年 pony wu. All rights reserved.
//

#import "AddClockViewController.h"
#import "Clock.h"

@implementation AddClockViewController

@synthesize clock;
@synthesize clockName;
@synthesize delegate;

- (void)viewDidLoad {
    
    // Configure the navigation bar
    self.navigationItem.title = @"Add Clock";
    
    UIBarButtonItem *cancelButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(cancel)];
    self.navigationItem.leftBarButtonItem = cancelButtonItem;
    
    UIBarButtonItem *saveButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStyleDone target:self action:@selector(save)];
    self.navigationItem.rightBarButtonItem = saveButtonItem;
    
	clockName.delegate = self;
	[clockName becomeFirstResponder];
}


- (void)viewDidUnload {
	self.clockName = nil;
	[super viewDidUnload];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Support all orientations except upside-down
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	if (textField == clockName) {
		[clockName resignFirstResponder];
		[self save];
	}
	return YES;
}
-(void)save{
    clock.clockName = clockName.text;
    NSError *error = nil;
	if (![clock.managedObjectContext save:&error]) {
		/*
		 Replace this implementation with code to handle the error appropriately.
		 
		 abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
		 */
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		abort();
	}
    
	[self.delegate clockAddViewController:self didAddClock:clock];

}

-(void)cancel{
    [clock.managedObjectContext deleteObject:clock];
   
    NSError *error = nil;
	if (![clock.managedObjectContext save:&error]) {
		/*
		 Replace this implementation with code to handle the error appropriately.
		 
		 abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
		 */
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		abort();
	}
    
	[self.delegate clockAddViewController:self didAddClock:clock];

}


@end
