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

static NSString *CellIdentifier = @"TaskCell";

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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    ETTask *task = [self.tasks objectAtIndex:indexPath.row];
    cell.textLabel.text = task.title;
    cell.detailTextLabel.text =task.description;
    // set colors according to completion and due date
    if (task.completed)
    {
        cell.textLabel.textColor = cell.detailTextLabel.textColor = [UIColor blackColor];
    }
    else if ([self isDateGreaterThanDate: [NSDate date] and: task.date]) {
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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ETTask *task = [self.tasks objectAtIndex:indexPath.row];
    task.completed = !task.completed;
    [self didUpdateTask:task];
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return TRUE;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    ETTask *task = [self.tasks objectAtIndex:indexPath.row];
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.tasks removeObject:task];
        [self saveTasks];
        [self.taskTableView reloadData];
    }
}

#pragma mark ETTaskEditorDelegate methods
-(void)didAddTask:(ETTask *)task
{
    [self.tasks addObject:task];
    
    [self saveTasks];
    [self dismissViewControllerAnimated:true completion:nil];
    [self.taskTableView reloadData];
}

-(void)didCancelAdd
{
    [self dismissViewControllerAnimated:true completion:nil];
}


-(void)didUpdateTask:(ETTask *)task
{
    // we should have the same reference to the task that we passed in, but let's just make sure
    int index = [self.tasks indexOfObject:task];
    NSLog(@"Found task %@ at index %i",task, index);
    
    [self saveTasks];
    [self dismissViewControllerAnimated:true completion:nil];
    // TODO: doesn't seem to reload, why not?
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

    NSDictionary *dictionary = @{ TASK_TITLE: task.title, TASK_COMPLETION: [NSNumber numberWithBool:task.completed], TASK_DESCRIPTION: task.description, TASK_DATE: [formatter stringFromDate:task.date]};
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

- (void)saveTasks
{
    NSMutableArray *tasksAsPropertyLists = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < self.tasks.count; i++) {
        [tasksAsPropertyLists addObject:[self taskAsPropertyList:self.tasks[i]]];
    }
    [[NSUserDefaults standardUserDefaults] setObject:tasksAsPropertyLists forKey:TASK_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
