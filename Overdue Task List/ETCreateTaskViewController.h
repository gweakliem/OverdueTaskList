//
//  ETCreateTaskViewController.h
//  Overdue Task List
//
//  Created by Gordon Weakliem on 11/14/13.
//  Copyright (c) 2013 Eighty Twenty. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ETCreateTaskViewController : UIViewController
- (IBAction)addTaskButtonPressed:(UIBarButtonItem *)sender;
- (IBAction)cancelButtonPressed:(UIBarButtonItem *)sender;
@property (strong, nonatomic) IBOutlet UITextView *DetailTextView;
@property (strong, nonatomic) IBOutlet UIDatePicker *datePicker;

@end
