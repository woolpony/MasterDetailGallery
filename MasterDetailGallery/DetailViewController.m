//
//  DetailViewController.m
//  MasterDetailGallery
//
//  Created by pony wu on 14-2-14.
//  Copyright (c) 2014年 pony wu. All rights reserved.
//

#import "DetailViewController.h"
#import "Clock.h"
#import "Station.h"
#import <QuartzCore/QuartzCore.h>
#import "PhotoViewController.h"

@interface DetailViewController ()
- (void)configureView;
@end

@implementation DetailViewController

@synthesize clock, station, textView, detailItem, scview, imageButton,oldstation;

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (detailItem != newDetailItem) {
        detailItem = newDetailItem;
        self.station = detailItem;
        // Update the view.
        [self configureView];
    }
}

- (void)configureView
{
    // Update the user interface for the detail item.

    if (station) {
        //
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    // Configure the navigation bar
    self.navigationItem.title = @"Clock Detail";
    
    UIBarButtonItem *cancelButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(cancel)];
    self.navigationItem.leftBarButtonItem = cancelButtonItem;
    
    UIBarButtonItem *saveButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStyleDone target:self action:@selector(save)];
    self.navigationItem.rightBarButtonItem = saveButtonItem;
	
    
    
    
    //[self.view reloadInputViews];
    
	//[textView becomeFirstResponder];
    
}


-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    self.textView.text = station.stationName;
    
    //set the board of textview
    textView.layer.borderColor = [UIColor grayColor].CGColor;
    textView.layer.borderWidth =1.0;
    textView.layer.cornerRadius =5.0;
    
    
    [imageButton setImage:station.thumbnailimage forState:UIControlStateNormal];
    imageButton.contentMode=UIViewContentModeCenter;
    [self.view reloadInputViews];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)save
{
    NSManagedObjectContext *context = [clock managedObjectContext];
	
	/*
	 If there isn't an ingredient object, create and configure one.
	 */
    if (!station) {
        self.station = [NSEntityDescription insertNewObjectForEntityForName:@"Station" inManagedObjectContext:context];
        [clock addClocktostationObject:station];
        //ingredient.displayOrder = [NSNumber numberWithInteger:[recipe.ingredients count]];
    }
	/*
	 Update the ingredient from the values in the text fields.
	 */
    station.stationName = textView.text;
    //station.thumbnailimage = self.imageView.image;
	
	/*
	 Save the managed object context.
	 */
	NSError *error = nil;
	if (![context save:&error]) {
		/*
		 Replace this implementation with code to handle the error appropriately.
		 
		 abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
		 */
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		abort();
	}
    
    [self.navigationController popViewControllerAnimated:YES];
};
-(void)cancel
{
    [self.navigationController popViewControllerAnimated:YES];
};

-(void)textViewEditingEnd
{
    UIBarButtonItem *cancelButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(cancel)];
    self.navigationItem.leftBarButtonItem = cancelButtonItem;
    
    UIBarButtonItem *saveButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStyleDone target:self action:@selector(save)];
    self.navigationItem.rightBarButtonItem = saveButtonItem;
    
    [self.textView resignFirstResponder];

}

- (BOOL)textViewShouldEndEditing:(UITextView *)newtextView {
	
	if (newtextView == self.textView) {
		station.stationName = newtextView.text;
	}
	
	return YES;
}

- (void)textViewDidBeginEditing:(UITextView *)atextView
{
    self.navigationItem.leftBarButtonItem = nil;
    
    UIBarButtonItem *doneButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(textViewEditingEnd)];
    self.navigationItem.rightBarButtonItem = doneButtonItem;

}

//- (void)textViewDidBeginEditing:(UITextView *)atextView
//
//{
//    float offset = 0.0f;
//    if(self.textView == atextView)
//    {
//        offset = - 180.0f;
//    }
//    NSTimeInterval animationDuration = 0.30f;
//    [UIView beginAnimations:@"ResizeForKeyBoard"context:nil];
//    [UIView setAnimationDuration:animationDuration];
//    float width = self.view.frame.size.width;
//    float height = self.view.frame.size.height;
//    CGRect rect = CGRectMake(0.0f, offset , width, height);
//    self.view.frame = rect;
//    [UIView  commitAnimations];
//}
//
//- (void)textViewDidEndEditing:(UITextView *)atextView
//
//{
//    float offset = 0.0f;
//    
//    NSTimeInterval animationDuration = 0.30f;
//    [UIView beginAnimations:@"ResizeForKeyBoard"context:nil];
//    [UIView setAnimationDuration:animationDuration];
//    float width = self.view.frame.size.width;
//    float height = self.view.frame.size.height;
//    CGRect rect = CGRectMake(0.0f, offset , width, height);
//    self.view.frame = rect;
//    [UIView commitAnimations];
//}


- (IBAction)buttonPush:(UIButton *)sender {
    
    NSManagedObjectContext *context = [clock managedObjectContext];
	
	/*
	 If there isn't an station object, create and configure one.
	 */
    if (!station) {
        self.station = [NSEntityDescription insertNewObjectForEntityForName:@"Station" inManagedObjectContext:context];
        [clock addClocktostationObject:station];
    }

    //save before goto pick image
    station.stationName = self.textView.text;
    
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    if (sender.tag == 310) {
        if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        }else{
            imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        }
    }
    else{
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    [self presentViewController:imagePicker animated:YES  completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)selectedImage editingInfo:(NSDictionary *)editingInfo {
	
	// Delete any existing image.
	UIImage *oldImage = station.image;
	if (oldImage != nil) {
		station.image = nil;
	}
    
	// Set the image for the image managed object.
	station.image = selectedImage;
	
	// Create a thumbnail version of the image for the recipe object.
	CGSize size = selectedImage.size;
	CGFloat ratio = 0;
	if (size.width > size.height) {
		ratio = 150.0 / size.width;
	} else {
		ratio = 150.0 / size.height;
	}
	CGRect rect = CGRectMake(0.0, 0.0, ratio * size.width, ratio * size.height);
	
	UIGraphicsBeginImageContext(rect.size);
	[selectedImage drawInRect:rect];
	station.thumbnailimage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
    
    self.imageButton.imageView.image = station.thumbnailimage;
	
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)imageButtonPush:(id)sender {
    PhotoViewController *photoViewController = [[PhotoViewController alloc] init];
    photoViewController.hidesBottomBarWhenPushed = YES;
    photoViewController.station = self.station;
    [self.navigationController pushViewController:photoViewController animated:YES];
}


@end
