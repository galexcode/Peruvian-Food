//
//  ShoppingViewController.m
//  Russian Food
//
//  Created by Paul Chavarria Podoliako on 24/01/12.
//  Copyright (c) 2012 AppFox. All rights reserved.
//

#import "ShoppingViewController.h"
#import "RecipeStore.h"
#import "Recipe.h"
#import "TableHeaderView.h"

@implementation ShoppingViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.navigationItem.title = @"Shopping List";
        UITabBarItem *tbi = [self tabBarItem];
        [tbi setTitle:@"Shopping List"];
        UIImage *i = [UIImage imageNamed:@"tbList.png"];
        [tbi setImage:i];
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
    // Do any additional setup after loading the view from its nib.
    tableView1.sectionHeaderHeight=32;

    
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
    
    

    
    views = [NSMutableArray array];
    
    for (int i=0; i<[[[RecipeStore defaultStore] shoppingList] count];i++) {
        TableHeaderView * sectionHeaderView = [[TableHeaderView alloc] initWithFrame:CGRectZero];
        sectionHeaderView.title.text=[[[[RecipeStore defaultStore] shoppingList]  objectAtIndex:i] objectForKey:@"name"];
        [views addObject:sectionHeaderView];
    }

}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    views = nil;
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    NSInteger integer = [[NSUserDefaults standardUserDefaults] integerForKey:@"EnterForegroundTime"];
    [[NSUserDefaults standardUserDefaults] setInteger:integer+1 forKey:@"EnterForegroundTime"];
    NSLog(@"%d", integer); 
    if (integer == 15) {
        UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Please Rate the app" 
                                                     message:@"Would you mind rating the app please?" 
                                                    delegate:self 
                                           cancelButtonTitle:@"Don't Ask Again" 
                                           otherButtonTitles:@"Sure", nil];
        [av show];
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSInteger number = [[[RecipeStore defaultStore] shoppingList] count];
    return number;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger number = [[[[[RecipeStore defaultStore] shoppingList] objectAtIndex:section] objectForKey:@"ingredients"] count];
    return number;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [[[[RecipeStore defaultStore] shoppingList] objectAtIndex:section] objectForKey:@"name"];
}
- (UITableViewCell *)tableView:(UITableView *)tableView2 cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView2 dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:CellIdentifier];
    }
    NSDictionary *recipe = [[[RecipeStore defaultStore] shoppingList] objectAtIndex:indexPath.section];
    
    NSDictionary *ingredient = [[recipe objectForKey:@"ingredients"] objectAtIndex:indexPath.row];
    
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
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    TableHeaderView *hv = [views objectAtIndex:section];
    
    return [hv view];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{    
    NSArray *array = [NSArray arrayWithObjects:indexPath, nil];
    [tableView beginUpdates];
    BOOL removeSection = [[RecipeStore defaultStore] deleteIngredientFromIndexPath:indexPath];
    [tableView deleteRowsAtIndexPaths:array withRowAnimation:UITableViewRowAnimationRight];
    
    if (removeSection )
    {
        [tableView deleteSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationRight];
        
        NSInteger number = [[[RecipeStore defaultStore] shoppingList] count];
        
        if (number==0)
        { 
            self.tabBarItem.badgeValue = nil;
            [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
        }else{
            self.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d",number];
            [UIApplication sharedApplication].applicationIconBadgeNumber = number;
        }
    }
    
    [tableView endUpdates];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex) {
        [[UIApplication sharedApplication] openURL: 
         [NSURL URLWithString:@"http://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?id=499372401&pageNumber=0&sortOrdering=1&type=Purple+Software&mt=8"]];
    }
}
@end
