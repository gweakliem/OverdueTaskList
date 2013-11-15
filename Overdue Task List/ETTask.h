//
//  ETTask.h
//  Overdue Task List
//
//  Created by Gordon Weakliem on 11/14/13.
//  Copyright (c) 2013 Eighty Twenty. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ETTask : NSObject
@property (strong, nonatomic) NSString* title;
@property (strong, nonatomic) NSString* description;
@property (strong, nonatomic) NSDate* date;
@property (nonatomic) BOOL completed;
@end
