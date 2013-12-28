//
//  MoreViewController.m
//  Russian Food
//
//  Created by Paul Chavarria Podoliako on 25/01/12.
//  Copyright (c) 2012 AppFox. All rights reserved.
//

#import "MoreViewController.h"
#import "AboutView.h"
#import "HelpViewController.h"

@implementation MoreViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization

        self.navigationItem.title = @"More";
        self.tabBarItem =[[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemMore tag:1];
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
    data = [NSArray arrayWithObjects:
            @"About",@"How to use", @"Review App", nil];
}

- (void)viewDidUnload
{
    tableView = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [data count];
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
    
    cell.textLabel.text = [data objectAtIndex:indexPath.row];
    
    return cell;
}
- (void)tableView:(UITableView *)aTableView 
didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
		//About
        AboutView *view= [[AboutView alloc]initWithNibName:nil bundle:nil];
        [self.navigationController pushViewController:view animated:YES];
    
    }else if(indexPath.row == 1){
		//How to use
		HelpViewController *helpViewController = [[HelpViewController alloc] initWithNibName:nil bundle:nil];
		[self.navigationController pushViewController:helpViewController animated:YES];
	}else if (indexPath.row == 2){
        //Review App
        [[UIApplication sharedApplication] openURL: 
         [NSURL URLWithString:@"http://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?id=499372401&pageNumber=0&sortOrdering=1&type=Purple+Software&mt=8"]];
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
@end
