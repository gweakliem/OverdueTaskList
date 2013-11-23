//
//  ETTask.m
//  Overdue Task List
//
//  Created by Gordon Weakliem on 11/14/13.
//  Copyright (c) 2013 Eighty Twenty. All rights reserved.
//

#import "ETTask.h"

@implementation ETTask
-(id) init
{
    self = [self initWithData:nil];
    return self;
}

- (id)initWithData:(NSDictionary *)data
{
    self = [super init];
    self.title = data[TASK_TITLE];
    self.description = data[TASK_DESCRIPTION];
    self.completed = [data[TASK_COMPLETION] boolValue];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:TASK_DATE_FORMAT];
    self.date = [formatter dateFromString:data[TASK_DATE]];
    return self;
}
@end
