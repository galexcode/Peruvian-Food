//
//  TimerViewController.m
//  Russian Food
//
//  Created by Paul Chavarria Podoliako on 24/01/12.
//  Copyright (c) 2012 AppFox. All rights reserved.
//

#import "TimerViewController.h"

@implementation TimerViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.navigationItem.title = @"Timer";
        UITabBarItem *tbi = [self tabBarItem];
        tbi.title = @"Timer";
        tbi.image = [UIImage imageNamed:@"tbTimer.png"];
        started = NO;
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    timePicker = nil;
    timeLeft = nil;
    startStopButton = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (!started) {
        self.tabBarItem.badgeValue = nil;
    }
    visible = YES;
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    visible = NO;
    
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)timerFireMethod:(NSTimer*)theTimer
{
    minLeft--;
    if (!minLeft) {
        [theTimer invalidate];
        timeLeft.text = [NSString stringWithFormat:@"%01d:%02d:%02d",0,0,0];
        if (!minLeft && !visible)
            self.tabBarItem.badgeValue = @"Done!";
        else
            self.tabBarItem.badgeValue = nil;
        [self startStopPressed:nil];
        return;
    }
    timeLeft.text = [NSString stringWithFormat:@"%01d:%02d:%02d",minLeft/3600,(minLeft/60)%60,minLeft%60];
    
    if (minLeft/3600) {
        self.tabBarItem.badgeValue = [NSString stringWithFormat:@"%01d:%02d",minLeft/3600,minLeft/60%60];
    }else
        self.tabBarItem.badgeValue = [NSString stringWithFormat:@"%02d:%02d",minLeft/60%60,minLeft%60];
}

- (IBAction)startStopPressed:(id)sender {
    started = !started;
    if (started) {
        [startStopButton setImage:[UIImage imageNamed:@"buttonStop.png"] forState:UIControlStateNormal];
        minLeft = [timePicker countDownDuration];
        timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerFireMethod:) userInfo:nil repeats:YES];
        if (sender) 
            [self timerFireMethod:nil];
        
    }else{
        [timer invalidate];
        [startStopButton setImage:[UIImage imageNamed:@"buttonStart.png"] forState:UIControlStateNormal];
        
        timeLeft.text = [NSString stringWithFormat:@"%01d:%02d:%02d",0,0,0];
        if (sender)
            self.tabBarItem.badgeValue = nil;
    }
    
}

@end
