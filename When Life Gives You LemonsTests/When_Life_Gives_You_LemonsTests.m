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
    DayOfWeek beforeDay = dataStore.getDayOfWeek;
    NSDictionary* beforeInventory = dataStore.getInventory;
    NSNumber* beforeMoney = dataStore.getMoney;
    
    DataStore* newDataStore = [model simulateDayWithDataStore:dataStore];
    DayOfWeek afterDay = newDataStore.getDayOfWeek;
    NSDictionary* afterInventory = newDataStore.getInventory;
    NSNumber* afterMoney = newDataStore.getMoney;
    
    XCTAssertEqual(afterDay, beforeDay + 1, @"We went from %d to %d", beforeDay, afterDay);
    XCTAssertEqual(afterInventory, beforeInventory, @"Inventory changed when there were initially no ingredients");

    
    XCTAssertEqual(newDataStore.getCupsSold, 0, @"Sold %d cups of lemonade without having any ingredients", newDataStore.getCupsSold);
    XCTAssertEqual([afterMoney floatValue], [beforeMoney floatValue], @"Money increased from %0.2f to %0.2f without selling any lemonade", [beforeMoney floatValue], [afterMoney floatValue]);
    XCTAssertEqual([newDataStore.getPopularity floatValue], 0, @"Popularity increased from 0 to %@ without selling any lemonade", newDataStore.getPopularity);
    XCTAssertEqual([newDataStore.getProfit floatValue], 0, @"Earned $%0.2f without selling any lemonade", [newDataStore.getProfit floatValue]);
}

- (void)testSimulateDayWithOverMaxPrice{
    DataStore* dataStore = [[DataStore alloc] init];
    [dataStore setPrice:[NSNumber numberWithInt:6]];
    DayOfWeek beforeDay = dataStore.getDayOfWeek;
    NSDictionary* beforeInventory = dataStore.getInventory;
    NSNumber* beforeMoney = dataStore.getMoney;
    
    DataStore* newDataStore = [model simulateDayWithDataStore:dataStore];
    DayOfWeek afterDay = newDataStore.getDayOfWeek;
    NSDictionary* afterInventory = newDataStore.getInventory;
    NSNumber* afterMoney = newDataStore.getMoney;
    
    XCTAssertEqual(afterDay, beforeDay + 1, @"We went from %d to %d", beforeDay, afterDay);
    XCTAssertEqual(afterInventory, beforeInventory, @"Inventory changed when there were initially no ingredients");
    
    XCTAssertEqual(newDataStore.getCupsSold, 0, @"Sold %d cups of lemonade when the price was set above the maximum customers would pay", newDataStore.getCupsSold);
    XCTAssertEqual([afterMoney floatValue], [beforeMoney floatValue], @"Money increased from %0.2f to %0.2f without selling any lemonade", [beforeMoney floatValue], [afterMoney floatValue]);
    XCTAssertEqual([newDataStore.getPopularity floatValue], 0, @"Popularity increased from 0 to %@ without selling any lemonade", newDataStore.getPopularity);
    XCTAssertEqual([newDataStore.getProfit floatValue], 0, @"Earned $%@ without selling any lemonade", newDataStore.getProfit);
}

- (void)testSimulateDayWithReasonableInputs{
    DataStore* dataStore = [[DataStore alloc] init];
    NSNumber* numIngredients = @20.00;
    NSMutableDictionary* beforeInventory      = [[NSMutableDictionary alloc] initWithObjects:
                                              @[numIngredients,      numIngredients,     numIngredients,   numIngredients] forKeys:
                                              @[@"lemons", @"sugar", @"ice", @"cups"]];
    [dataStore setInventory:beforeInventory];
    NSMutableDictionary* recipe               = [[NSMutableDictionary alloc] initWithObjects:
                                              @[@0.20,      @0.15,     @0.15,   @0.50] forKeys:
                                              @[@"lemons", @"sugar", @"ice", @"water"]];
    [dataStore setRecipe:recipe];
    DayOfWeek beforeDay = dataStore.getDayOfWeek;
    NSNumber* beforeMoney = dataStore.getMoney;
    
    DataStore* newDataStore = [model simulateDayWithDataStore:dataStore];
    DayOfWeek afterDay = newDataStore.getDayOfWeek;
    NSDictionary* afterInventory = newDataStore.getInventory;
    NSNumber* afterMoney = newDataStore.getMoney;
    
    XCTAssertEqual(afterDay, beforeDay + 1, @"We went from %d to %d", beforeDay, afterDay);
    for (NSString* ingredient in [beforeInventory allKeys]) {
        if (![ingredient isEqual:@"cups"]) {
            XCTAssertTrue([[afterInventory valueForKey:ingredient] floatValue] < [numIngredients floatValue], @"Ingredient %@ did not decrease in inventory even though lemonade was sold", ingredient);
        }
    }
    
    XCTAssertTrue(newDataStore.getCupsSold > 0, @"No lemonade sold with good recipe and stocked inventory");
    XCTAssertTrue([afterMoney floatValue] > [beforeMoney floatValue], @"Lemonade was sold but money did not increase");
    XCTAssertTrue([newDataStore.getPopularity floatValue] > 0, @"Popularity did not increase after selling good lemonade");
    XCTAssertTrue([newDataStore.getProfit floatValue] > 0, @"Lemonade sold but profit is 0");
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


// Test customersFromWeather:
- (void)testCustomersFromWeatherInvalidWeather{
    // We currently only have 3 types of weather
    Weather weather = 3;
    XCTAssertThrows([model customersFromWeather:weather],
                    @"Invalid weather did not throw error");
}


// Test customersFromWeekday:
- (void)testCustomersFromWeekdayInvalidDay{
    DayOfWeek day = 7;
    XCTAssertThrows([model customersFromWeekday:day],
                    @"Invalid day of week did not throw error");
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
