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
#import "SysComConfig.h"

@interface SysCom ()

// PRIVATE PROPERTIES

@property SysComTransmit* syscomTransmit;
@property SysComTempStorage* syscomTempStorage;
@property SysComConfig* syscomConfig;


@end

@implementation SysCom

@synthesize syscomTransmit = _syscomTransmit;
@synthesize syscomTempStorage = _syscomTempStorage;
@synthesize syscomConfig = _syscomConfig;
@synthesize connOfflineTimeLapse = _connOfflineTimeLapse;

- (id) initWithConfig: (SysComConfig*) syscomConfig{
    self = [super init];
    if (self) {
        
        _syscomTransmit = [[SysComTransmit alloc] initWithConfig:syscomConfig];
        _syscomTempStorage = [[SysComTempStorage alloc] initWithConfig:syscomConfig];
        _syscomConfig = syscomConfig;
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


// Funcion de prueba
-(Boolean) serviceOnline{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:_syscomConfig.serverURL] cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:10];
    
    [request setHTTPMethod: @"GET"];
    
    NSError *requestError;
    NSURLResponse *urlResponse = nil;
    
    
    NSData *response1 = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&requestError];
    
    NSString* newStr = [[NSString alloc] initWithData:response1 encoding:NSUTF8StringEncoding];
    print newStr;
    return TRUE;
}


@end
