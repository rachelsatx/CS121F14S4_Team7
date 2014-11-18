//
//  When_Life_Gives_You_LemonsTests.m
//  When Life Gives You LemonsTests
//
//  Created by jarthurcs on 10/17/14.
//  Copyright (c) 2014 Jonathan Finnell, Amit Maor, Joshua Petrack, Megan Shao, Rachel Wilson. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Model.h"
#import "DataStore.h"

@interface When_Life_Gives_You_LemonsTests : XCTestCase

@end

@implementation When_Life_Gives_You_LemonsTests

Model *model;

- (void)setUp
{
    [super setUp];
    model = [[Model alloc] init];
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}


// Test simulateDayWithDataStore:
- (void)testSimulateDayWithEmptyInventory{
    DataStore* dataStore = [[DataStore alloc] init];
    DataStore* newDataStore = [model simulateDayWithDataStore:dataStore];
    
    XCTAssertEqual(newDataStore.getCupsSold, 0, @"Sold %d cups of lemonade without having any ingredients", newDataStore.getCupsSold);
    XCTAssertEqual([newDataStore.getPopularity integerValue], 0, @"Popularity increased from 0 to %@ without selling any lemonade", newDataStore.getPopularity);
    XCTAssertEqual([newDataStore.getProfit integerValue], 0, @"Earned $%@ without selling any lemonade", newDataStore.getProfit);
}


// Test randomNumberAtLeast:andAtMost:
- (void)testRandomNumberEqualBounds{
    int number = [model randomNumberAtLeast:5 andAtMost:5];
    XCTAssertEqual(number, 5, @"Random number between 5 and 5 gave value of %i", number);
}

- (void)testRandomNumberInvalidBounds{
    XCTAssertThrows([model randomNumberAtLeast:5 andAtMost:4],
                    @"Random number with invalid bounds did not throw error");
}


// Test mostCupsMakeableFromInventory:
- (void)testCorrectCupsFromInventory0{
    NSMutableDictionary *inventory         = [[NSMutableDictionary alloc] initWithObjects:
                                              @[@5.00,      @5.00,     @5.00,   @5.00] forKeys:
                                              @[@"lemons", @"sugar", @"ice", @"cups"]];
    
    NSMutableDictionary *recipe            = [[NSMutableDictionary alloc] initWithObjects:
                                              @[@1.00,      @0.00,     @0.00,   @0.00] forKeys:
                                              @[@"lemons", @"sugar", @"ice", @"water"]];
    
    int correctCups = 5;
    int calculatedCups = [model mostCupsMakableFromInventory:inventory withRecipe:recipe];
    XCTAssertEqual(correctCups, calculatedCups, @"Model thinks it can make %i cups", calculatedCups);
}

- (void)testCorrectCupsFromInventory1{
    NSMutableDictionary *inventory         = [[NSMutableDictionary alloc] initWithObjects:
                                              @[@5.00,      @5.00,     @5.00,   @25.00] forKeys:
                                              @[@"lemons", @"sugar", @"ice", @"cups"]];
    
    NSMutableDictionary *recipe            = [[NSMutableDictionary alloc] initWithObjects:
                                              @[@0.20,      @0.20,     @0.20,   @0.40] forKeys:
                                              @[@"lemons", @"sugar", @"ice", @"water"]];
    
    int correctCups = 25;
    int calculatedCups = [model mostCupsMakableFromInventory:inventory withRecipe:recipe];
    XCTAssertEqual(correctCups, calculatedCups, @"Model thinks it can make %i cups", calculatedCups);
}

- (void)testCorrectCupsFromInventory2{
    NSMutableDictionary *inventory         = [[NSMutableDictionary alloc] initWithObjects:
                                              @[@5.00,      @5.00,     @5.00,   @500.00] forKeys:
                                              @[@"lemons", @"sugar", @"ice", @"cups"]];
    
    NSMutableDictionary *recipe            = [[NSMutableDictionary alloc] initWithObjects:
                                              @[@0.00,      @0.00,     @0.00,   @1.00] forKeys:
                                              @[@"lemons", @"sugar", @"ice", @"water"]];
    
    int correctCups = 500;
    int calculatedCups = [model mostCupsMakableFromInventory:inventory withRecipe:recipe];
    XCTAssertEqual(correctCups, calculatedCups, @"Model thinks it can make %i cups", calculatedCups);
}

- (void)testCorrectCupsFromInventory3{
    NSMutableDictionary *inventory         = [[NSMutableDictionary alloc] initWithObjects:
                                              @[@0.00,      @5.00,     @5.00,   @5.00] forKeys:
                                              @[@"lemons", @"sugar", @"ice", @"cups"]];
    
    NSMutableDictionary *recipe            = [[NSMutableDictionary alloc] initWithObjects:
                                              @[@1.00,      @0.00,     @0.00,   @0.00] forKeys:
                                              @[@"lemons", @"sugar", @"ice", @"water"]];
    
    int correctCups = 0;
    int calculatedCups = [model mostCupsMakableFromInventory:inventory withRecipe:recipe];
    XCTAssertEqual(correctCups, calculatedCups, @"Model thinks it can make %i cups", calculatedCups);
}

// Test
- (void)testInvalidWeekday{
    XCTAssertThrows([model customersFromWeekday:9], @"Invalid weekday did not throw exception.");
}

// Test calculateNewPopularityWithNumCustomers:
- (void)testNoPopularityIncrease{
    int totalCustomers = 40;
    float portionWhoBought = 0.0;
    float portionWhoLiked = 0.0;
    NSNumber* oldPopularity = [NSNumber numberWithInt:0];
    
    XCTAssertEqual([model calculateNewPopularityWithNumCustomers:totalCustomers
                                                   portionBought:portionWhoBought
                                                    portionLiked:portionWhoLiked
                                               fromOldPopularity:oldPopularity], 0,
                   @"Popularity was non-zero after starting at zero and no customers buying or liking lemonade");
    
    portionWhoBought = 1.0;
    
    XCTAssertEqual([model calculateNewPopularityWithNumCustomers:totalCustomers
                                                   portionBought:portionWhoBought
                                                    portionLiked:portionWhoLiked
                                               fromOldPopularity:oldPopularity], 0,
                   @"Popularity was non-zero after starting at zero with all customers buying and none liking lemonade");
}


// Test removeIngredientsOfRecipe:fromInventory:
- (void)testRemoveIngredientsAllLemons{
    NSMutableDictionary *inventory         = [[NSMutableDictionary alloc] initWithObjects:
                                              @[@5.00,      @5.00,     @5.00,   @5.00] forKeys:
                                              @[@"lemons", @"sugar", @"ice", @"cups"]];
    
    NSMutableDictionary *expectedInventory = [[NSMutableDictionary alloc] initWithObjects:
                                              @[@4.00,      @5.00,     @5.00,   @4.00] forKeys:
                                              @[@"lemons", @"sugar", @"ice", @"cups"]];
    
    NSMutableDictionary *recipe            = [[NSMutableDictionary alloc] initWithObjects:
                                              @[@1.00,      @0.00,     @0.00,   @0.00] forKeys:
                                              @[@"lemons", @"sugar", @"ice", @"water"]];
    
    NSMutableDictionary *newInventory = [model removeIngredientsOfRecipe:recipe fromInventory:inventory];
    
    XCTAssertEqualObjects(newInventory, expectedInventory,
                          @"Removing recipe of all lemons from inventory gave incorrect result");
}

- (void)testRemoveIngredientsAllWater{
    NSMutableDictionary *inventory         = [[NSMutableDictionary alloc] initWithObjects:
                                              @[@5.00,      @5.00,     @5.00,   @5.00] forKeys:
                                              @[@"lemons", @"sugar", @"ice", @"cups"]];
    
    NSMutableDictionary *expectedInventory = [[NSMutableDictionary alloc] initWithObjects:
                                              @[@5.00,      @5.00,     @5.00,   @4.00] forKeys:
                                              @[@"lemons", @"sugar", @"ice", @"cups"]];
    
    NSMutableDictionary *recipe            = [[NSMutableDictionary alloc] initWithObjects:
                                              @[@0.00,      @0.00,     @0.00,   @1.00] forKeys:
                                              @[@"lemons", @"sugar", @"ice", @"water"]];
    
    NSMutableDictionary *newInventory = [model removeIngredientsOfRecipe:recipe fromInventory:inventory];
    
    XCTAssertEqualObjects(newInventory, expectedInventory,
                          @"Removing recipe of all water from inventory gave incorrect result");
}

- (void)testRemoveIngredientsMixedRecipe{

    // This test is prone to floating point errors, so:
    float acceptableError = .0001;
    
    NSMutableDictionary *inventory         = [[NSMutableDictionary alloc] initWithObjects:
                                              @[@5.00,      @5.00,     @5.00,   @5.00] forKeys:
                                              @[@"lemons", @"sugar", @"ice", @"cups"]];
    
    NSMutableDictionary *expectedInventory = [[NSMutableDictionary alloc] initWithObjects:
                                              @[@4.85,      @4.90,     @4.80,   @4.00] forKeys:
                                              @[@"lemons", @"sugar", @"ice", @"cups"]];
    
    NSMutableDictionary *recipe            = [[NSMutableDictionary alloc] initWithObjects:
                                              @[@0.15,      @0.10,     @0.20,   @0.55] forKeys:
                                              @[@"lemons", @"sugar", @"ice", @"water"]];
    
    NSMutableDictionary *newInventory = [model removeIngredientsOfRecipe:recipe fromInventory:inventory];
    
    // Test that each ingredient is within acceptable floating-point deviation from what is expected.
    
    for (NSString *ingredient in @[@"lemons", @"sugar", @"ice", @"cups"]) {
        XCTAssert(
                  fabsf([[expectedInventory valueForKey:ingredient] floatValue] -
                        [[newInventory valueForKey:ingredient] floatValue])
                  < acceptableError, @"Removing mixed recipe gave incorrect value for %@", ingredient);
    }
}


// Test nextDayOfWeek:
- (void)testNextDayOfWeek{
    // Sunday is the last thing in the enum, so test if we handle cycling correctly.
    
    DayOfWeek afterWednesday = [model nextDayOfWeek:Wednesday];
    XCTAssertEqual(Thursday, afterWednesday, @"Day of week after Thursday gave %d", afterWednesday);
    
    DayOfWeek afterSunday = [model nextDayOfWeek:Sunday];
    XCTAssertEqual(Monday, afterSunday, @"Day of week after Sunday gave %d", afterSunday);
}

@end
