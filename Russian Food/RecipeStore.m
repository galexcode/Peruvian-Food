//
//  RecipeStore.m
//  Russian Food
//
//  Created by Paul Chavarria Podoliako on 23/01/12.
//  Copyright (c) 2012 AppFox. All rights reserved.
//

#import "RecipeStore.h"
#import "Recipe.h"

@interface RecipeStore(mymethods)
- (void)fetchIfNecessary;
@end

static RecipeStore *defaultStore = nil;

NSString * const kSoup = @"Soup";
NSString * const kMainDish = @"Main Dish";
NSString * const kSalad = @"Salad";
NSString * const kDessert = @"Dessert";
NSString * const kDrink = @"Drink";


@implementation RecipeStore

+ (RecipeStore *)defaultStore
{
    if (!defaultStore) {
        defaultStore = [[super allocWithZone:NULL] init];
    }
    return defaultStore;
}
+ (id)allocWithZone:(NSZone *)zone
{
    return [self defaultStore];
}
- (id)init
{
    if (defaultStore) {
        return defaultStore;
    }
    self = [super init];
    
    return self;
}
- (void)fetchIfNecessary
{
    if (!allRecipes)
    {
        allRecipes = [NSMutableArray array];
        soups = [NSMutableArray array];
        salads = [NSMutableArray array];
        desserts = [NSMutableArray array];
        drinks = [NSMutableArray array];
        mainDishes = [NSMutableArray array];
        
        NSString *thePath = [[NSBundle mainBundle]  pathForResource:@"Recipes" ofType:@"plist"];
        
        NSArray *rawRecipesArray = [[NSArray alloc] initWithContentsOfFile:thePath];
        
        for (NSDictionary *eachRecipe in rawRecipesArray) {
            Recipe *recipe = [[Recipe alloc] initWithDictionary:eachRecipe];
            [allRecipes addObject:recipe];
            
            if ([recipe.type isEqualToString:kSoup]) {
                [soups addObject:recipe];
            }else if ([recipe.type isEqualToString:kMainDish]) {
                [mainDishes addObject:recipe];
            }else if ([recipe.type isEqualToString:kSalad]) {
                [salads addObject:recipe];
            }else if ([recipe.type isEqualToString:kDessert]) {
                [desserts addObject:recipe];
            }else if ([recipe.type isEqualToString:kDrink]) {
                [drinks addObject:recipe];
            }else{
                NSLog(@"warning recipe not added: %@", recipe.name);
            }
        }
        
        //load shopping list, etc
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        
        NSString *filePath = [documentsDirectory stringByAppendingPathComponent:@"ShoppingList.plist"];
        shoppingList = [[NSMutableArray alloc]initWithContentsOfFile:filePath];
        
        documentsDirectory = [paths objectAtIndex:0];
        filePath = [documentsDirectory stringByAppendingPathComponent:@"Favorites.plist"];
        favorites = [[NSMutableArray alloc]initWithContentsOfFile:filePath];
        
        if (!favorites) {
            favorites = [NSMutableArray array];
        }
        if (!shoppingList) {
            shoppingList = [NSMutableArray array];
        }
        
    }
    
}
- (NSArray *)allRecipes
{
    [self fetchIfNecessary];
    return allRecipes;
}
- (NSArray *)soups
{
    [self fetchIfNecessary];
    return soups;
}
- (NSArray *)mainDishes
{
    [self fetchIfNecessary];
    return mainDishes;
}
- (NSArray *)salads
{
    [self fetchIfNecessary];
    return salads;
}
- (NSArray *)desserts
{
    [self fetchIfNecessary];
    return desserts;
}
- (NSArray *)drinks
{
    [self fetchIfNecessary];
    return drinks;
}

- (NSArray *)shoppingList
{
    [self fetchIfNecessary];
    return shoppingList;
}
- (NSArray *)favorites
{
    [self fetchIfNecessary];
    return favorites;
}

- (void)saveChanges
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:@"ShoppingList.plist"];
    [[[RecipeStore defaultStore] shoppingList] writeToFile:filePath atomically:YES];
    
    documentsDirectory = [paths objectAtIndex:0];
    filePath = [documentsDirectory stringByAppendingPathComponent:@"Favorites.plist"];
    [[[RecipeStore defaultStore] favorites] writeToFile:filePath atomically:YES];
}
- (void)addToShoppingList:(Recipe *)recipe
{
    [self fetchIfNecessary];

    NSMutableArray *ingredients = [NSMutableArray arrayWithArray:recipe.ingredients];
    
    [shoppingList addObject:[NSDictionary dictionaryWithObjectsAndKeys:recipe.name,@"name", ingredients,@"ingredients", nil]];
}

- (BOOL)deleteIngredientFromIndexPath:(NSIndexPath *)indexPath
{
    NSMutableArray *ingredients = [[shoppingList objectAtIndex:indexPath.section] objectForKey:@"ingredients"];
    [ingredients removeObjectAtIndex:indexPath.row];
    if (![ingredients count]) {
        [shoppingList removeObjectAtIndex:indexPath.section];
        return YES;
    }
    return NO;
}

- (void)updateFavorite:(NSInteger)recipeIndex
{
    
    for (NSNumber *recIndex in favorites) {
        if (recipeIndex == [recIndex integerValue]) {
            [favorites removeObject:recIndex];
            return;
        }
    }
    [favorites addObject:[NSNumber numberWithInteger:recipeIndex]];
    
}
- (BOOL)isFavorite:(NSInteger)recipeIndex
{
    for (NSNumber *recIndex in favorites) {
        if (recipeIndex == [recIndex integerValue]) {
            return YES;
        }
    }
    return NO;
}



@end
