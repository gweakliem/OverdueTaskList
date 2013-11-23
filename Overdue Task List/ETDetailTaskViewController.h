//
//  ETDetailTaskViewController.h
//  Overdue Task List
//
//  Created by Gordon Weakliem on 11/14/13.
//  Copyright (c) 2013 Eighty Twenty. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ETEditTaskViewController.h"

@interface ETDetailTaskViewController : UIViewController<ETUpdateTaskDelegate>
@property (strong, nonatomic) IBOutlet UILabel *taskTitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *taskDateLabel;
@property (strong, nonatomic) IBOutlet UILabel *taskDescriptionLabel;
@property (strong, nonatomic) ETTask *task;
@property (weak, nonatomic) id<ETUpdateTaskDelegate> delegate;
- (IBAction)cancelViewButtonPressed:(UIBarButtonItem *)sender;
- (IBAction)editTaskButtonPressed:(UIBarButtonItem *)sender;

@end
