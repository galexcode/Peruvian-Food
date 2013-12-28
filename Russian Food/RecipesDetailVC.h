//
//  RecipesDetailVC.h
//  Russian Food
//
//  Created by Paul Chavarria Podoliako on 23/01/12.
//  Copyright (c) 2012 AppFox. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Recipe;

@interface RecipesDetailVC : UIViewController <UIScrollViewDelegate>
{
    Recipe *recipe;
    
    
    IBOutlet UIScrollView *scrollView;
    
    IBOutlet UITableView *tableViewPreparation;
    IBOutlet UITableView *tableViewIngredients;
    
    IBOutlet UIView *Page1View;
    IBOutlet UIView *Page2View;
    IBOutlet UIView *Page3View;
    IBOutlet UIView *Page4View;
    IBOutlet UIView *Page5View;
    
    IBOutlet UITextView *phrase;
    IBOutlet UIPageControl *pageControl;
    IBOutlet UIButton *favoriteButton;
    
    IBOutlet UILabel *recipeNameLabel;
    IBOutlet UIImageView *imageView;
    
    IBOutlet UIButton *servingsButton;
    NSInteger servings;
    
    __weak UIViewController *shoppingListViewController;
}
@property (nonatomic, weak) UIViewController *shoppingListViewController;

@property (nonatomic, strong) Recipe *recipe;

@property (nonatomic, strong) UIButton *servingsButton;

- (IBAction)addToShoppingList:(id)sender;
- (IBAction)favoritePressed:(id)sender;
- (IBAction)changeServingsQuantity:(id)sender;

@end
