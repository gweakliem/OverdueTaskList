//
//  ETViewController.h
//  Overdue Task List
//
//  Created by Gordon Weakliem on 11/14/13.
//  Copyright (c) 2013 Eighty Twenty. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ETViewController : UIViewController<UITableViewDelegate>
- (IBAction)addTaskButtonPressed:(id)sender;
@property (strong, nonatomic) IBOutlet UITableView *taskTableView;

@end
