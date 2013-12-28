//
//  AppDelegate.m
//  Russian Food
//
//  Created by Paul Chavarria Podoliako on 23/01/12.
//  Copyright (c) 2012 AppFox. All rights reserved.
//

#import "AppDelegate.h"

#import "RecipesViewController.h"
#import "ShoppingViewController.h"
#import "TimerViewController.h"
#import "FavoritesViewController.h"
#import "MoreViewController.h"

#import "RecipeStore.h"

@implementation AppDelegate

@synthesize window = _window;
@synthesize tabBarController = _tabBarController;
+ (void)initialize
{
    NSDictionary *defaults = [NSDictionary 
                              dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:0], @"EnterForegroundTime",[NSNumber numberWithBool:YES],@"FirstLauch",nil];
							
    [[NSUserDefaults standardUserDefaults] registerDefaults:defaults];
	
}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [[NSBundle mainBundle] pathForResource:@"dsf" ofType:@"xv"];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackOpaque];
    
    RecipesViewController *vc1 = [[RecipesViewController alloc] initWithNibName:nil bundle:nil];
    UIViewController *vc2 = [[ShoppingViewController alloc] initWithNibName:nil bundle:nil];
    
    vc1.shoppingListViewController = vc2;    
    
    UIViewController *vc3 = [[TimerViewController alloc] initWithNibName:nil bundle:nil];
    
    FavoritesViewController *vc4 = [[FavoritesViewController alloc] initWithNibName:nil bundle:nil];
    vc4.shoppingListViewController = vc2;
    
    UIViewController *vc5 = [[MoreViewController alloc] initWithNibName:nil bundle:nil];
    
    
    UINavigationController *nc1 = [[UINavigationController alloc]init];
    [nc1 setViewControllers:[NSArray arrayWithObjects:vc1, nil]];
    [[nc1 navigationBar] setBarStyle:UIBarStyleBlackOpaque];
    [nc1.navigationBar setTintColor:[UIColor colorWithWhite:0.2 alpha:1.0]];
    
    UINavigationController *nc2 = [[UINavigationController alloc]init];
    [nc2 setViewControllers:[NSArray arrayWithObjects:vc2, nil]];
    [[nc2 navigationBar] setBarStyle:UIBarStyleBlackOpaque];
    [nc2.navigationBar setTintColor:[UIColor colorWithWhite:0.2 alpha:1.0]];
    
    UINavigationController *nc4 = [[UINavigationController alloc]init];
    [nc4 setViewControllers:[NSArray arrayWithObjects:vc4, nil]];
    [[nc4 navigationBar] setBarStyle:UIBarStyleBlackOpaque];
    [nc4.navigationBar setTintColor:[UIColor colorWithWhite:0.2 alpha:1.0]];
    
    UINavigationController *nc5 = [[UINavigationController alloc]init];
    [nc5 setViewControllers:[NSArray arrayWithObjects:vc5, nil]];
    [[nc5 navigationBar] setBarStyle:UIBarStyleBlackOpaque];
    [nc5.navigationBar setTintColor:[UIColor colorWithWhite:0.2 alpha:1.0]];

    
    
    NSInteger number = [[[RecipeStore defaultStore] shoppingList] count];
    
    if (number)
    { 
        nc2.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d",number];
        [UIApplication sharedApplication].applicationIconBadgeNumber = number;
    }
	
	
    
    
    self.tabBarController = [[UITabBarController alloc] init];
    self.tabBarController.viewControllers = [NSArray arrayWithObjects:nc1, nc2, vc3, nc4,nc5,nil];
    self.window.rootViewController = self.tabBarController;
    [self.window makeKeyAndVisible];
	
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
    [[RecipeStore defaultStore] saveChanges];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
    
    
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
}
*/

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed
{
}
*/

@end
