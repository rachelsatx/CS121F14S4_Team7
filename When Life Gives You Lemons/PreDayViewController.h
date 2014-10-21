//
//  PreDayViewController.h
//  When Life Gives You Lemons
//
//  Created by Guest User on 10/20/14.
//  Copyright (c) 2014 Jonathan Finnell, Amit Maor, Joshua Petrack, Megan Shao, Rachel Wilson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataStore.h"

@interface PreDayViewController : UIViewController

@property (nonatomic, weak) IBOutlet UILabel* priceLabel;
@property (nonatomic, weak) IBOutlet UIButton* increasePrice;
@property (nonatomic, weak) IBOutlet UIButton* decreasePrice;

- (void) setDataStore:(DataStore*) dataStore;

@end

