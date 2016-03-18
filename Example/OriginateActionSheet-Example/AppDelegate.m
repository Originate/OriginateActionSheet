//
//  AppDelegate.m
//  OriginateActionSheet-Example
//
//  Created by Philip Kluz on 01/01/16.
//  Copyright © 2016 Originate Inc. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    ViewController *controller = [[ViewController alloc] init];
    controller.view.backgroundColor = [UIColor whiteColor];
    
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:controller];
    [self.window makeKeyAndVisible];
    
    return YES;
}

@end
