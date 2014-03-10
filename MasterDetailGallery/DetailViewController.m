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
#import "ImageHelper-Files.h"

@interface DetailViewController ()
- (void)configureView;
@end

@implementation DetailViewController

@synthesize clock, station, textView, detailItem, scview, imageButton,oldstation, isGoToPickImage;

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
    self.navigationItem.title = @"Station Detail";
    
    NSManagedObjectContext *context = [clock managedObjectContext];
	
	/*
	 If there isn't an ingredient object, create and configure one.
	 */
    if (!station) {
        self.station = [NSEntityDescription insertNewObjectForEntityForName:@"Station" inManagedObjectContext:context];
        [clock addClocktostationObject:station];
    }
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

-(void) viewWillDisappear:(BOOL)animated
{
    if ((station.stationName != nil
        && ![station.stationName isEqualToString:@""])
        || station.imageName != nil)
    {
        [self save];
    }
    else
    {
        [self cancel];
    }
    
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
};

-(void)cancel
{
    if(!station){
        return;
    }
    
    if(self.isGoToPickImage)
    {
        return;
    }
    
    NSManagedObjectContext *context = [clock managedObjectContext];
    [clock removeClocktostationObject:station];
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
};

-(void)textViewEditingEnd
{
    self.navigationItem.rightBarButtonItem = nil;
    
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
    
    isGoToPickImage = YES;
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
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:imagePicker animated:YES  completion:nil];
    }else{
        [self showActionSheet];
    }
}

-(void)showActionSheet
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:nil
                                  delegate:self
                                  cancelButtonTitle:@"Cancel"
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:@"Camera", @"Album",nil];
    //actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    [actionSheet showInView:self.view];

}

-(void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
            [self showCameraPickerController];
            break;
        case 1:
            [self showAlbumPickerController];
            break;
        case 2:
            break;
            
        default:
            break;
    }
}

-(void) showCameraPickerController
{
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;

    [self presentViewController:imagePicker animated:YES  completion:nil];
}

-(void) showAlbumPickerController
{
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:imagePicker animated:YES  completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)selectedImage editingInfo:(NSDictionary *)editingInfo {
    
    if (!station.imageName) {
        station.imageName = [self findUniqueSaveFileName];
    }
    NSString *filePath = [[ImageHelper documentsFolder] stringByAppendingPathComponent:station.imageName];
    
    //save the image to file
    UIImage *bigi =[self getSmallImageFromBigImage:selectedImage resultImagesize:800];
    [UIImagePNGRepresentation(bigi) writeToFile:filePath atomically:YES];
    
    
    station.thumbnailimage = [self getSmallImageFromBigImage:selectedImage resultImagesize:200];
    self.imageButton.imageView.image = station.thumbnailimage;
	
    [self dismissModalViewControllerAnimated:YES];
}

-(UIImage *)getSmallImageFromBigImage:(UIImage *)bigimage resultImagesize:(float)resultImagesize
{
    UIImage *returnImage = nil;
    // Create a thumbnail version of the image for the recipe object.
	CGSize size = bigimage.size;
	CGFloat ratio = 0;
	if (size.width > size.height) {
		ratio = resultImagesize / size.width;
	} else {
		ratio = resultImagesize / size.height;
	}
	CGRect rect = CGRectMake(0.0, 0.0, ratio * size.width, ratio * size.height);
	
	UIGraphicsBeginImageContext(rect.size);
	[bigimage drawInRect:rect];
	returnImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
    
    return returnImage;

}

- (IBAction)imageButtonPush:(id)sender {
    PhotoViewController *photoViewController = [[PhotoViewController alloc] initWithNibName:@"StationPhotoView" bundle:nil];
    photoViewController.station = self.station;
    [self.navigationController pushViewController:photoViewController animated:YES];
}


- (NSString *) findUniqueSaveFileName
{
	int i = 1;
    int r;
	NSString *path;
	do {
		// iterate until a name does not match an existing file
	    path = [NSString stringWithFormat:@"%@/Documents/IMAGE_%04d.PNG", NSHomeDirectory(), i++];
	} while ([[NSFileManager defaultManager] fileExistsAtPath:path]);
	r = i - 1;
	return [NSString stringWithFormat:@"IMAGE_%04d.PNG",r];
}


@end
