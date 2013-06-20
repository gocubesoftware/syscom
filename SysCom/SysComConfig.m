//
//  SysComConfig.m
//  SysCom
//
//  Created by lidier on 6/20/13.
//  Copyright (c) 2013 Livininteractive. All rights reserved.
//

#import "SysComConfig.h"

@implementation SysComConfig

@synthesize serverURL = _serverURL;
@synthesize recordingRetryTimeLapse = _recordingRetryTimeLapse;
@synthesize onlineStatusCheckTimeLapse = _onlineStatusCheckTimeLapse;

- (id) init{
    self = [super init];
    if (self) {
        
        _serverURL = @"http://checkinsystem.livininteractive.com/desarrolladores/index.php/services/serveronline";
        _recordingRetryTimeLapse = [NSNumber numberWithInt:30];
        _onlineStatusCheckTimeLapse = [NSNumber numberWithInt:30];
    }
    return self;
}

@end
