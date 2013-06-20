//
//  SysComStorage.m
//  SysCom
//
//  Created by lidier on 6/20/13.
//  Copyright (c) 2013 Livininteractive. All rights reserved.
//

#import "SysComTempStorage.h"
#import "SysComConfig.h"

@interface SysComTempStorage ()

// PRIVATE PROPERTIES

@property SysComConfig* syscomConfig;


@end

@implementation SysComTempStorage

@synthesize syscomConfig = _syscomConfig;



- (id) initWithConfig: (SysComConfig*) syscomConfig{
    self = [super init];
    if (self) {
        _syscomConfig = syscomConfig;
    }
    return self;
}


@end