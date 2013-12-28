//
//  Recipe.h
//  Russian Food
//
//  Created by Paul Chavarria Podoliako on 23/01/12.
//  Copyright (c) 2012 AppFox. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Recipe : NSObject
{
    NSArray *steps;
    NSArray *ingredients;
    NSInteger servings;
    NSInteger difficulty;
    NSInteger index;
    BOOL favorite;
    NSString *type;
    NSString *name;
    NSString *englishName;
    NSString *phrase;
    
}
- (id)initWithDictionary:(NSDictionary *)dictionary;

@property (nonatomic, strong) NSArray *steps;
@property (nonatomic, strong) NSArray *ingredients;
@property (nonatomic) NSInteger index;
@property (nonatomic) NSInteger servings;
@property (nonatomic) NSInteger difficulty;
@property (nonatomic) BOOL favorite;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *englishName;
@property (nonatomic, strong) NSString *phrase;

@end
