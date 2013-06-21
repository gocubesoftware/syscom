//
//  SysComConfig.h
//  SysCom
//
//  Created by lidier on 6/20/13.
//  Copyright (c) 2013 Livininteractive. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SysComConfig : NSObject

@property (readwrite) NSString *serverURL;

@property (readwrite) NSTimeInterval getTimeoutInterval;
@property (readwrite) NSTimeInterval postTimeoutInterval;

@property (readwrite) NSTimeInterval recordingRetryTimeInterval;
@property (readwrite) NSTimeInterval onlineStatusCheckTimeInterval;


// Names of WebServices methods
@property (readonly) NSString *serverOnlineMethodName;



// Names of Notifications
@property (readonly) NSString *onlineNotificationName;
@property (readonly) NSString *offlineNotificationName;

- (id) init;

@end
