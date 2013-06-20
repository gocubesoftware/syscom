//
//  SysComTransmit.m
//  SysCom
//
//  Created by lidier on 6/20/13.
//  Copyright (c) 2013 Livininteractive. All rights reserved.
//

#import "SysComTransmit.h"
#import "SysComConfig.h"

@interface SysComTransmit ()

// PRIVATE PROPERTIES

@property SysComConfig* syscomConfig;


@end

@implementation SysComTransmit

@synthesize syscomConfig = _syscomConfig;



- (id) initWithConfig: (SysComConfig*) syscomConfig{
    self = [super init];
    if (self) {
        _syscomConfig = syscomConfig;
    }
    return self;
}


@end
