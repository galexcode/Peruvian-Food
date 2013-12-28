//
//  RecipesDetailVC.m
//  Russian Food
//
//  Created by Paul Chavarria Podoliako on 23/01/12.
//  Copyright (c) 2012 AppFox. All rights reserved.
//

#import "RecipesDetailVC.h"
#import "PreparationCell.h"
#import "RecipeStore.h"
#import "Recipe.h"

@implementation RecipesDetailVC
@synthesize recipe,shoppingListViewController,servingsButton;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
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
    
    tableViewPreparation.rowHeight=130;

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    [scrollView setPagingEnabled:YES];
    [scrollView setDelegate:self];
    
    [scrollView addSubview:Page1View];
    [scrollView addSubview:Page2View];
    [scrollView addSubview:Page3View];
    [scrollView addSubview:Page4View];
    [scrollView addSubview:Page5View];
    int desp=0;
    
    CGRect frame;
    
    frame = Page5View.frame;
    frame.origin = CGPointMake(-Page5View.bounds.size.width, 0);
    Page5View.frame = frame;
    
    frame = Page1View.frame;
    frame.origin = CGPointMake(0, 0);
    Page1View.frame = frame;
    
    desp += Page1View.bounds.size.width;
    
    frame = Page2View.frame;
    frame.origin = CGPointMake(desp,0);
    Page2View.frame = frame;
    
    desp += Page2View.bounds.size.width;
    
    frame = Page3View.frame;
    frame.origin = CGPointMake(desp,0);
    Page3View.frame = frame;
    
    desp += Page3View.bounds.size.width;
    
    frame = Page4View.frame;
    frame.origin = CGPointMake(desp,0);
    Page4View.frame = frame;
    
    [scrollView setContentSize:CGSizeMake(desp,self.view.bounds.size.height)];    
    
    phrase.text = recipe.phrase;
    
    if ([[RecipeStore defaultStore] isFavorite:recipe.index]) {
        favoriteButton.alpha = 1.0;
    }
    
    
}

- (void)viewDidUnload
{
    scrollView = nil;
    Page1View = nil;
    Page2View = nil;
    Page3View = nil;
    Page4View = nil;
    pageControl = nil;
    tableViewPreparation = nil;
    tableViewIngredients = nil;
    phrase = nil;
    favoriteButton = nil;
    Page5View = nil;
    imageView = nil;
    recipeNameLabel = nil;
    servingsButton = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"img_%04d_%03d.jpg",recipe.index,recipe.index+1]];
    recipeNameLabel.text = recipe.name;
    self.navigationItem.title = recipe.name;
    servings = recipe.servings;
    
    [servingsButton setTitle:[NSString stringWithFormat:@"%d", servings] forState:UIControlStateNormal];

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

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([tableView isEqual:tableViewIngredients])
    {
        return [recipe.ingredients count];
    }else{
        return [recipe.steps count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if ([tableView isEqual:tableViewIngredients])
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Ingredients"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:@"Ingredients"];
        }
        
        NSDictionary *ingredient = [recipe.ingredients objectAtIndex:indexPath.row];
        if ([[ingredient objectForKey:@"quantity"] doubleValue]==0)
        {
            cell.textLabel.text = @".";
        }else{
            double quantity = [[ingredient objectForKey:@"quantity"] doubleValue];
            NSString *converted;
            
            if (quantity == 0.5) {
                converted = @"½";
            }else if (quantity == 0.25 ){
                converted = @"¼";
            }else if (quantity == 0.75 ){
                converted = @"¾";
            }else if (quantity == 1.5 ){
                converted = @"1 ½";
            }else if (quantity == 1.25){
                converted = @"1 ¼";
            }else if (quantity == 0.3 ){
                converted = @"⅓";
            }else
                converted = [NSString stringWithFormat:@"%.f",quantity];
            
            cell.textLabel.text = [NSString stringWithFormat:@"%@ %@",converted,[ingredient objectForKey:@"measurement"]];
        }
        
        cell.detailTextLabel.text = [ingredient objectForKey:@"ingredient"];
        cell.detailTextLabel.numberOfLines = 2;
        
        cell.textLabel.textColor = [UIColor redColor];
        cell.textLabel.textAlignment = UITextAlignmentCenter;
        cell.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"cellBackground.png"]];
            
        return cell;
        
    }else{
        PreparationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Preparation"];
        if (cell == nil) {
            cell = [[PreparationCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Preparation"];                
        }
        cell.direction.text = [recipe.steps objectAtIndex:indexPath.row];
        cell.step.text = [NSString stringWithFormat:@"%d",indexPath.row+1];
            
        return cell;
    }
    
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view 
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

#pragma mark -
#pragma mark - ScrollView Delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView1
{
    if (![scrollView1 isEqual:scrollView])
        return;
    CGFloat pageWidth = scrollView1.frame.size.width;
    pageControl.currentPage = floor((scrollView1.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
}

- (IBAction)addToShoppingList:(id)sender {
    
    UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Add to shopping list" 
                                                 message:[NSString stringWithFormat:@"Do you want to add the ingredients for %@ to your shopping list?",recipe.name] 
                                                delegate:self 
                                       cancelButtonTitle:@"Cancel" 
                                       otherButtonTitles:@"Ok", nil];
    [av show];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex) {
        [[RecipeStore defaultStore] addToShoppingList:recipe];
        
        NSInteger number = [[[RecipeStore defaultStore] shoppingList] count];
        if (number)
        { 
            shoppingListViewController.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d",number];
            [UIApplication sharedApplication].applicationIconBadgeNumber = number;
        }
    }
}

- (IBAction)favoritePressed:(id)sender {
    [[RecipeStore defaultStore] updateFavorite:recipe.index];
    
    if ([[RecipeStore defaultStore] isFavorite:recipe.index]) {
        favoriteButton.alpha = 1.0;
    }else
        favoriteButton.alpha = 0.4;
    
}

- (IBAction)changeServingsQuantity:(id)sender{
    //servings+=2;
    if (servings>6) {
        servings = 2;
    }
    [servingsButton setTitle:[NSString stringWithFormat:@"%d", servings] forState:UIControlStateNormal];
}


        
@end
