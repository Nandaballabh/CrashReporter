//
//  NBCrashReporter.m
//  Shopsicle
//
//  Created by Nanda Ballabh on 27/08/14.
//  Copyright (c) 2014 mulu. All rights reserved.
//

#import "NBCrashReporter.h"

#define kCrashLogDataKey @"CrashLogDataKey"
#define kCrashLogAlertKey @"kCrashLogAlertKey"

NS_ENUM(NSInteger, AlertButtonType)
{
    UIAlertViewCancelButton = 0,
    UIAlertViewOKButton
};

void addCrashReporter(NSException *exception) {
  
    NSString *appBuildVersion = [[[NSBundle mainBundle]infoDictionary]valueForKey:@"CFBundleVersion"];
    NSString *appVersion = [[[NSBundle mainBundle]infoDictionary]valueForKey:@"CFBundleShortVersionString"];
    NSString * appName = [[[NSBundle mainBundle]infoDictionary]valueForKey:@"CFBundleDisplayName"];
    NSArray *stack = [exception callStackSymbols];

    // Create exception dictionary
    NSString *description = [NSString stringWithFormat:@"*** Terminating app due to uncaught exception:%@ , Reasone: %@",exception.name,exception.reason];
   
    NSDictionary * crashLog = @{
                                @"Description":description,
                                @"AppName":appName,
                                @"Version":appVersion,
                                @"Build":appBuildVersion,
                                @"Time":[NSDate date],
                                @"ExceptionName":exception.name,
                                @"ExceptionReason":exception.reason,
                                @"ExceptionCallStack":stack
                                };
    NSData *crashData = [NSKeyedArchiver archivedDataWithRootObject:crashLog];
    // Now save this string and show alert at launch for asking do you want to send crash log
    
    [[NSUserDefaults standardUserDefaults] setObject:crashData forKey:kCrashLogDataKey];
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:kCrashLogAlertKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


@implementation NBCrashReporter

static NBCrashReporter *_instance = nil;

+(NBCrashReporter*)initializeReporter {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        if(_instance == nil)
            _instance = [[NBCrashReporter alloc]init];

    });
    
    return _instance;
}

-(id)init {
    self = [super init];
    if(self) {
        
        NSSetUncaughtExceptionHandler(&addCrashReporter);
        //[self checkForCrashLogAlert];
        
      }
    return self;
}

-(void)checkForCrashLogAlert {
    BOOL showAlert = [[NSUserDefaults standardUserDefaults]boolForKey:kCrashLogAlertKey];
    if(showAlert) {
        [self performSelector:@selector(showAlertToSendCrashReport) withObject:nil afterDelay:1.0f];
    }
}


-(void)showAlertToSendCrashReport {
    
    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Crash!!" message:@"Send these crash log to help developer to improve the app" delegate:self cancelButtonTitle:@"Send" otherButtonTitles:@"Cancel", nil];
    
    // Show alertview on main queue
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [alert show];
        
    });
   
}

#pragma mark UIAlertView Delegate Method 

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    [self clearSavedCrashLog];
    switch (buttonIndex) {
            
        case UIAlertViewCancelButton:
            [alertView dismissWithClickedButtonIndex:buttonIndex animated:YES];
            break;
            
        case UIAlertViewOKButton:
                [self sendCrashReport];
            break;
        default:
            break;
    }
}

-(void)sendCrashReport {
    
    // Need to implement
    NSData *data = [[NSUserDefaults standardUserDefaults]objectForKey:kCrashLogDataKey];
    NSDictionary *crashData = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    NSLog(@"%@",crashData);
}

-(void)clearSavedCrashLog {
    
    [[NSUserDefaults standardUserDefaults]setObject:[NSData data] forKey:kCrashLogDataKey];
    [[NSUserDefaults standardUserDefaults]setBool:NO forKey:kCrashLogAlertKey];
    [[NSUserDefaults standardUserDefaults]synchronize];

}

@end

