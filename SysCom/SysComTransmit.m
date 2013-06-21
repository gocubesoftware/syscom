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

- (NSString*) getWithUrl: (NSString*) url Parameters: (NSString*) parameters{
    
    if (parameters != nil)
        url = [url stringByAppendingString:[NSString stringWithFormat:@"?%@", parameters]];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:_syscomConfig.getTimeoutInterval];
    
    [request setHTTPMethod: @"GET"];
    NSError *requestError;
    NSURLResponse *urlResponse = nil;
    NSData *rawResponse = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&requestError];
    
    NSString* responseText= [[NSString alloc] initWithData:rawResponse encoding:NSUTF8StringEncoding];
    return responseText;
    
}

- (NSString*) synchronicPostWithUrl: (NSString*) url Parameters: (NSString*) parameters{
    
    NSURL *requestURL = [NSURL URLWithString:url];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:requestURL];
    [request setHTTPMethod: @"POST"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setCachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData];
    [request setTimeoutInterval:_syscomConfig.postTimeoutInterval];
    
    if (parameters != nil){
        NSData *postRawData = [parameters dataUsingEncoding:NSUTF8StringEncoding];
        NSString *postLength = [NSString stringWithFormat:@"%d", [postRawData length]];
        [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
        [request setHTTPBody:postRawData];
    }
    
    NSError *requestError;
    NSURLResponse *urlResponse = nil;
    
    NSData *rawResponse = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&requestError];
    
    NSString* responseText= [[NSString alloc] initWithData:rawResponse encoding:NSUTF8StringEncoding];
    return responseText;
}


@end
