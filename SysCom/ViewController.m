//
//  ViewController.m
//  SysCom
//
//  Created by lidier on 6/20/13.
//  Copyright (c) 2013 Livininteractive. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

// ------------------------------------------------------
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveConnStatusChangeNotification:)
                                                 name:@"onlineNotification"
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveConnStatusChangeNotification:)
                                                 name:@"offlineNotification"
                                               object:nil];
}

- (void) receiveConnStatusChangeNotification:(NSNotification *) notification
{
    if ([[notification name] isEqualToString:@"onlineNotification"])
        NSLog (@"\nConnection Status Change to Online!  :)\n\n");
    
    if ([[notification name] isEqualToString:@"offlineNotification"])
        NSLog (@"\nConnection Status Change to Offline :( :(\n\n");
}



- (void) dealloc
{
    // If you don't remove yourself as an observer, the Notification Center
    // will continue to try and send notification objects to the deallocated
    // object.
    [[NSNotificationCenter defaultCenter] removeObserver:self];

}

// ------------------------------------------------------


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
