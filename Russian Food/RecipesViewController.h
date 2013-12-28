//
//  FirstViewController.h
//  Russian Food
//
//  Created by Paul Chavarria Podoliako on 23/01/12.
//  Copyright (c) 2012 AppFox. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecipesViewController : UIViewController<UIScrollViewDelegate>
{
    
    __weak IBOutlet UITableView *tableview;
    __weak IBOutlet UIScrollView *scrollView;
    int currentPage;
    
    __weak UIViewController *shoppingListViewController;
	__weak IBOutlet UIView *dynamicScrollPaging;
}
@property (nonatomic, weak) UIViewController *shoppingListViewController;

- (IBAction)handleTap:(UIGestureRecognizer *)sender;
@end
