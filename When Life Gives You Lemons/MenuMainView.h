//
//  MenuMainView.h
//  When Life Gives You Lemons
//
//  Created by jarthurcs on 11/16/14.
//  Copyright (c) 2014 Jonathan Finnell, Amit Maor, Joshua Petrack, Megan Shao, Rachel Wilson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>

@protocol MenuMainViewDelegate <NSObject>
@required
- (void)displayInstructions:(id)sender;
- (void)newGame:(id)sender;
@end


@interface MenuMainView : UIView
{
    id <MenuMainViewDelegate> _delegate;
}

@property (nonatomic,strong) id delegate;

@end
