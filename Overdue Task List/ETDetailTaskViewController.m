//
//  ETDetailTaskViewController.m
//  Overdue Task List
//
//  Created by Gordon Weakliem on 11/14/13.
//  Copyright (c) 2013 Eighty Twenty. All rights reserved.
//

#import "ETDetailTaskViewController.h"

@interface ETDetailTaskViewController ()

@end

@implementation ETDetailTaskViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)loadControls
{
    [self.taskTitleLabel setText:self.task.title];
    [self.taskDescriptionLabel setText:self.task.description];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    [self.taskDateLabel setText:[dateFormatter stringFromDate:self.task.date]];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	[self loadControls];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

// actions

- (IBAction)editTaskButtonPressed:(UIBarButtonItem *)sender {
    [self performSegueWithIdentifier:@"segueToEditTaskViewController" sender:self];
}

- (IBAction)cancelViewButtonPressed:(UIBarButtonItem *)sender {
    [self.delegate didCancelEdit];
}


// segue
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.destinationViewController isKindOfClass:[ETEditTaskViewController class]]) {
        ETEditTaskViewController *target = segue.destinationViewController;
        target.delegate = self;
        target.task = self.task;
    }
}

// task editor protocol
-(void)didUpdateTask:(ETTask *)task
{
    [self.navigationController popViewControllerAnimated:true ];
    [self.delegate didUpdateTask:task];
    [self loadControls];
}

-(void)didCancelEdit
{
    [self.navigationController popViewControllerAnimated:true];
}
@end
