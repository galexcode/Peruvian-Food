//
//  TimerViewController.h
//  Russian Food
//
//  Created by Paul Chavarria Podoliako on 24/01/12.
//  Copyright (c) 2012 AppFox. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TimerViewController : UIViewController
{
    
    IBOutlet UIDatePicker *timePicker;
    BOOL started;
    int minLeft;
    
    IBOutlet UILabel *timeLeft;
    IBOutlet UIButton *startStopButton;
    NSTimer *timer;
    BOOL visible;
}
- (IBAction)startStopPressed:(id)sender;

@end
