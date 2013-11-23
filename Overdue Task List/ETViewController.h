//
//  ETViewController.h
//  Overdue Task List
//
//  Created by Gordon Weakliem on 11/14/13.
//  Copyright (c) 2013 Eighty Twenty. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ETTask.h"
#import "ETCreateTaskViewController.h"
#import "ETEditTaskViewController.h"

@interface ETViewController : UIViewController<ETTaskEditorDelegate,ETUpdateTaskDelegate,UITableViewDataSource, UITableViewDelegate>
- (IBAction)addTaskButtonPressed:(id)sender;
@property (strong, nonatomic) IBOutlet UITableView *taskTableView;
@property (strong, nonatomic) NSMutableArray *tasks;
@end
