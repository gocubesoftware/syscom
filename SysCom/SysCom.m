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
@property Boolean connStatusCheckThreadRunning;


// PRIVATE METHODS
- (void) connStatusCheck;


@end

@implementation SysCom

@synthesize syscomTransmit = _syscomTransmit;
@synthesize syscomTempStorage = _syscomTempStorage;
@synthesize syscomConfig = _syscomConfig;
@synthesize connOfflineTimeInterval = _connOfflineTimeInterval;
@synthesize connStatusCheckThreadRunning = _connStatusCheckThreadRunning;


// -----------------------------------------------------------------
// METODOS PUBLICOS
// -----------------------------------------------------------------


// --------------------------
// En desarrollo

- (id) initWithConfig: (SysComConfig*) syscomConfig{
    self = [super init];
    if (self) {
        
        // Inicialización de la clase SysCom
        _syscomTransmit = [[SysComTransmit alloc] initWithConfig:syscomConfig];
        _syscomTempStorage = [[SysComTempStorage alloc] initWithConfig:syscomConfig];
        _syscomConfig = syscomConfig;
        _connOfflineTimeInterval = 0;
    }
    return self;
}

- (void) startConnStatusCheckThread{
    // Esta bandera mantendrá el hilo corriendo en connStatusCheck indefinidamente
    _connStatusCheckThreadRunning = TRUE;
    NSThread *connStatusCheckThread = [[NSThread alloc] initWithTarget:self
                                                              selector:@selector(connStatusCheck)
                                                                object:nil];
    [connStatusCheckThread start];
}

- (void) stopConnStatusCheckThread{
    // Al cambiar esta bandera el hilo enciclado en connStatusCheck terminará su ejecución
    _connStatusCheckThreadRunning = FALSE;
}

- (NSString*) callLectureService: (NSString*) service WithParameters: (NSString*) parameters{
    // Se concatenan la dirección del servidor con la dirección del servicio
    NSString *url = [_syscomConfig.serverURL stringByAppendingString:service];
    // Se pide un request POST SINCRONICO
    NSString *response = [_syscomTransmit synchronicPostWithUrl:url Parameters:parameters];
    return response;
}

// --------------------------

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

// -----------------------------------------------------------------
// METODOS PRIVADOS
// -----------------------------------------------------------------
- (void) connStatusCheck{
    @autoreleasepool {
        NSString *url = [_syscomConfig.serverURL stringByAppendingString:_syscomConfig.serverOnlineMethodName];
        NSString *responseText;
        Boolean wasOnline = FALSE;
        Boolean isOnline = FALSE;

        while (_connStatusCheckThreadRunning) {
          
            responseText = [_syscomTransmit getWithUrl:url Parameters:nil];
            // FALTA:
            // MANEJO DE ERRORES DE COMMUNICACION COMO 404 O TIMEOUTS
            // (errores de lógia de negocios son transparentes a syscom
            // PROCESAR EL XML ACA Y CAMBIAR LA VARIABLE isOnline
            // -------------------------------
            // CODIGO DE PRUEBA
            if ([responseText rangeOfString:@"<status>1</status>"].location != NSNotFound){
                isOnline = TRUE;
            }
            else
                isOnline = FALSE;
            // -------------------------------
            
            if (isOnline){
                // Reset the time counter
                _connOfflineTimeInterval = 0;
            } else {
                // Sum the offline time to the counter
                _connOfflineTimeInterval += _syscomConfig.onlineStatusCheckTimeInterval;
            }
            
            if (isOnline != wasOnline){ // if the status has changed
                if (isOnline){
                    // Send the notification of the status change to Online
                    [[NSNotificationCenter defaultCenter] postNotificationName:_syscomConfig.onlineNotificationName object:self];
                }
                else{
                    // Send the notification of the status change to Offline
                    [[NSNotificationCenter defaultCenter] postNotificationName:_syscomConfig.offlineNotificationName object:self];
                }
            }
            wasOnline = isOnline; // Safe the current status for the next check
            // wait a defined time interval before checking again
            [NSThread sleepForTimeInterval:_syscomConfig.onlineStatusCheckTimeInterval];
        }
    }
}


// -----------------------------------------------------------------
// CODIGO PARA PRUEBAS
// -----------------------------------------------------------------


-(void) showStations{
    
    NSString *urlString = [_syscomConfig.serverURL stringByAppendingString:@"showstations"];
    NSURL *requestURL = [NSURL URLWithString:urlString];
    
    NSString *passwordconfig = @"desa";
    NSString *timezone = @"America/New_York";
    NSString *postString =[NSString stringWithFormat:@"passwordconfig=%@&timezone=%@", passwordconfig, timezone];
    
    NSData *postRawData = [postString dataUsingEncoding:NSUTF8StringEncoding];
    NSString *postLength = [NSString stringWithFormat:@"%d", [postRawData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:requestURL];
    [request setHTTPMethod: @"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postRawData];
    [request setCachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData];
    [request setTimeoutInterval:10];
    
    NSError *requestError;
    NSURLResponse *urlResponse = nil;
    
    
    NSData *rawResponse = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&requestError];
    
    NSString* responseText= [[NSString alloc] initWithData:rawResponse encoding:NSUTF8StringEncoding];
    NSLog(@"\n\nshowStations responseText:\n\n%@", responseText);
}

- (void) imageDownload{
    
    NSString *urlString = [_syscomConfig.serverURL stringByAppendingString:@"imagedownload"];
    NSURL *requestURL = [NSURL URLWithString:urlString];
    
    NSString *passwordconfig = @"desa";
    NSString *timezone = @"America/New_York";
    NSString *programId = @"19";
    NSString *clientId = @"13";
    NSString *postString =[NSString stringWithFormat:@"passwordconfig=%@&timezone=%@&id_program=%@&id_client=%@", passwordconfig, timezone, programId, clientId];
    
    NSData *postRawData = [postString dataUsingEncoding:NSUTF8StringEncoding];
    NSString *postLength = [NSString stringWithFormat:@"%d", [postRawData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:requestURL];
    [request setHTTPMethod: @"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postRawData];
    [request setCachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData];
    [request setTimeoutInterval:10];
    
    NSError *requestError;
    NSURLResponse *urlResponse = nil;
    
    
    NSData *rawResponse = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&requestError];
    
    NSString* responseText= [[NSString alloc] initWithData:rawResponse encoding:NSUTF8StringEncoding];
    NSLog(@"\n\nimageDownload responseText:\n\n%@", responseText);
}
- (void) resourceDownload{
    /*
    NSString *url = @"http://checkinsystem.livininteractive.com/desarrolladores/uploads/backgrounds/19/background.png";
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:10];
    [request setHTTPMethod: @"GET"];
    NSError *requestError;
    NSURLResponse *urlResponse = nil;
    NSData *rawResponse = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&requestError];
    
    //UIImage *downloadedImage = [[UIImage alloc] initWithData:rawResponse];
    NSLog(@"\n\nresourceDownload IMAGE DOWNLOADED:\n\n ");*/
}
- (void) sessionRegister{
    
    NSString *urlString = [_syscomConfig.serverURL stringByAppendingString:@"sessionregister"];
    NSURL *requestURL = [NSURL URLWithString:urlString];
    
    NSString *postString = @"passwordconfig=desa&id_device=11%3A22%3A33%3A44%3A55&username=oscar&location=miami&eventdate=2013-06-19&id_station=48&id_program=19";
    
    NSData *postRawData = [postString dataUsingEncoding:NSUTF8StringEncoding];
    NSString *postLength = [NSString stringWithFormat:@"%d", [postRawData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:requestURL];
    [request setHTTPMethod: @"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postRawData];
    [request setCachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData];
    [request setTimeoutInterval:10];
    
    NSError *requestError;
    NSURLResponse *urlResponse = nil;
    
    
    NSData *rawResponse = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&requestError];
    
    NSString* responseText= [[NSString alloc] initWithData:rawResponse encoding:NSUTF8StringEncoding];
    NSLog(@"\n\nsessionRegister responseText:\n\n%@", responseText);
    
}
- (void) showActivities{
    
    NSString *urlString = [_syscomConfig.serverURL stringByAppendingString:@"activities"];
    NSURL *requestURL = [NSURL URLWithString:urlString];
    
    NSString *postString = @"passwordconfig=desa&id_station=48";
    
    NSData *postRawData = [postString dataUsingEncoding:NSUTF8StringEncoding];
    NSString *postLength = [NSString stringWithFormat:@"%d", [postRawData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:requestURL];
    [request setHTTPMethod: @"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postRawData];
    [request setCachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData];
    [request setTimeoutInterval:10];
    
    NSError *requestError;
    NSURLResponse *urlResponse = nil;
    
    
    NSData *rawResponse = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&requestError];
    
    NSString* responseText= [[NSString alloc] initWithData:rawResponse encoding:NSUTF8StringEncoding];
    NSLog(@"\n\nshowActivities responseText:\n\n%@", responseText);
    
}
- (void) visitorRegistration{
    NSString *urlString = [_syscomConfig.serverURL stringByAppendingString:@"visitorRegistration"];
    NSURL *requestURL = [NSURL URLWithString:urlString];
    
    NSString *postString = @"qrcard=998877662&seedfb=1371675704.688241&id_program=19&id_activity=232&visitorfields%5B%5D=73&visitorfields%5B%5D=0&visitorfields%5B%5D=oscar+demo&visitorfields%5B%5D=74&visitorfields%5B%5D=0&visitorfields%5B%5D=1234567890&visitorfields%5B%5D=75&visitorfields%5B%5D=0&visitorfields%5B%5D=a%40axornet.com&visitorfields%5B%5D=76&visitorfields%5B%5D=1&visitorfields%5B%5D=170&visitorfields%5B%5D=342&visitorfields%5B%5D=0&visitorfields%5B%5D=aabbcc&passwordconfig=desa&id_session=133";
    
    NSData *postRawData = [postString dataUsingEncoding:NSUTF8StringEncoding];
    NSString *postLength = [NSString stringWithFormat:@"%d", [postRawData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:requestURL];
    [request setHTTPMethod: @"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postRawData];
    [request setCachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData];
    [request setTimeoutInterval:10];
    
    NSError *requestError;
    NSURLResponse *urlResponse = nil;
    
    
    NSData *rawResponse = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&requestError];
    
    NSString* responseText= [[NSString alloc] initWithData:rawResponse encoding:NSUTF8StringEncoding];
    NSLog(@"\n\nvisitorRegistration responseText:\n\n%@", responseText);
}

- (NSString*) sendPostWithService: (NSString*) service PostString: (NSString*) postString{
    
    return @"";
}

@end
