//
//  AddClockViewController.h
//  MasterDetailGallery
//
//  Created by pony wu on 14-2-18.
//  Copyright (c) 2014年 pony wu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ClockAddDelegate;
@class Clock;
@interface AddClockViewController : UIViewController <UITextFieldDelegate>{
 
@private
    Clock *clock;
    UITextField  *clockName;
    __unsafe_unretained id<ClockAddDelegate> delegate;
    
}

@property (nonatomic, retain) IBOutlet UITextField *clockName;
@property (nonatomic, retain) Clock *clock;
@property (nonatomic, assign) id<ClockAddDelegate> delegate;

-(void)save;
-(void)cancel;

@end

@protocol ClockAddDelegate <NSObject>
// recipe == nil on cancel
- (void)clockAddViewController:(AddClockViewController *)addClockViewController didAddClock:(Clock *)clock;

@end