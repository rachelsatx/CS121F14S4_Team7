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
@property (nonatomic, weak) IBOutlet UIButton* increasePriceButton;
@property (nonatomic, weak) IBOutlet UIButton* decreasePriceButton;
@property (nonatomic, weak) IBOutlet UIImageView* weatherImage;
@property (nonatomic, weak) IBOutlet UIButton* infoViewButton;
@property (nonatomic, weak) IBOutlet UIButton* inventoryViewButton;
@property (nonatomic, weak) IBOutlet UIButton* recipesViewButton;


- (void) setDataStore:(DataStore*) dataStore;

@end

