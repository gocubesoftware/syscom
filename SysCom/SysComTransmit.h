//
//  SysComTransmit.h
//  SysCom
//
//  Created by lidier on 6/20/13.
//  Copyright (c) 2013 Livininteractive. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SysComConfig;

@interface SysComTransmit : NSObject

- (id) initWithConfig: (SysComConfig*) syscomConfig;

- (NSString*) getWithUrl: (NSString*) url Parameters: (NSString*) parameters;
- (NSString*) synchronicPostWithUrl: (NSString*) url Parameters: (NSString*) parameters;

@end
