//
//  ETViewController.m
//  Overdue Task List
//
//  Created by Gordon Weakliem on 11/14/13.
//  Copyright (c) 2013 Eighty Twenty. All rights reserved.
//

#import "ETViewController.h"
#import "ETCreateTaskViewController.h"
#import "ETDetailTaskViewController.h"

@interface ETViewController ()

@end

@implementation ETViewController

- (NSMutableArray *)tasks
{
    if (!_tasks) {
        _tasks = [[NSMutableArray alloc] init];
    }
    return _tasks;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    NSArray *myTasksAsPropertyLists = [[NSUserDefaults standardUserDefaults] arrayForKey:TASK_KEY];
    
    for (NSDictionary *dictionary in myTasksAsPropertyLists)
    {
        ETTask *task = [self taskForDictionary:dictionary];
        [self.tasks addObject:task];
    }
    self.taskTableView.dataSource = self;
    self.taskTableView.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addTaskButtonPressed:(id)sender {
    [self performSegueWithIdentifier:@"segueToCreateTask" sender:self];
}

-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"segueToDetailTaskViewController" sender:indexPath];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.destinationViewController isKindOfClass:[ETCreateTaskViewController class]])
    {
        ETCreateTaskViewController *target = segue.destinationViewController;
        target.delegate = self;
    }
    else if ([segue.destinationViewController isKindOfClass:[ETDetailTaskViewController class]])
    {
        ETDetailTaskViewController *target = segue.destinationViewController;
        NSIndexPath *indexPath = sender;
        target.task = self.tasks[indexPath.row];
        target.delegate = self;
    }
}


#pragma mark UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.tasks count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"TaskCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    ETTask *task = [self.tasks objectAtIndex:indexPath.row];
    cell.textLabel.text = task.title;
    cell.detailTextLabel.text =task.description;
    cell.backgroundColor = [UIColor blackColor];
    // set colors according to completion and due date
    if (task.completed)
    {
        cell.textLabel.textColor = cell.detailTextLabel.textColor = [UIColor grayColor];
    }
    else if ([self isDateGreaterThanDate:task.date and: [[NSDate alloc] init] ]) {
        cell.textLabel.textColor = cell.detailTextLabel.textColor = [UIColor redColor];
    }
    else {
        cell.textLabel.textColor = cell.detailTextLabel.textColor = [UIColor greenColor];
    }
    return  cell;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

#pragma mark ETTaskEditorDelegate methods
-(void)didAddTask:(ETTask *)task
{
    [self.tasks addObject:task];
    
    NSMutableArray *tasksAsPropertyLists = [[[NSUserDefaults standardUserDefaults] arrayForKey:TASK_KEY] mutableCopy];
    if (!tasksAsPropertyLists)
    {
        tasksAsPropertyLists = [[NSMutableArray alloc] init];
    }
    [tasksAsPropertyLists addObject:[self taskAsPropertyList:task]];
    [[NSUserDefaults standardUserDefaults] setObject:tasksAsPropertyLists forKey:TASK_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self dismissViewControllerAnimated:true completion:nil];
    [self.taskTableView reloadData];
}

-(void)didCancelAdd
{
    [self dismissViewControllerAnimated:true completion:nil];
}

-(void)didUpdateTask:(ETTask *)task
{
    //[self.tasks Set]
    NSMutableArray *tasksAsPropertyLists = [[[NSUserDefaults standardUserDefaults] arrayForKey:TASK_KEY] mutableCopy];
    if (!tasksAsPropertyLists)
    {
        tasksAsPropertyLists = [[NSMutableArray alloc] init];
    }
    [tasksAsPropertyLists addObject:[self taskAsPropertyList:task]];
    [[NSUserDefaults standardUserDefaults] setObject:tasksAsPropertyLists forKey:TASK_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self dismissViewControllerAnimated:true completion:nil];
    [self.taskTableView reloadData];
}

-(void)didCancelEdit
{
    [self dismissViewControllerAnimated:true completion:nil];
}

#pragma mark utility methods
-(NSDictionary*) taskAsPropertyList:(ETTask*) task
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:TASK_DATE_FORMAT];

    NSDictionary *dictionary = @{ TASK_TITLE: task.title, TASK_COMPLETION: [NSString stringWithFormat:@"%hhd",task.completed], TASK_DESCRIPTION: task.description, TASK_DATE: [formatter stringFromDate:task.date]};
    return dictionary;
}


-(ETTask *) taskForDictionary:(NSDictionary*) dictionary
{
    return [[ETTask alloc] initWithData:dictionary];
}
            
- (BOOL)isDateGreaterThanDate:(NSDate*)date and:(NSDate*)toDate
{
    return [date timeIntervalSince1970] > [toDate timeIntervalSince1970];
}

@end
