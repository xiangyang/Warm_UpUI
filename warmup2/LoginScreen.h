//
//  LoginScreen.h
//  warmup2
//
//  Created by Yang Xiang on 2/19/14.
//  Copyright (c) 2014 com.yangxiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginScreen : UIViewController <UITextFieldDelegate>{
    IBOutlet UILabel *errorMessage;
    IBOutlet UITextField *username;
    IBOutlet UITextField *password;
    IBOutlet UIButton *loginButton;
    IBOutlet UIButton *addButton;
    IBOutlet UIButton *logoutButton;

}
    -(IBAction)inputPassword:(id)sender;
    -(IBAction)inputUsername:(id)sender;

    -(IBAction)userLogin:(id)sender;
    -(IBAction)userAdd:(id)sender;


@end
