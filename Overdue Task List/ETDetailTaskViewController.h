//
//  ETDetailTaskViewController.h
//  Overdue Task List
//
//  Created by Gordon Weakliem on 11/14/13.
//  Copyright (c) 2013 Eighty Twenty. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ETDetailTaskViewController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *taskTitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *taskDateLabel;
@property (strong, nonatomic) IBOutlet UILabel *taskDescriptionLabel;
- (IBAction)editTaskButtonPressed:(UIBarButtonItem *)sender;

@end
