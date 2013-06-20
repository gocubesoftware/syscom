//
//  SysCom.m
//  SysCom
//
//  Created by lidier on 6/20/13.
//  Copyright (c) 2013 Livininteractive. All rights reserved.
//

#import "SysCom.h"
#import "SysComTransmit.h"
#import "SysComTempStorage.h"

@interface SysCom ()

// PRIVATE PROPERTIES

@property SysComTransmit* syscomTransmit;
@property SysComTempStorage* syscomTempStorage;
@property NSDictionary* configDictionary;


@end

@implementation SysCom

@synthesize syscomTransmit = _syscomTransmit;
@synthesize syscomTempStorage = _syscomTempStorage;
@synthesize configDictionary = _configDictionary;
@synthesize connOfflineTimeLapse = _connOfflineTimeLapse;

- (id) initWithConfig: (NSDictionary*) configDictionary{
    self = [super init];
    if (self) {
        
        _syscomTransmit = [[SysComTransmit alloc] initWithConfig:configDictionary];
        _syscomTempStorage = [[SysComTempStorage alloc] initWithConfig:configDictionary];
        _configDictionary = configDictionary;
        _connOfflineTimeLapse = 0;
    }
    return self;
}


- (void) callLectureServiceWithParameters: (NSDictionary*) parametersDictionary DelegateObject: (id) delegateObject Message: (SEL) message{
    
}

- (NSString*) callRecordingServiceWithParameters: (NSDictionary*) parametersDictionary{
    return @"";
}

- (void) callRecordingServiceWithParameters: (NSDictionary*) parametersDictionary DelegateObject: (id) delegateObject Message: (SEL) message{
    
}

- (void) getResourceWithParameters: (NSDictionary*) parametersDictionary Delegate: (id) delegateObject Message: (SEL) message{
    
}

- (NSNumber*) getPendingRecordCount{
    return 0;
}
- (NSNumber*) getTotalSuccessfulRecordCount{
    return 0;
}
- (NSNumber*) getActualSuccessfulRecordCount{
    return 0;
}
- (void) resetActualSuccessfulRecordCounter{
    
}

- (NSString*) getRecordStatusWithRecordId: (NSNumber*) recordId{
    return @"";
}
- (NSString*) getLastRecordingError{
    return @"";
}
- (void) startOnlineStatusCheckThreadWithStatusChangeDelegate: (id) delegateObject Message: (SEL) message{
    
}
- (void) stopOnlineStatusCheckThread{
    
}


@end
