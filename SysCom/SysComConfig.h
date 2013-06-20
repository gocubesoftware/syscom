//
//  SysComConfig.h
//  SysCom
//
//  Created by lidier on 6/20/13.
//  Copyright (c) 2013 Livininteractive. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SysComConfig : NSObject

@property (readonly) NSString *serverURL;
@property (readonly) NSNumber *recordingRetryTimeLapse;
@property (readonly) NSNumber *onlineStatusCheckTimeLapse;

- (id) init;

@end
