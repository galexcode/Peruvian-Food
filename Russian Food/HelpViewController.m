//
//  HelpViewController.m
//  Russian Food
//
//  Created by Paul Chavarria Podoliako on 19/07/12.
//  Copyright (c) 2012 AppFox. All rights reserved.
//

#import "HelpViewController.h"

@interface HelpViewController ()

@end

@implementation HelpViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
		
		if([[[NSUserDefaults standardUserDefaults] objectForKey:@"FirstLauch"] boolValue])
		{
			self.navigationItem.title = @"Welcome!";
		
		
			UIBarButtonItem *bbi2 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
																			  target:self                                                                              
																			  action:@selector(done:)];
        
			[[self navigationItem] setRightBarButtonItem:bbi2];   
		}else {
			self.navigationItem.title = @"How to use";
		}
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
	[scrollView setPagingEnabled:YES];
    [scrollView setDelegate:self];
    
    [scrollView addSubview:firstScreen];
	[scrollView addSubview:secondScreen];
	[scrollView addSubview:thirdScreen];
	[scrollView addSubview:fourthScreen];
	[scrollView addSubview:fifthScreen];
    int desp=0;
    
    CGRect frame;
	
    frame = firstScreen.frame;
    frame.origin = CGPointMake(0, 0);
    firstScreen.frame = frame;
    
    desp += firstScreen.bounds.size.width;
	
	frame = secondScreen.frame;
    frame.origin = CGPointMake(desp, 0);
    secondScreen.frame = frame;
    
    desp += secondScreen.bounds.size.width;
	
	frame = thirdScreen.frame;
    frame.origin = CGPointMake(desp, 0);
    thirdScreen.frame = frame;
    
    desp += thirdScreen.bounds.size.width;
	
	frame = fourthScreen.frame;
    frame.origin = CGPointMake(desp, 0);
    fourthScreen.frame = frame;
    
    desp += fifthScreen.bounds.size.width;
	
	frame = fifthScreen.frame;
    frame.origin = CGPointMake(desp, 0);
    fifthScreen.frame = frame;
    
    desp += fifthScreen.bounds.size.width;
 
    [scrollView setContentSize:CGSizeMake(desp,self.view.bounds.size.height)];    
   
}

- (void)viewDidUnload
{
    firstScreen = nil;
    scrollView = nil;
	secondScreen = nil;
	thirdScreen = nil;
	fourthScreen = nil;
	fifthScreen = nil;
	pageControl = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView1
{
    if (![scrollView1 isEqual:scrollView])
        return;
    CGFloat pageWidth = scrollView1.frame.size.width;
    pageControl.currentPage = floor((scrollView1.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
}
- (void)done:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
}
@end
