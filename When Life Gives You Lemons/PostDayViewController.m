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

- (void)save
{
    NSDictionary *dataDictionary = [_dataStore convertToDictionary];
    
    NSLog(@"thing: %@", [dataDictionary valueForKey:@"price"]);
    
    NSError *error = nil;
    if ([NSJSONSerialization isValidJSONObject:dataDictionary]){
        NSLog(@"Valid dictionary");
        NSData *json = [NSJSONSerialization dataWithJSONObject:dataDictionary options:NSJSONWritingPrettyPrinted error:&error];
        
        if (json != nil && error == nil)
        {
            NSLog(@"Valid JSON conversion.");
            //NSFileManager *fileManager = [NSFileManager defaultManager];
            NSString *savePath = [[NSBundle mainBundle] pathForResource:@"save1" ofType:@"json"];
            
            [json writeToFile:savePath atomically:YES];
            NSString *jsonString = [[NSString alloc] initWithData:json encoding:NSUTF8StringEncoding];
            
            NSLog(@"feedbackstring: %@", [dataDictionary valueForKey:@"feedback string"]);
            
            NSLog(@"JSON: %@", jsonString);
            //[jsonString release];
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
