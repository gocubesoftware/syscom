//
//  SysCom.h
//  SysCom
//
//  Created by lidier on 6/20/13.
//  Copyright (c) 2013 Livininteractive. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SysCom : NSObject

// PUBLIC PROPERTIES

@property (readonly) NSNumber* connOfflineTimeLapse;


// PUBLIC METHODS

- (id) initWithConfig: (NSDictionary*) configDictionary;

- (void) callLectureServiceWithParameters: (NSDictionary*) parametersDictionary DelegateObject: (id) delegateObject Message: (SEL) message;

- (NSString*) callRecordingServiceWithParameters: (NSDictionary*) parametersDictionary;

- (void) callRecordingServiceWithParameters: (NSDictionary*) parametersDictionary DelegateObject: (id) delegateObject Message: (SEL) message;

- (void) getResourceWithParameters: (NSDictionary*) parametersDictionary Delegate: (id) delegateObject Message: (SEL) message;

- (NSNumber*) getPendingRecordCount;
- (NSNumber*) getTotalSuccessfulRecordCount;
- (NSNumber*) getActualSuccessfulRecordCount;
- (void) resetActualSuccessfulRecordCounter;

- (NSString*) getRecordStatusWithRecordId: (NSNumber*) recordId;
- (NSString*) getLastRecordingError;
- (void) startOnlineStatusCheckThreadWithStatusChangeDelegate: (id) delegateObject Message: (SEL) message;
- (void) stopOnlineStatusCheckThread;


@end
