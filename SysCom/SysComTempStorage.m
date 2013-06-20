//
//  SysComStorage.m
//  SysCom
//
//  Created by lidier on 6/20/13.
//  Copyright (c) 2013 Livininteractive. All rights reserved.
//

#import "SysComTempStorage.h"

@interface SysComTempStorage ()

// PRIVATE PROPERTIES

@property NSDictionary* configDictionary;


@end

@implementation SysComTempStorage

@synthesize configDictionary = _configDictionary;



- (id) initWithConfig: (NSDictionary*) configDictionary{
    self = [super init];
    if (self) {
        [self setConfigDictionary:configDictionary];
    }
    return self;
}


@end
