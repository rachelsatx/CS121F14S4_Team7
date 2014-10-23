//
//  Customer.m
//  When Life Gives You Lemons
//
//  Created by Rachel Wilson on 10/21/14.
//  Copyright (c) 2014 Jonathan Finnell, Amit Maor, Joshua Petrack, Megan Shao, Rachel Wilson. All rights reserved.
//

#import "Customer.h"
#import <math.h>

@interface Customer (){
    NSInteger _type;
    NSNumber* _expectedPrice; // The mean for probability model.
    NSNumber* _scaleParameter;  // Akin to standard deviation for probability model.
    
    // Recipe restraints for the customer
    double _lemonMax;
    double _lemonMin;
    double _sugarMax;
    double _sugarMin;
    double _waterMax;
    double _waterMin;
    double _iceMax;
    double _iceMin;
}

@end

@implementation Customer

- (id)init
{
    // Initialize global variables.  These can be changed if they are unrealistic.
    _expectedPrice = [NSNumber numberWithDouble:1.50];
    _scaleParameter = [NSNumber numberWithDouble:0.50];
    
    return self;
}

- (void) setCustomerType:(NSInteger)type
{
    _type = type;
    
    // Set recipe preferences based on type.
    switch (_type) {
        // Happy customer
        case 0:
            _lemonMax = 0.5;
            _lemonMin = 0.05;
            _sugarMax = 0.5;
            _sugarMin = 0.05;
            _waterMax = 0.7;
            _waterMin = 0.05;
            _iceMax = 0.5;
            _iceMin = 0.05;
            break;
            
        // Lots of ice customer
        case 1:
            _lemonMax = 0.3;
            _lemonMin = 0.1;
            _sugarMax = 0.3;
            _sugarMin = 0.1;
            _waterMax = 0.6;
            _waterMin = 0.3;
            _iceMax = 0.35;
            _iceMin = 0.15;
            break;
        
        // Less ice customer
        case 2:
            _lemonMax = 0.3;
            _lemonMin = 0.1;
            _sugarMax = 0.3;
            _sugarMin = 0.1;
            _waterMax = 0.6;
            _waterMin = 0.3;
            _iceMax = 0.15;
            _iceMin = 0.05;
            break;
        
        // Sweet customer
        case 3:
            _lemonMax = 0.3;
            _lemonMin = 0.1;
            _sugarMax = 0.4;
            _sugarMin = 0.2;
            _waterMax = 0.6;
            _waterMin = 0.3;
            _iceMax = 0.2;
            _iceMin = 0.1;
            break;
        
        // Sour customer
        case 4:
            _lemonMax = 0.4;
            _lemonMin = 0.2;
            _sugarMax = 0.3;
            _sugarMin = 0.1;
            _waterMax = 0.6;
            _waterMin = 0.3;
            _iceMax = 0.2;
            _iceMin = 0.1;
            break;
            
            // Flavor customer
        case 5:
            _lemonMax = 0.35;
            _lemonMin = 0.15;
            _sugarMax = 0.35;
            _sugarMin = 0.15;
            _waterMax = 0.5;
            _waterMin = 0.2;
            _iceMax = 0.2;
            _iceMin = 0.1;
            break;
            
        default:
            NSLog(@"Invalid Customer type");
            break;
    }
}

/*  We use a logistic distribution to determine whether a customer will buy at a particular price because it has a simple cumulative distribution function.  */
- (BOOL) willBuyAtPrice:(NSNumber*)price
{
    // Turn necessary global values into doubles for readability.
    double expectedPrice = [_expectedPrice doubleValue];
    double scaleParameter = [_scaleParameter doubleValue];
    
    // Compute 1 - the CDF, so that the higher the price is, the less willing a customer is to buy.
    double buyThreshold = 0.5 - 0.5 * atan(([price doubleValue] - expectedPrice)/2*scaleParameter);
    
    // Seed the random generator, then generate a random number to represent desire for lemonade.
    double willingnessToBuy = drand48();
    
    // If the random number is higher than the buy threshold, the customer will buy the lemonade.
    return (willingnessToBuy < buyThreshold);
}

/*  We use the customer type to determine whether they like the recipe.  */
- (BOOL) likesRecipe:(NSMutableDictionary*)recipe
{
    // Default to yes, change to no if conditions are violated.
    BOOL likesRecipe = YES;
    
    // Get ingredient values from the recipe.
    NSNumber* lemonValue = [recipe objectForKey:@"lemons"];
    NSNumber* sugarValue = [recipe objectForKey:@"sugar"];
    NSNumber* waterValue = [recipe objectForKey:@"water"];
    NSNumber* iceValue = [recipe objectForKey:@"ice"];
    
    // Get the double values from all of the NSNumbers.
    double lemon = [lemonValue doubleValue];
    double sugar = [sugarValue doubleValue];
    double water = [waterValue doubleValue];
    double ice = [iceValue doubleValue];
    
    // Check whether the values fall in the range of preferences.
    if (lemon > _lemonMax || lemon < _lemonMin) {
        likesRecipe = NO;
    }
    if (sugar > _sugarMax || sugar < _sugarMin) {
        likesRecipe = NO;
    }
    if (water > _waterMax || water < _waterMin) {
        likesRecipe = NO;
    }
    if (ice > _iceMax || ice < _iceMin) {
        likesRecipe = NO;
    }
    
    return likesRecipe;
}

@end
