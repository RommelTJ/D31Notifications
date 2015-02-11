//
//  ViewController.m
//  D31Notifications
//
//  Created by Rommel Rico on 2/10/15.
//  Copyright (c) 2015 Rommel Rico. All rights reserved.
//

#import "ViewController.h"

#define LONG_RUNNING_OP_COMPLETE @"LongRunningOpComplete"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *myLongRunningOpsInProgressCount;
@property (weak, nonatomic) IBOutlet UILabel *myLongRunningOpsCompleteCount;
@property (weak, nonatomic) IBOutlet UISwitch *myDebugModeSwitch;
@property (weak, nonatomic) IBOutlet UITextView *myTextView;

@end

@implementation ViewController

- (IBAction)doStartLongRunningButton:(id)sender {
    //TODO
}
- (IBAction)doDebugSwitch:(id)sender {
    //TODO
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.myDebugModeSwitch.on = NO;
    self.myTextView.text = @"";
    self.myTextView.editable = NO;
    
    //Receive notification when app is going into the background.
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self selector:@selector(doEnterBackground:) name:UIApplicationDidEnterBackgroundNotification object:nil];
    
    //Register to receive notification when user-defaults change.
    [nc addObserverForName:NSUserDefaultsDidChangeNotification object:nil queue:nil usingBlock:^(NSNotification *note) {
        //TODO
    }];
    
    //Register to receive a notification when long-running operation completes.
    [nc addObserverForName:LONG_RUNNING_OP_COMPLETE object:nil queue:nil usingBlock:^(NSNotification *note) {
        //TODO
    }];
}

- (void)doEnterBackground:(NSNotification *)notification {
    //TODO
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
