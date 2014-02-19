//
//  WelcomeScreen.h
//  warmup2
//
//  Created by Yang Xiang on 2/19/14.
//  Copyright (c) 2014 com.yangxiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WelcomeScreen : UIViewController {
    IBOutlet UILabel *loginMessage;
}

-(IBAction)logout:(id)sender;

@property(nonatomic) NSString *message;

@end
