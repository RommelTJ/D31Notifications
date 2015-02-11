//
//  ViewController.m
//  D31Notifications
//
//  Created by Rommel Rico on 2/10/15.
//  Copyright (c) 2015 Rommel Rico. All rights reserved.
//

#import "ViewController.h"

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
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
