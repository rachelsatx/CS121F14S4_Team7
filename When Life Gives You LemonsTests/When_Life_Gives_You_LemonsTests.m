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
#import "NumberWithTwoDecimals.h"

@interface When_Life_Gives_You_LemonsTests : XCTestCase

@end

@implementation When_Life_Gives_You_LemonsTests


Model *model;
NumberWithTwoDecimals* five;
NumberWithTwoDecimals* four;
NumberWithTwoDecimals* one;
NumberWithTwoDecimals* zero;
- (void)setUp
{
    [super setUp];
    model = [[Model alloc] init];
    five = [[NumberWithTwoDecimals alloc] initWithFloat:5.0];
    four = [[NumberWithTwoDecimals alloc] initWithFloat:4.0];
    one = [[NumberWithTwoDecimals alloc] initWithFloat:1.0];
    zero = [[NumberWithTwoDecimals alloc] initWithFloat:0.0];
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}



/*
 * Test Model
 */

// Test simulateDayWithDataStore:
- (void)testSimulateDayWithEmptyInventory{
    DataStore* dataStore = [[DataStore alloc] init];
    DayOfWeek beforeDay = dataStore.getDayOfWeek;
    NSDictionary* beforeInventory = dataStore.getInventory;
    NumberWithTwoDecimals* beforeMoney = dataStore.getMoney;
    
    DataStore* newDataStore = [model simulateDayWithDataStore:dataStore];
    DayOfWeek afterDay = newDataStore.getDayOfWeek;
    NSDictionary* afterInventory = newDataStore.getInventory;
    NumberWithTwoDecimals* afterMoney = newDataStore.getMoney;
    
    XCTAssertEqual(afterDay, beforeDay + 1, @"We went from %d to %d", beforeDay, afterDay);
    XCTAssertEqual(afterInventory, beforeInventory, @"Inventory changed when there were initially no ingredients");

    
    XCTAssertEqual(newDataStore.getCupsSold, 0, @"Sold %ld cups of lemonade without having any ingredients", (long)newDataStore.getCupsSold);
    XCTAssertEqual([afterMoney floatValue], [beforeMoney floatValue], @"Money increased from %0.2f to %0.2f without selling any lemonade", [beforeMoney floatValue], [afterMoney floatValue]);
    XCTAssertEqual(newDataStore.getPopularity, 0, @"Popularity increased from 0 to %ld without selling any lemonade", (long)newDataStore.getPopularity);
    XCTAssertEqual([newDataStore.getProfit floatValue], 0, @"Earned $%0.2f without selling any lemonade", [newDataStore.getProfit floatValue]);
}

- (void)testSimulateDayWithOverMaxPrice{
    DataStore* dataStore = [[DataStore alloc] init];
    [dataStore setPrice:[[NumberWithTwoDecimals alloc] initWithFloat:6.0]];
    DayOfWeek beforeDay = dataStore.getDayOfWeek;
    NSDictionary* beforeInventory = dataStore.getInventory;
    NumberWithTwoDecimals* beforeMoney = dataStore.getMoney;
    
    DataStore* newDataStore = [model simulateDayWithDataStore:dataStore];
    DayOfWeek afterDay = newDataStore.getDayOfWeek;
    NSDictionary* afterInventory = newDataStore.getInventory;
    NumberWithTwoDecimals* afterMoney = newDataStore.getMoney;
    
    XCTAssertEqual(afterDay, beforeDay + 1, @"We went from %d to %d", beforeDay, afterDay);
    XCTAssertEqual(afterInventory, beforeInventory, @"Inventory changed when there were initially no ingredients");
    
    XCTAssertEqual(newDataStore.getCupsSold, 0, @"Sold %ld cups of lemonade when the price was set above the maximum customers would pay", (long)newDataStore.getCupsSold);
    XCTAssertEqual([afterMoney floatValue], [beforeMoney floatValue], @"Money increased from %0.2f to %0.2f without selling any lemonade", [beforeMoney floatValue], [afterMoney floatValue]);
    XCTAssertEqual(newDataStore.getPopularity, 0, @"Popularity increased from 0 to %ld without selling any lemonade", (long)newDataStore.getPopularity);
    XCTAssertEqual([newDataStore.getProfit floatValue], 0, @"Earned $%@ without selling any lemonade", newDataStore.getProfit);
}

- (void)testSimulateDayWithReasonableInputs{
    DataStore* dataStore = [[DataStore alloc] init];
    NumberWithTwoDecimals* numIngredients = [[NumberWithTwoDecimals alloc] initWithFloat:100.0];
    NumberWithTwoDecimals* lemonAmount = [[NumberWithTwoDecimals alloc] initWithFloat:.2];
    NumberWithTwoDecimals* sugarAmount = [[NumberWithTwoDecimals alloc] initWithFloat:.15];
    NumberWithTwoDecimals* iceAmount = [[NumberWithTwoDecimals alloc] initWithFloat:.15];
    NumberWithTwoDecimals* waterAmount = [[NumberWithTwoDecimals alloc] initWithFloat:.5];
    
    NSMutableDictionary* beforeInventory      = [[NSMutableDictionary alloc] initWithObjects:
                                              @[numIngredients,      numIngredients,     numIngredients,   numIngredients] forKeys:
                                              @[@"lemons", @"sugar", @"ice", @"cups"]];
    [dataStore setInventory:beforeInventory];
    NSMutableDictionary* recipe               = [[NSMutableDictionary alloc] initWithObjects:
                                              @[lemonAmount,sugarAmount,iceAmount,waterAmount] forKeys:
                                              @[@"lemons", @"sugar", @"ice", @"water"]];
    [dataStore setRecipe:recipe];
    DayOfWeek beforeDay = dataStore.getDayOfWeek;
    NumberWithTwoDecimals* beforeMoney = dataStore.getMoney;
    
    DataStore* newDataStore = [model simulateDayWithDataStore:dataStore];
    DayOfWeek afterDay = newDataStore.getDayOfWeek;
    NSDictionary* afterInventory = newDataStore.getInventory;
    NumberWithTwoDecimals* afterMoney = newDataStore.getMoney;
    
    XCTAssertEqual(afterDay, beforeDay + 1, @"We went from %d to %d", beforeDay, afterDay);
    for (NSString* ingredient in [beforeInventory allKeys]) {
        if (![ingredient isEqual:@"cups"]) {
            XCTAssertTrue([[afterInventory valueForKey:ingredient] floatValue] < [numIngredients floatValue], @"Ingredient %@ did not decrease in inventory even though lemonade was sold", ingredient);
        }
    }
    
    XCTAssertTrue(newDataStore.getCupsSold > 0, @"No lemonade sold with good recipe and stocked inventory");
    XCTAssertTrue([afterMoney floatValue] > [beforeMoney floatValue], @"Lemonade was sold but money did not increase");
    XCTAssertTrue(newDataStore.getPopularity > 0, @"Popularity did not increase after selling good lemonade: was %ld", (long)newDataStore.getPopularity);
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


// Test mostCupsMakeableFromInventory:
- (void)testCorrectCupsFromInventory0{
    NSMutableDictionary *inventory         = [[NSMutableDictionary alloc] initWithObjects:
                                              @[five,      five,     five,   five    ] forKeys:
                                              @[@"lemons", @"sugar", @"ice", @"cups"]];
    
    NSMutableDictionary *recipe            = [[NSMutableDictionary alloc] initWithObjects:
                                              @[one, zero, zero, zero] forKeys:
                                              @[@"lemons", @"sugar", @"ice", @"water"]];
    
    int correctCups = 5;
    int calculatedCups = [model mostCupsMakableFromInventory:inventory withRecipe:recipe];
    XCTAssertEqual(correctCups, calculatedCups, @"Model thinks it can make %i cups", calculatedCups);
}

- (void)testCorrectCupsFromInventory1{
    NumberWithTwoDecimals* startingCups = [[NumberWithTwoDecimals alloc] initWithFloat:25.0];
    NumberWithTwoDecimals* pctWater = [[NumberWithTwoDecimals alloc] initWithFloat:0.4];
    NumberWithTwoDecimals* pctOther = [[NumberWithTwoDecimals alloc] initWithFloat:0.2];
    NSMutableDictionary *inventory         = [[NSMutableDictionary alloc] initWithObjects:
                                              @[five,five,five,startingCups] forKeys:
                                              @[@"lemons", @"sugar", @"ice", @"cups"]];
    
    NSMutableDictionary *recipe            = [[NSMutableDictionary alloc] initWithObjects:
                                              @[pctOther, pctOther, pctOther, pctWater] forKeys:
                                              @[@"lemons", @"sugar", @"ice", @"water"]];
    
    int correctCups = 25;
    int calculatedCups = [model mostCupsMakableFromInventory:inventory withRecipe:recipe];
    XCTAssertEqual(correctCups, calculatedCups, @"Model thinks it can make %i cups", calculatedCups);
}

- (void)testCorrectCupsFromInventory2{
    NumberWithTwoDecimals* startingCups = [[NumberWithTwoDecimals alloc] initWithFloat:500.0];
    NSMutableDictionary *inventory         = [[NSMutableDictionary alloc] initWithObjects:
                                              @[five,five,five,startingCups    ] forKeys:
                                              @[@"lemons", @"sugar", @"ice", @"cups"]];
    
    NSMutableDictionary *recipe            = [[NSMutableDictionary alloc] initWithObjects:
                                              @[zero, zero, zero, one] forKeys:
                                              @[@"lemons", @"sugar", @"ice", @"water"]];
    
    int correctCups = 500;
    int calculatedCups = [model mostCupsMakableFromInventory:inventory withRecipe:recipe];
    XCTAssertEqual(correctCups, calculatedCups, @"Model thinks it can make %i cups", calculatedCups);
}

- (void)testCorrectCupsFromInventory3{
    NSMutableDictionary *inventory         = [[NSMutableDictionary alloc] initWithObjects:
                                              @[zero,five,five,five] forKeys:
                                              @[@"lemons", @"sugar", @"ice", @"cups"]];
    
    NSMutableDictionary *recipe            = [[NSMutableDictionary alloc] initWithObjects:
                                              @[one, zero, zero, zero] forKeys:
                                              @[@"lemons", @"sugar", @"ice", @"water"]];
    
    int correctCups = 0;
    int calculatedCups = [model mostCupsMakableFromInventory:inventory withRecipe:recipe];
    XCTAssertEqual(correctCups, calculatedCups, @"Model thinks it can make %i cups", calculatedCups);
}


// Test calculateNewPopularityWithNumCustomers:
- (void)testNoPopularityIncrease{
    int totalCustomers = 40;
    float portionWhoBought = 0.0;
    float portionWhoLiked = 0.0;
    NSInteger oldPopularity = 0;
    
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
                                              @[five,      five,     five,  five] forKeys:
                                              @[@"lemons", @"sugar", @"ice", @"cups"]];
    
    NSMutableDictionary *expectedInventory = [[NSMutableDictionary alloc] initWithObjects:
                                              @[four,      five,     five,   four] forKeys:
                                              @[@"lemons", @"sugar", @"ice", @"cups"]];
    
    NSMutableDictionary *recipe            = [[NSMutableDictionary alloc] initWithObjects:
                                              @[one,     zero,     zero,   zero] forKeys:
                                              @[@"lemons", @"sugar", @"ice", @"water"]];
    
    NSMutableDictionary *newInventory = [model removeIngredientsOfRecipe:recipe fromInventory:inventory];
    
    XCTAssertEqualObjects(newInventory, expectedInventory,
                          @"Removing recipe of all lemons from inventory gave incorrect result");
}

- (void)testRemoveIngredientsAllWater{
    NSMutableDictionary *inventory         = [[NSMutableDictionary alloc] initWithObjects:
                                              @[five,      five,     five,   five] forKeys:
                                              @[@"lemons", @"sugar", @"ice", @"cups"]];
    
    NSMutableDictionary *expectedInventory = [[NSMutableDictionary alloc] initWithObjects:
                                              @[five,      five,     five,   four] forKeys:
                                              @[@"lemons", @"sugar", @"ice", @"cups"]];
    
    NSMutableDictionary *recipe            = [[NSMutableDictionary alloc] initWithObjects:
                                              @[zero,      zero,     zero,   one] forKeys:
                                              @[@"lemons", @"sugar", @"ice", @"water"]];
    
    NSMutableDictionary *newInventory = [model removeIngredientsOfRecipe:recipe fromInventory:inventory];
    
    XCTAssertEqualObjects(newInventory, expectedInventory,
                          @"Removing recipe of all water from inventory gave incorrect result");
}

- (void)testRemoveIngredientsMixedRecipe{
    NumberWithTwoDecimals* n485 = [[NumberWithTwoDecimals alloc] initWithFloat:4.85];
    NumberWithTwoDecimals* n490 = [[NumberWithTwoDecimals alloc] initWithFloat:4.90];
    NumberWithTwoDecimals* n480 = [[NumberWithTwoDecimals alloc] initWithFloat:4.80];
    NumberWithTwoDecimals* n015 = [[NumberWithTwoDecimals alloc] initWithFloat:0.15];
    NumberWithTwoDecimals* n010 = [[NumberWithTwoDecimals alloc] initWithFloat:0.10];
    NumberWithTwoDecimals* n020 = [[NumberWithTwoDecimals alloc] initWithFloat:0.20];
    NumberWithTwoDecimals* n055 = [[NumberWithTwoDecimals alloc] initWithFloat:0.55];
    
    NSMutableDictionary *inventory         = [[NSMutableDictionary alloc] initWithObjects:
                                              @[five,      five,     five,   five] forKeys:
                                              @[@"lemons", @"sugar", @"ice", @"cups"]];
    
    NSMutableDictionary *expectedInventory = [[NSMutableDictionary alloc] initWithObjects:
                                              @[n485,      n490,     n480,   four] forKeys:
                                              @[@"lemons", @"sugar", @"ice", @"cups"]];
    
    NSMutableDictionary *recipe            = [[NSMutableDictionary alloc] initWithObjects:
                                              @[n015,      n010,     n020,   n055] forKeys:
                                              @[@"lemons", @"sugar", @"ice", @"water"]];
    
    NSMutableDictionary *newInventory = [model removeIngredientsOfRecipe:recipe fromInventory:inventory];
    
    // Test that each ingredient is within acceptable floating-point deviation from what is expected.
    
    XCTAssertEqualObjects(newInventory, expectedInventory,
                          @"Removing mixed recipe gave incorrect result");
}


// Test nextDayOfWeek:
- (void)testNextDayOfWeek{
    // Sunday is the last thing in the enum, so test if we handle cycling correctly.
    
    DayOfWeek afterWednesday = [model nextDayOfWeek:Wednesday];
    XCTAssertEqual(Thursday, afterWednesday, @"Day of week after Thursday gave %d", afterWednesday);
    
    DayOfWeek afterSunday = [model nextDayOfWeek:Sunday];
    XCTAssertEqual(Monday, afterSunday, @"Day of week after Sunday gave %d", afterSunday);
}



/*
 * Test NumberWithTwoDecimals
 */

- (void) testIsEqual{
    NumberWithTwoDecimals* x = [[NumberWithTwoDecimals alloc] initWithIntegerPart:3 andFractionalPart:14];
    NumberWithTwoDecimals* y = [[NumberWithTwoDecimals alloc] initWithIntegerPart:3 andFractionalPart:14];
    XCTAssert([x isEqual:y] && [y isEqual:x], @"%d.%d is not equal to %d.%d", [x integerPart], [x fractionalPart], [y integerPart], [y fractionalPart]);
}

- (void) testIsNotEqual{
    NumberWithTwoDecimals* x = [[NumberWithTwoDecimals alloc] initWithIntegerPart:3 andFractionalPart:14];
    NumberWithTwoDecimals* y = [[NumberWithTwoDecimals alloc] initWithIntegerPart:3 andFractionalPart:15];
    NumberWithTwoDecimals* z = [[NumberWithTwoDecimals alloc] initWithIntegerPart:4 andFractionalPart:14];
    XCTAssert([x isNotEqual:y] && [y isNotEqual:x], @"%d.%d is equal to %d.%d", [x integerPart], [x fractionalPart], [y integerPart], [y fractionalPart]);
    XCTAssert([y isNotEqual:z] && [z isNotEqual:y], @"%d.%d is equal to %d.%d", [y integerPart], [y fractionalPart], [z integerPart], [z fractionalPart]);
    XCTAssert([x isNotEqual:z] && [z isNotEqual:x], @"%d.%d is equal to %d.%d", [x integerPart], [x fractionalPart], [z integerPart], [z fractionalPart]);
}

- (void) testIsGreaterThan{
    NumberWithTwoDecimals* x = [[NumberWithTwoDecimals alloc] initWithIntegerPart:3 andFractionalPart:14];
    NumberWithTwoDecimals* y = [[NumberWithTwoDecimals alloc] initWithIntegerPart:3 andFractionalPart:15];
    NumberWithTwoDecimals* z = [[NumberWithTwoDecimals alloc] initWithIntegerPart:4 andFractionalPart:14];
    XCTAssert(![x isGreaterThan:y] && [y isGreaterThan:x], @"%d.%d is greater than %d.%d", [x integerPart], [x fractionalPart], [y integerPart], [y fractionalPart]);
    XCTAssert(![y isGreaterThan:z] && [z isGreaterThan:y], @"%d.%d is greater than %d.%d", [y integerPart], [y fractionalPart], [z integerPart], [z fractionalPart]);
    XCTAssert(![x isGreaterThan:z] && [z isGreaterThan:x], @"%d.%d is greater than %d.%d", [x integerPart], [x fractionalPart], [z integerPart], [z fractionalPart]);
}

- (void) testIsGreaterThanOrEqual{
    NumberWithTwoDecimals* w = [[NumberWithTwoDecimals alloc] initWithIntegerPart:3 andFractionalPart:14];
    NumberWithTwoDecimals* x = [[NumberWithTwoDecimals alloc] initWithIntegerPart:3 andFractionalPart:14];
    NumberWithTwoDecimals* y = [[NumberWithTwoDecimals alloc] initWithIntegerPart:3 andFractionalPart:15];
    NumberWithTwoDecimals* z = [[NumberWithTwoDecimals alloc] initWithIntegerPart:4 andFractionalPart:14];
    XCTAssert([w isGreaterThanOrEqual:x] && [x isGreaterThanOrEqual:w], @"%d.%d is not greater than or equal to %d.%d", [w integerPart], [w fractionalPart], [x integerPart], [x fractionalPart]);
    XCTAssert(![x isGreaterThanOrEqual:y] && [y isGreaterThanOrEqual:x], @"%d.%d is greater than or equal to %d.%d", [x integerPart], [x fractionalPart], [y integerPart], [y fractionalPart]);
    XCTAssert(![y isGreaterThanOrEqual:z] && [z isGreaterThanOrEqual:y], @"%d.%d is greater than or equal to %d.%d", [y integerPart], [y fractionalPart], [z integerPart], [z fractionalPart]);
    XCTAssert(![x isGreaterThanOrEqual:z] && [z isGreaterThanOrEqual:x], @"%d.%d is greater than or equal to %d.%d", [x integerPart], [x fractionalPart], [z integerPart], [z fractionalPart]);
}

- (void) testIsLessThan{
    NumberWithTwoDecimals* x = [[NumberWithTwoDecimals alloc] initWithIntegerPart:3 andFractionalPart:14];
    NumberWithTwoDecimals* y = [[NumberWithTwoDecimals alloc] initWithIntegerPart:3 andFractionalPart:15];
    NumberWithTwoDecimals* z = [[NumberWithTwoDecimals alloc] initWithIntegerPart:4 andFractionalPart:14];
    XCTAssert([x isLessThan:y] && ![y isLessThan:x], @"%d.%d is not less than %d.%d", [x integerPart], [x fractionalPart], [y integerPart], [y fractionalPart]);
    XCTAssert([y isLessThan:z] && ![z isLessThan:y], @"%d.%d is not less than %d.%d", [y integerPart], [y fractionalPart], [z integerPart], [z fractionalPart]);
    XCTAssert([x isLessThan:z] && ![z isLessThan:x], @"%d.%d is not less than %d.%d", [x integerPart], [x fractionalPart], [z integerPart], [z fractionalPart]);
}

- (void) testIsLessThanOrEqual{
    NumberWithTwoDecimals* w = [[NumberWithTwoDecimals alloc] initWithIntegerPart:3 andFractionalPart:14];
    NumberWithTwoDecimals* x = [[NumberWithTwoDecimals alloc] initWithIntegerPart:3 andFractionalPart:14];
    NumberWithTwoDecimals* y = [[NumberWithTwoDecimals alloc] initWithIntegerPart:3 andFractionalPart:15];
    NumberWithTwoDecimals* z = [[NumberWithTwoDecimals alloc] initWithIntegerPart:4 andFractionalPart:14];
    XCTAssert([w isLessThanOrEqual:x] && [x isLessThanOrEqual:w], @"%d.%d is not less than or equal to %d.%d", [w integerPart], [w fractionalPart], [x integerPart], [x fractionalPart]);
    XCTAssert([x isLessThanOrEqual:y] && ![y isLessThanOrEqual:x], @"%d.%d is not less than or equal to %d.%d", [x integerPart], [x fractionalPart], [y integerPart], [y fractionalPart]);
    XCTAssert([y isLessThanOrEqual:z] && ![z isLessThanOrEqual:y], @"%d.%d is not less than or equal to %d.%d", [y integerPart], [y fractionalPart], [z integerPart], [z fractionalPart]);
    XCTAssert([x isLessThanOrEqual:z] && ![z isLessThanOrEqual:x], @"%d.%d is not less than or equal to %d.%d", [x integerPart], [x fractionalPart], [z integerPart], [z fractionalPart]);
}

- (void) testAdd{
    NumberWithTwoDecimals* one = [[NumberWithTwoDecimals alloc] initWithIntegerPart:5 andFractionalPart:40];
    NumberWithTwoDecimals* two = [[NumberWithTwoDecimals alloc] initWithIntegerPart:5 andFractionalPart:50];
    NumberWithTwoDecimals* three = [[NumberWithTwoDecimals alloc] initWithIntegerPart:5 andFractionalPart:60];
    NumberWithTwoDecimals* onePlusTwo = [[NumberWithTwoDecimals alloc] initWithIntegerPart:10 andFractionalPart:90];
    NumberWithTwoDecimals* twoPlusThree = [[NumberWithTwoDecimals alloc] initWithIntegerPart:11 andFractionalPart:10];
    XCTAssert([onePlusTwo isEqual:[one add:two]] && [onePlusTwo isEqual:[two add:one]], @"%d.%d plus %d.%d did not equal %d.%d", [one integerPart], [one fractionalPart], [two integerPart], [two fractionalPart], [onePlusTwo integerPart], [onePlusTwo fractionalPart]);
    XCTAssert([twoPlusThree isEqual:[two add:three]] && [twoPlusThree isEqual:[three add:two]], @"%d.%d plus %d.%d did not equal %d.%d", [two integerPart], [two fractionalPart], [three integerPart], [three fractionalPart], [twoPlusThree integerPart], [twoPlusThree fractionalPart]);
}

- (void) testSubtract{
    NumberWithTwoDecimals* one = [[NumberWithTwoDecimals alloc] initWithIntegerPart:5 andFractionalPart:40];
    NumberWithTwoDecimals* two = [[NumberWithTwoDecimals alloc] initWithIntegerPart:5 andFractionalPart:50];
    NumberWithTwoDecimals* three = [[NumberWithTwoDecimals alloc] initWithIntegerPart:5 andFractionalPart:60];
    NumberWithTwoDecimals* onePlusTwo = [[NumberWithTwoDecimals alloc] initWithIntegerPart:10 andFractionalPart:90];
    NumberWithTwoDecimals* twoPlusThree = [[NumberWithTwoDecimals alloc] initWithIntegerPart:11 andFractionalPart:10];
    XCTAssert([two isEqual:[onePlusTwo subtract:one]] && [one isEqual:[onePlusTwo subtract:two]], @"%d.%d minus %d.%d did not equal %d.%d", [onePlusTwo integerPart], [onePlusTwo fractionalPart], [one integerPart], [one fractionalPart], [two integerPart], [two fractionalPart]);
    XCTAssert([three isEqual:[twoPlusThree subtract:two]] && [two isEqual:[twoPlusThree subtract:three]], @"%d.%d minus %d.%d did not equal %d.%d", [twoPlusThree integerPart], [twoPlusThree fractionalPart], [two integerPart], [two fractionalPart], [three integerPart], [three fractionalPart]);
}

- (void) testScale{
    NumberWithTwoDecimals* one = [[NumberWithTwoDecimals alloc] initWithIntegerPart:1 andFractionalPart:20];
    NumberWithTwoDecimals* two = [[NumberWithTwoDecimals alloc] initWithIntegerPart:2 andFractionalPart:40];
    XCTAssert([two isEqual:[one scale:2]], @"%d.%d times 2 did not equal %d.%d", [one integerPart], [one fractionalPart], [two integerPart], [two fractionalPart]);
}

@end
