//
//  HelpViewController.h
//  Russian Food
//
//  Created by Paul Chavarria Podoliako on 19/07/12.
//  Copyright (c) 2012 AppFox. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HelpViewController : UIViewController <UIScrollViewDelegate>
{
	
	IBOutlet UIScrollView *scrollView;
	
	IBOutlet UIView *firstScreen;
	IBOutlet UIView *secondScreen;
	IBOutlet UIView *thirdScreen;
	IBOutlet UIView *fourthScreen;
	IBOutlet UIView *fifthScreen;
	
	IBOutlet UIPageControl *pageControl;
}
@end
