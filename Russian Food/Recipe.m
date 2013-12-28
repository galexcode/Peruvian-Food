//
//  Recipe.m
//  Russian Food
//
//  Created by Paul Chavarria Podoliako on 23/01/12.
//  Copyright (c) 2012 AppFox. All rights reserved.
//

#import "Recipe.h"

@implementation Recipe
@synthesize steps,ingredients,type, servings,difficulty,
favorite,name,phrase,index,englishName;

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    if ([self init]) {
        self.steps = [dictionary objectForKey:@"steps"];
        self.ingredients = [dictionary objectForKey:@"ingredients"];
        self.type = [dictionary valueForKey:@"type"];
        self.servings = [[dictionary valueForKey:@"servings"] integerValue];
        self.difficulty = [[dictionary valueForKey:@"difficulty"] integerValue];
        self.favorite = [[dictionary valueForKey:@"favorite"] boolValue];
        self.name = [dictionary valueForKey:@"name"];
        self.phrase = [dictionary valueForKey:@"phrase"];
        self.index = [[dictionary valueForKey:@"index"] integerValue];
        self.englishName = [dictionary valueForKey:@"englishName"];
    }
    return self;
}

@end
