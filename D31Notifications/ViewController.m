//
//  ViewController.m
//  D31Notifications
//
//  Created by Rommel Rico on 2/10/15.
//  Copyright (c) 2015 Rommel Rico. All rights reserved.
//

#import "ViewController.h"

#define LONG_RUNNING_OP_COMPLETE @"LongRunningOpComplete"
#define KEY_DEBUG_SWITCH @"DebugSwitch"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *myLongRunningOpsInProgressCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *myLongRunningOpsCompleteCountLabel;
@property (weak, nonatomic) IBOutlet UISwitch *myDebugModeSwitch;
@property (weak, nonatomic) IBOutlet UITextView *myTextView;

@property NSMutableString *ms;
@property int myLongRunningOps;
@property int myLongRunningOpsComplete;

@end

@implementation ViewController

- (IBAction)doStartLongRunningButton:(id)sender {
    self.myLongRunningOps++;
    [self updateDisplay];
    
    //Start a long running operation.
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        //This code is on a separate thread.
        sleep(5); //Simulate taking 5 seconds to do some work.
        dispatch_async(dispatch_get_main_queue(), ^{
            [[NSNotificationCenter defaultCenter] postNotificationName:LONG_RUNNING_OP_COMPLETE object:nil];
        });
    });
    
    
}

- (IBAction)doDebugSwitch:(id)sender {
    //Just save the data for demo purposes
    [[NSUserDefaults standardUserDefaults] setBool:self.myDebugModeSwitch.on forKey:KEY_DEBUG_SWITCH];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)updateDisplay {
    self.myLongRunningOpsInProgressCountLabel.text = [NSString stringWithFormat:@"%i", self.myLongRunningOps];
    self.myLongRunningOpsCompleteCountLabel.text = [NSString stringWithFormat:@"%i", self.myLongRunningOpsComplete];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.ms = [[NSMutableString alloc] init];
    [self.ms appendString:@"Notifications Demo\n"];
    
    self.myDebugModeSwitch.on = NO;
    self.myTextView.text = self.ms;
    self.myTextView.editable = NO;
    
    //Receive notification when app is going into the background.
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self selector:@selector(doEnterBackground:) name:UIApplicationDidEnterBackgroundNotification object:nil];
    
    //Register to receive notification when user-defaults change.
    [nc addObserverForName:NSUserDefaultsDidChangeNotification object:nil queue:nil usingBlock:^(NSNotification *note) {
        //NOTE: Make this is on the main thread!
        [self.ms appendFormat:@"%@\n", note.name];
        self.myTextView.text = self.ms;
    }];
    
    //Register to receive a notification when long-running operation completes.
    [nc addObserverForName:LONG_RUNNING_OP_COMPLETE object:nil queue:nil usingBlock:^(NSNotification *note) {
        //NOTE: Make sure this is on the main thread!
        self.myLongRunningOpsComplete++;
        [self updateDisplay];
        [self.ms appendFormat:@"%@\n", note.name];
        self.myTextView.text = self.ms;
    }];
}

- (void)doEnterBackground:(NSNotification *)notification {
    [self.ms appendString:notification.name];
    [self.ms appendString:@"\n"];
    self.myTextView.text = self.ms;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
