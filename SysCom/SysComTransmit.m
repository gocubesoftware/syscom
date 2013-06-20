//
//  SysComTransmit.m
//  SysCom
//
//  Created by lidier on 6/20/13.
//  Copyright (c) 2013 Livininteractive. All rights reserved.
//

#import "SysComTransmit.h"

@interface SysComTransmit ()

// PRIVATE PROPERTIES

@property NSDictionary* configDictionary;


@end

@implementation SysComTransmit

@synthesize configDictionary = _configDictionary;



- (id) initWithConfig: (NSDictionary*) configDictionary{
    self = [super init];
    if (self) {
        [self setConfigDictionary:configDictionary];
    }
    return self;
}


@end
