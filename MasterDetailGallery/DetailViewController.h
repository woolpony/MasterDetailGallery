//
//  DetailViewController.h
//  MasterDetailGallery
//
//  Created by pony wu on 14-2-14.
//  Copyright (c) 2014年 pony wu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Clock;
@class Station;
@interface DetailViewController : UIViewController<UITextViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIGestureRecognizerDelegate,UIActionSheetDelegate>

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIScrollView *scview;
@property (weak, nonatomic) IBOutlet UIButton *imageButton;




@property (strong, nonatomic) Clock *clock;
@property (strong, nonatomic) Station *station;
@property (strong, nonatomic) Station *oldstation;
@property  BOOL isGoToPickImage;

- (IBAction)buttonPush:(UIButton *)sender;
- (IBAction)imageButtonPush:(id)sender;

-(void)save;
-(void)cancel;
-(void)textViewEditingEnd;
@end

