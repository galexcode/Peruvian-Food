//
//  TableHeaderView.h
//  Russian Food
//
//  Created by Paul Chavarria Podoliako on 28/01/12.
//  Copyright (c) 2012 AppFox. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableHeaderView : UIView
{
    
    IBOutlet UIView *view;
}
@property (strong, nonatomic) IBOutlet UILabel *title;
- (UIView *)view;
@end
