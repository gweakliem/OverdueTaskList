//
//  ETEditTaskViewController.h
//  Overdue Task List
//
//  Created by Gordon Weakliem on 11/14/13.
//  Copyright (c) 2013 Eighty Twenty. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ETEditTaskViewController : UIViewController
- (IBAction)saveTaskButtonPressed:(UIBarButtonItem *)sender;
- (IBAction)cancelButtonPressed:(UIBarButtonItem *)sender;


@property (strong, nonatomic) IBOutlet UITextField *taskNameTextField;
@property (strong, nonatomic) IBOutlet UITextView *taskDescriptionTextView;

@property (strong, nonatomic) IBOutlet UIDatePicker *taskDatePicker;
@end
