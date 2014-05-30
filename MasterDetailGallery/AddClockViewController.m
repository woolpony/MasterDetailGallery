//
//  AddClockViewController.m
//  MasterDetailGallery
//
//  Created by pony wu on 14-2-18.
//  Copyright (c) 2014年 pony wu. All rights reserved.
//

#import "AddClockViewController.h"
#import "Clock.h"
#import "ImageHelper-Files.h"

#define isPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

@implementation AddClockViewController

@synthesize clock;
@synthesize clockName,imageButton, isGotoPickImager;

- (void)viewDidLoad {
    
    // Configure the navigation bar
    self.navigationItem.title = @"Add Clock";
    
    
    
    
    UIBarButtonItem *saveButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(save)];
    self.navigationItem.rightBarButtonItem = saveButtonItem;
    self.clockName.delegate = self;
	[self.clockName becomeFirstResponder];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    [imageButton setImage:clock.thumbNailImage forState:UIControlStateNormal];
    imageButton.contentMode=UIViewContentModeCenter;
    self.clockName.text = clock.clockName;

    [self.view reloadInputViews];
}

-(void) viewWillDisappear:(BOOL)animated
{
    if ((clock.clockName != nil && ![clock.clockName isEqualToString:@""])
        || (clock.imageName != nil && [clock.imageName isEqualToString:@""])) {
        [self save];
    }
    else{
        [self cancel];
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Support all orientations except upside-down
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	if (textField == clockName) {
		[self textFieldEditingEnd];
	}
	return YES;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    
    UIBarButtonItem *doneButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(textFieldEditingEnd)];
    self.navigationItem.rightBarButtonItem = doneButtonItem;
}

-(void)textFieldEditingEnd
{
    self.navigationItem.rightBarButtonItem = nil;
    clock.clockName = self.clockName.text;
    [self.clockName resignFirstResponder];
    
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
}



-(void) cancel{
    if (isGotoPickImager) {
        return;
    }
    
    NSError *error = nil;
    [clock.managedObjectContext deleteObject:clock];
    
	if (![clock.managedObjectContext save:&error]) {
		/*
		 Replace this implementation with code to handle the error appropriately.
		 
		 abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
		 */
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		abort();
	}

    
}

#pragma mark - Take Image

- (IBAction)takeImageForClock:(UIButton *)sender {
    isGotoPickImager = YES;
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
    
    if (!clock.imageName) {
        clock.imageName = [self findUniqueSaveFileName];
    }
    NSString *filePath = [[ImageHelper documentsFolder] stringByAppendingPathComponent:clock.imageName];
    
    //save the image to file
    UIImage *bigi =[self getSmallImageFromBigImage:selectedImage resultImagesize:800];
    [UIImagePNGRepresentation(bigi) writeToFile:filePath atomically:YES];
    
    
    clock.thumbNailImage = [self getSmallImageFromBigImage:selectedImage resultImagesize:200];

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
