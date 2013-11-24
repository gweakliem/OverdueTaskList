//
//  ETEditTaskViewController.m
//  Overdue Task List
//
//  Created by Gordon Weakliem on 11/14/13.
//  Copyright (c) 2013 Eighty Twenty. All rights reserved.
//

#import "ETEditTaskViewController.h"

@interface ETEditTaskViewController ()

@end

@implementation ETEditTaskViewController

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
    [self.taskNameTextField setText:self.task.title];
    [self.taskDescriptionTextView setText:self.task.description];
    [self.taskDatePicker setDate:self.task.date];
    [self.taskCompletedSwitch setOn:self.task.completed];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)saveTaskButtonPressed:(UIBarButtonItem *)sender {
    self.task.title = [self.taskNameTextField text];
    self.task.description = [self.taskDescriptionTextView text];
    self.task.date = [self.taskDatePicker date];
    self.task.completed = self.taskCompletedSwitch.on;
    [self.delegate didUpdateTask:self.task];
}

- (IBAction)cancelButtonPressed:(UIBarButtonItem *)sender {
    [self.delegate didCancelEdit];
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
