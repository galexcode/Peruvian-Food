//
//  FavoritesViewController.m
//  Russian Food
//
//  Created by Paul Chavarria Podoliako on 24/01/12.
//  Copyright (c) 2012 AppFox. All rights reserved.
//

#import "FavoritesViewController.h"
#import "RecipeStore.h"
#import "Recipe.h"
#import "RecipesDetailVC.h"

@implementation FavoritesViewController
@synthesize shoppingListViewController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.navigationItem.title = @"Favorites";
        self.tabBarItem =[[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemFavorites tag:0];

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
    tableView1.rowHeight= 80;
    // Do any additional setup after loading the view from its nib.
    
}

- (void)viewDidUnload
{
    tableView1 = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [tableView1 reloadData];
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[[RecipeStore defaultStore] favorites] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView2 cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView2 dequeueReusableCellWithIdentifier:CellIdentifier];

    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
        cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cellBackground.png"]];
        cell.selectedBackgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cellBackgroundHighlited.png"]];
        cell.textLabel.highlightedTextColor = [UIColor blackColor];
    }
    
    NSNumber *index = [[[RecipeStore defaultStore] favorites] objectAtIndex:indexPath.row];
    
    Recipe *recipe = [[[RecipeStore defaultStore] allRecipes] objectAtIndex:[index integerValue]];
    
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
    NSNumber *index = [[store favorites] objectAtIndex:indexPath.row];
    recipe = [[store allRecipes] objectAtIndex:[index integerValue]];
    
    RecipesDetailVC *recipesDetailVC= [[RecipesDetailVC alloc]initWithNibName:nil bundle:nil];
    recipesDetailVC.recipe = recipe;
    recipesDetailVC.shoppingListViewController = shoppingListViewController;
    
    [self.navigationController pushViewController:recipesDetailVC animated:YES];
    [tableView1 deselectRowAtIndexPath:indexPath animated:YES];
}

@end
