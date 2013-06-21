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

@synthesize getTimeoutInterval = _getTimeoutInterval;
@synthesize postTimeoutInterval = _postTimeoutInterval;

@synthesize recordingRetryTimeInterval = _recordingRetryTimeInterval; // given in seconds
@synthesize onlineStatusCheckTimeInterval = _onlineStatusCheckTimeInterval; // given in seconds

@synthesize serverOnlineMethodName = _serverOnlineMethodName;

@synthesize onlineNotificationName = _onlineNotificationName;
@synthesize offlineNotificationName = _offlineNotificationName;


- (id) init{
    self = [super init];
    if (self) {
        _serverURL = @"http://checkinsystem.livininteractive.com/desarrolladores/index.php/services/";
        _getTimeoutInterval = 5;
        _postTimeoutInterval = 10;
        _recordingRetryTimeInterval = 30;
        _onlineStatusCheckTimeInterval = 3;
        _serverOnlineMethodName = @"serverOnline";
        
        _onlineNotificationName = @"onlineNotification";
        _offlineNotificationName = @"offlineNotification";
    }
    return self;
}

@end
