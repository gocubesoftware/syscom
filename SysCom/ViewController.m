//
//  ViewController.m
//  SysCom
//
//  Created by lidier on 6/20/13.
//  Copyright (c) 2013 Livininteractive. All rights reserved.
//

#import "ViewController.h"
#import "SysCom.h"
#import "SysComConfig.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize syscom = _syscom;

- (void) initSysCom{
    SysComConfig *syscomConfig = [[SysComConfig alloc] init];
    _syscom = [[SysCom alloc] initWithConfig:syscomConfig];
    [_syscom serverOnline];
    [_syscom showStations];
    [_syscom imageDownload];
    [_syscom resourceDownload];
    [_syscom sessionRegister];
    [_syscom showActivities];
    [_syscom visitorRegistration];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
