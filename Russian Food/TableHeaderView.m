//
//  TableHeaderView.m
//  Russian Food
//
//  Created by Paul Chavarria Podoliako on 28/01/12.
//  Copyright (c) 2012 AppFox. All rights reserved.
//

#import "TableHeaderView.h"

@implementation TableHeaderView
@synthesize title;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:@"TableHeaderView" owner:self options:nil];
        
        // Initialization code
    }
    return self;
}
- (UIView *)view
{
    return view;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
