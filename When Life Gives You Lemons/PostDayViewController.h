//
//  PostDayViewController.h
//  When Life Gives You Lemons
//
//  Created by jarthurcs on 10/21/14.
//  Copyright (c) 2014 Jonathan Finnell, Amit Maor, Joshua Petrack, Megan Shao, Rachel Wilson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataStore.h"

@interface PostDayViewController : UIViewController

@property (nonatomic, weak) IBOutlet UIButton *goToPreDayButton;

- (void) setDataStore:(DataStore*) dataStore;

@end
