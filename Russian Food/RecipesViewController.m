//
//  FirstViewController.m
//  Russian Food
//
//  Created by Paul Chavarria Podoliako on 23/01/12.
//  Copyright (c) 2012 AppFox. All rights reserved.
//

#import "RecipesViewController.h"
#import "RecipesDetailVC.h"
#import "RecipeStore.h"
#import "Recipe.h"
#import "HelpViewController.h"

@implementation RecipesViewController
@synthesize shoppingListViewController;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Recipes", @"Recipes");
        self.tabBarItem.image = [UIImage imageNamed:@"tbRecipes.png"];
        
    }
    return self;
}
							
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}
#pragma mark -
#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    tableview.rowHeight= 80;
	// Do any additional setup after loading the view, typically from a nib.

    NSString *imageName = [NSString stringWithFormat:@"scroller.png"];
    UIImage *image = [UIImage imageNamed:imageName];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];

    CGRect rect = imageView.frame;
    rect.size.height = 56 ;
    rect.size.width = 1274;
    rect.origin= CGPointMake(-106*3, 0);
    imageView.frame = rect;
        
    [scrollView addSubview:imageView];
    
    [scrollView setContentSize:CGSizeMake((106*6), [scrollView bounds].size.height)];
    [scrollView scrollRectToVisible:CGRectMake(106, 0, 106, 56) animated:NO];
    [scrollView setDelegate:self];
    
    currentPage = 1;
	
	
	if([[[NSUserDefaults standardUserDefaults] objectForKey:@"FirstLauch"] boolValue])
	{
		HelpViewController *helpViewController = [[HelpViewController alloc] initWithNibName:nil bundle:nil];
		
		UINavigationController *nc1 = [[UINavigationController alloc]init];
		[nc1 setViewControllers:[NSArray arrayWithObjects:helpViewController, nil]];
		[nc1.navigationBar setTintColor:[UIColor colorWithWhite:0.3 alpha:1.0]];
		
		UITabBarController *controller = [[UITabBarController alloc] init];
		controller.viewControllers = [NSArray arrayWithObject:nc1];
		controller.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
		controller.selectedIndex = -1;
		
		[self presentModalViewController:controller animated:YES];
		[[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"FirstLauch"];
	}
    
}

- (IBAction)handleTap:(UIGestureRecognizer *)sender
{
	if(currentPage==1)
	{
		CGFloat width = dynamicScrollPaging.bounds.size.width / 3.0;
		[scrollView scrollRectToVisible:CGRectMake(width*1.5, 0, 106, 56) animated:YES];
		currentPage = -1;
	}	
}

- (void)viewDidUnload
{
    tableview = nil;
    scrollView = nil;
	dynamicScrollPaging = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}
#pragma mark -
#pragma mark - TableView DataSource
- (NSInteger)tableView:(UITableView *)tableView 
 numberOfRowsInSection:(NSInteger)section
{
    RecipeStore *store = [RecipeStore defaultStore];
    
    switch (currentPage) {
        case 0:
            return [[store allRecipes] count];
            break;
        case 1:
            return [[store soups] count];
            break;
        case 2:
            return [[store mainDishes] count];
            break;
        case 3:
            return [[store salads] count];
            break;
        case 4:
            return [[store desserts] count];
            break;
        case 5:
            return [[store drinks] count];
            break;
        default:
            break;
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView 
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
        cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cellBackground.png"]];
        cell.selectedBackgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cellBackgroundHighlited.png"]];
        cell.textLabel.highlightedTextColor = [UIColor colorWithRed:0.8 green:0 blue:0 alpha:1.0];
        cell.detailTextLabel.highlightedTextColor = [UIColor grayColor];
    }
    
    Recipe *recipe;
    RecipeStore *store = [RecipeStore defaultStore];
    
    switch (currentPage) {
        case 0:
            recipe = [[store allRecipes] objectAtIndex:indexPath.row];
            break;
        case 1:
            recipe = [[store soups] objectAtIndex:indexPath.row];
            break;
        case 2:
            recipe = [[store mainDishes] objectAtIndex:indexPath.row];
            break;
        case 3:
            recipe = [[store salads] objectAtIndex:indexPath.row];
            break;
        case 4:
            recipe = [[store desserts] objectAtIndex:indexPath.row];
            break;
        case 5:
            recipe = [[store drinks] objectAtIndex:indexPath.row];
            break;
        default:
            break;
    }
    
    cell.textLabel.text = recipe.name;
    cell.textLabel.numberOfLines = 2;
    cell.detailTextLabel.text = recipe.englishName;
    cell.detailTextLabel.numberOfLines = 2;
    
    cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"thumb_%04d_%03d.jpg",recipe.index,recipe.index+1]];
    
    
    
    return cell;   
}
- (void)tableView:(UITableView *)aTableView 
didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    Recipe *recipe;
    RecipeStore *store = [RecipeStore defaultStore];

    switch (currentPage) {
        case 0:
            recipe = [[store allRecipes] objectAtIndex:indexPath.row];
            break;
        case 1:
            recipe = [[store soups] objectAtIndex:indexPath.row];
            break;
        case 2:
            recipe = [[store mainDishes] objectAtIndex:indexPath.row];
            break;
        case 3:
            recipe = [[store salads] objectAtIndex:indexPath.row];
            break;
        case 4:
            recipe = [[store desserts] objectAtIndex:indexPath.row];
            break;
        case 5:
            recipe = [[store drinks] objectAtIndex:indexPath.row];
            break;
        default:
            break;
    }
    
    RecipesDetailVC *recipesDetailVC= [[RecipesDetailVC alloc]initWithNibName:nil bundle:nil];
    recipesDetailVC.recipe = recipe;
    recipesDetailVC.shoppingListViewController = shoppingListViewController;
    
    [self.navigationController pushViewController:recipesDetailVC animated:YES];
    [tableview deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark -
#pragma mark - Rotation
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark -
#pragma mark - ScrollView Delegate
- (void) scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView1
{
	if(currentPage == -1)
	{
		if ([scrollView1 isEqual:scrollView])
		{
			[scrollView1 scrollRectToVisible:CGRectMake(106, 0, 106, 56) animated:YES];
			currentPage = 1;
		}
		
	}
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView1
{
    if ([scrollView1 isEqual:scrollView])
    {
        CGFloat pageWidth = scrollView1.frame.size.width;
        currentPage = floor((scrollView1.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
        [tableview reloadData];
    }
}
@end
