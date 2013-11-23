//
//  ETCreateTaskViewController.m
//  Overdue Task List
//
//  Created by Gordon Weakliem on 11/14/13.
//  Copyright (c) 2013 Eighty Twenty. All rights reserved.
//

#import "ETCreateTaskViewController.h"

@interface ETCreateTaskViewController ()

@end

@implementation ETCreateTaskViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.taskDescriptionTextView.delegate = self;
    self.datePicker.backgroundColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addTaskButtonPressed:(id)sender {
    if ([self.taskTitleTextBox.text length] == 0)
    {
        UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"Error" message:@"You need to enter a task title"
                                  delegate:nil
                         cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        return;
    }
    ETTask *task = [[ETTask alloc] init];
    task.title = self.taskTitleTextBox.text;
    task.date = self.datePicker.date;
    task.completed = NO;
    task.description = self.taskDescriptionTextView.text;
    [self.delegate didAddTask:task];
}

- (IBAction)cancelButtonPressed:(UIBarButtonItem *)sender {
    [self.delegate didCancelAdd];
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [self.taskDescriptionTextView resignFirstResponder];
        return NO;
    } else {
        return YES;
    }
}
@end
