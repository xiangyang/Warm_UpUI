//
//  LoginScreen.m
//  warmup2
//
//  Created by Yang Xiang on 2/19/14.
//  Copyright (c) 2014 com.yangxiang. All rights reserved.
//

#import "LoginScreen.h"
#import "WelcomeScreen.h"

@interface LoginScreen ()

@end


@implementation LoginScreen

NSURL *rootURL = nil;

+ (void)initialize {
    if(!rootURL)
        rootURL = [NSURL URLWithString:@"http://evening-retreat-3153.herokuapp.com"];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    username.delegate = self;
    password.delegate = self;
    errorMessage.text = @"Please input your credentials below";
    errorMessage.lineBreakMode = NSLineBreakByWordWrapping;
    errorMessage.numberOfLines = 0;
    password.secureTextEntry = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [username resignFirstResponder];
    [password resignFirstResponder];
    return YES;
}

//Actions left for possible future implementation
-(IBAction)inputPassword:(id)sender {
    
}

-(IBAction)inputUsername:(id)sender {
    
}

-(IBAction)userAdd:(id)sender {
    //Initiate JSON Request
    
    NSURL *url = [rootURL URLByAppendingPathComponent:@"/users/add"];
    NSString *request = [NSString stringWithFormat: @"{\"user\": \"%@\", \"password\": \"%@\"}",username.text, password.text];
    
    NSMutableURLRequest *URLrequest = [[NSMutableURLRequest alloc] initWithURL:url];
    NSData *requestData = [NSData dataWithBytes:request.UTF8String length:request.length];
    
    [URLrequest setHTTPMethod:@"POST"];
    [URLrequest setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [URLrequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [URLrequest setValue:[NSString stringWithFormat:@"%i", requestData.length] forHTTPHeaderField:@"Content-Length"];
    [URLrequest setHTTPBody: requestData];
    
    NSError *error;
    NSURLResponse *response;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:URLrequest returningResponse:&response error:&error];
    NSDictionary *jsonResponse = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&error];
   
    switch ([[jsonResponse valueForKey:@"errCode"] integerValue])
    {
        case -2:
            errorMessage.text = @"This user name already exists. Please try again.";
            break;
        case -3:
            errorMessage.text = @"The user name should be non-empty and at most 128 characters long. Please try again.";
            break;
        case -4:
            errorMessage.text = @"The password should be at most 128 characters long. Please try again.";
            break;
        default:
        {
            int count = [[jsonResponse valueForKey:@"count"] integerValue];
            WelcomeScreen *welcome = [[WelcomeScreen alloc]  initWithNibName:nil bundle:nil];
            welcome.message = [NSString stringWithFormat:@"Welcome %@ you have logged in %i times", username.text, count];
            [self presentViewController:welcome animated:YES completion:NULL];
            break;
        }
    }
}

-(IBAction)userLogin:(id)sender {
    //Initiate JSON Request

    NSURL *url = [rootURL URLByAppendingPathComponent:@"/users/login"];

    NSString *request = [NSString stringWithFormat: @"{\"user\": \"%@\", \"password\": \"%@\"}",username.text, password.text];
    
    NSMutableURLRequest *URLrequest = [[NSMutableURLRequest alloc] initWithURL:url];
    NSData *requestData = [NSData dataWithBytes:request.UTF8String length:request.length];
    
    [URLrequest setHTTPMethod:@"POST"];
    [URLrequest setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [URLrequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [URLrequest setValue:[NSString stringWithFormat:@"%i", requestData.length] forHTTPHeaderField:@"Content-Length"];
    [URLrequest setHTTPBody: requestData];

    NSError *error;
    NSURLResponse *response;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:URLrequest returningResponse:&response error:&error];
    NSDictionary *jsonResponse = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&error];
    
    if ([[jsonResponse valueForKey:@"errCode"] integerValue] == -1) {
        errorMessage.text = @"Invalid username and password combination. Please try again.";
    } else {
        int count = [[jsonResponse valueForKey:@"count"] integerValue];
        WelcomeScreen *welcome = [[WelcomeScreen alloc]  initWithNibName:nil bundle:nil];
        welcome.message = [NSString stringWithFormat:@"Welcome %@ you have logged in %i times", username.text, count];
        [self presentViewController:welcome animated:YES completion:NULL];
    }
    
}

@end
