//
//  ETEditTaskViewController.h
//  Overdue Task List
//
//  Created by Gordon Weakliem on 11/14/13.
//  Copyright (c) 2013 Eighty Twenty. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ETTask.h"

@protocol ETUpdateTaskDelegate<NSObject>
@required
-(void) didUpdateTask: (ETTask*) task;
-(void) didCancelEdit;
@end

@interface ETEditTaskViewController : UIViewController<UITextViewDelegate>
- (IBAction)cancelButtonPressed:(UIBarButtonItem *)sender;
- (IBAction)saveTaskButtonPressed:(UIBarButtonItem *)sender;

@property (strong, nonatomic) ETTask* task;
@property (strong, nonatomic) IBOutlet UITextField *taskNameTextField;
@property (strong, nonatomic) IBOutlet UITextView *taskDescriptionTextView;

@property (strong, nonatomic) IBOutlet UIDatePicker *taskDatePicker;
@property (weak,nonatomic) id<ETUpdateTaskDelegate> delegate;
@end
