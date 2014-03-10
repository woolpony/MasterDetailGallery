//
//  AddClockViewController.h
//  MasterDetailGallery
//
//  Created by pony wu on 14-2-18.
//  Copyright (c) 2014年 pony wu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Clock;
@interface AddClockViewController : UIViewController <UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIGestureRecognizerDelegate,UIActionSheetDelegate>{
 
@private
    Clock *clock;
    UITextField  *clockName;
    
}

@property (nonatomic, retain) IBOutlet UITextField *clockName;
@property (weak, nonatomic) IBOutlet UIButton *imageButton;
@property (nonatomic, retain) Clock *clock;
@property BOOL isGotoPickImager;


- (IBAction)takeImageForClock:(UIButton *)sender;
- (void)save;

@end