//
//  RecipeStore.h
//  Russian Food
//
//  Created by Paul Chavarria Podoliako on 23/01/12.
//  Copyright (c) 2012 AppFox. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Recipe;
@interface RecipeStore : NSObject
{
    NSMutableArray *allRecipes;
    NSMutableArray *soups;
    NSMutableArray *mainDishes;
    NSMutableArray *salads;
    NSMutableArray *desserts;
    NSMutableArray *drinks;
    
    NSMutableArray *shoppingList;
    NSMutableArray *favorites;
}

+ (RecipeStore *)defaultStore;

- (NSArray *)allRecipes;
- (NSArray *)soups;
- (NSArray *)mainDishes;
- (NSArray *)salads;
- (NSArray *)desserts;
- (NSArray *)drinks;

- (NSArray *)shoppingList;
- (NSArray *)favorites;

- (void)saveChanges;
- (void)addToShoppingList:(Recipe *)recipe;

- (BOOL)deleteIngredientFromIndexPath:(NSIndexPath *)indexPath;

- (void)updateFavorite:(NSInteger)recipeIndex;
- (BOOL)isFavorite:(NSInteger)recipeIndex;
@end
