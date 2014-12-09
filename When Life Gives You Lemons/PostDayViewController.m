//
//  PostDayViewController.m
//  When Life Gives You Lemons
//
//  Created by jarthurcs on 10/21/14.
//  Copyright (c) 2014 Jonathan Finnell, Amit Maor, Joshua Petrack, Megan Shao, Rachel Wilson. All rights reserved.
//

#import "PostDayViewController.h"
#import "PostDayView.h"

@interface PostDayViewController () {
    DataStore *_dataStore;
    PostDayView *_postDayView;
}
@end

@implementation PostDayViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Create the PostDay View
    CGRect frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame));
    _postDayView = [[PostDayView alloc] initWithFrame:frame andDataStore:_dataStore];
    [self.view addSubview:_postDayView];
    
    [self.view bringSubviewToFront:_goToPreDayButton];
    [self.view bringSubviewToFront:_quitGameButton];
    [self save];
}

- (void)setDataStore:(DataStore *) dataStore
{
    _dataStore = dataStore;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"PostDayToMenu"])
    {
        ;
    }
}

- (NSURL *)applicationDocumentsDirectory {
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory
                                                   inDomains:NSUserDomainMask] lastObject];
}

- (void)save
{
    NSDictionary *dataDictionary = [_dataStore convertToDictionary];
    
    NSError *error = nil;
    if ([NSJSONSerialization isValidJSONObject:dataDictionary]){
        NSData *json = [NSJSONSerialization dataWithJSONObject:dataDictionary options:NSJSONWritingPrettyPrinted error:&error];
        
        if (json != nil && error == nil) {
            NSString *savePath = [[self applicationDocumentsDirectory].path
                              stringByAppendingPathComponent:@"save1.json"];
            NSError *error;
            [json writeToFile:savePath options:kNilOptions error:&error];
        }
        
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
