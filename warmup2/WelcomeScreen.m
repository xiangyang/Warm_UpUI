//
//  WelcomeScreen.m
//  warmup2
//
//  Created by Yang Xiang on 2/19/14.
//  Copyright (c) 2014 com.yangxiang. All rights reserved.
//

#import "WelcomeScreen.h"
#import "LoginScreen.h"
@interface WelcomeScreen ()

@end

@implementation WelcomeScreen

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
      
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    loginMessage.text = self.message;
    loginMessage.lineBreakMode = NSLineBreakByWordWrapping;
    loginMessage.numberOfLines = 0;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)logout:(id)sender {
    LoginScreen *login = [[LoginScreen alloc]  initWithNibName:nil bundle:nil];
    [self presentViewController:login animated:YES completion:NULL];
    
}

@end
