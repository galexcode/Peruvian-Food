//
//  FavoritesViewController.h
//  Russian Food
//
//  Created by Paul Chavarria Podoliako on 24/01/12.
//  Copyright (c) 2012 AppFox. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FavoritesViewController : UIViewController
{
    
    IBOutlet UITableView *tableView1;
    
    __weak UIViewController *shoppingListViewController;
    
}
@property (nonatomic, weak) UIViewController *shoppingListViewController;
@end
