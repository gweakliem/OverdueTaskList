//
//  ETCreateTaskViewController.h
//  Overdue Task List
//
//  Created by Gordon Weakliem on 11/14/13.
//  Copyright (c) 2013 Eighty Twenty. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ETTask.h"

@protocol ETTaskEditorDelegate<NSObject>
@required
-(void) didAddTask:(ETTask*) task;
-(void) didCancelAdd;
@end

@interface ETCreateTaskViewController : UIViewController<UITextViewDelegate>
- (IBAction)addTaskButtonPressed:(UIBarButtonItem *)sender;
- (IBAction)cancelButtonPressed:(UIBarButtonItem *)sender;
@property (strong, nonatomic) IBOutlet UITextField *taskTitleTextBox;
@property (strong, nonatomic) IBOutlet UITextView *taskDescriptionTextView;
@property (strong, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) id<ETTaskEditorDelegate> delegate;
@end
