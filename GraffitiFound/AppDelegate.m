//
//  AppDelegate.m
//  GraffitiFound
//
//  Created by Leonard Bogdonoff on 10/24/14.
//  Copyright (c) 2014 New Public Art Foundation. All rights reserved.
//


#import <TSMessage.h>
#import "Mixpanel.h"
#import "AppDelegate.h"
#import "NearbyListViewController.h"
#import "NearbyListWebViewController.h"
#import "LocationSettingsViewController.h"


#define MIXPANEL_TOKEN @"84d416fdfbfe20f78a60d04ab08cbc8c"

@interface AppDelegate ()

@end    

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  
    // Initialize the library with your
    // Mixpanel project token, MIXPANEL_TOKEN
    [Mixpanel sharedInstanceWithToken:MIXPANEL_TOKEN];
    
    // Later, you can get your instance with
    
    [[UIApplication sharedApplication]
     registerForRemoteNotificationTypes:
     (UIRemoteNotificationTypeBadge |
      UIRemoteNotificationTypeSound |
      UIRemoteNotificationTypeAlert)];
    
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    // 3. Set up the root view
    
    if(true){
        
        NearbyListViewController *lvc = [[NearbyListViewController alloc] initWithStyle:UITableViewStylePlain];
        
        UINavigationController *masterNav = [[UINavigationController alloc] initWithRootViewController:lvc];
        
        NearbyListWebViewController *wvc = [[NearbyListWebViewController alloc] init];
        lvc.webViewController = wvc;
        
        // Check to make sure we are running on iPad
        if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
            // webViewController must be in nvaigation controller; you will see why later
            UINavigationController *detailNav = [[UINavigationController alloc] initWithRootViewController:wvc];
            
            UISplitViewController *svc = [[UISplitViewController alloc] init];
            
            // Set the delegate of the split view controller to the detail VC
            // You will need this later - ignore the warning for now
            // svc.delegate = wvc;
            
            svc.viewControllers = @[masterNav, detailNav];
            
            // Set the root view controller of the window to the split view controller
            self.window.rootViewController = svc;
        } else {
            // On non-ipad devices, just use the navigation controller
            
            UITabBarController *tabBarController = [[UITabBarController alloc] init];
            tabBarController.viewControllers = @[masterNav];
            tabBarController.view.autoresizingMask=(UIViewAutoresizingFlexibleHeight);
            
            self.window.rootViewController = tabBarController;
            
            // self.window.rootViewController = masterNav;
        }

        
      
        self.window.backgroundColor = [UIColor whiteColor];
        [self.window makeKeyAndVisible];
    } else {
        
    }
    return YES;
}

- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:
(NSData *)deviceToken
{
    Mixpanel *mixpanel = [Mixpanel sharedInstance];
    [mixpanel.people addPushDeviceToken:deviceToken];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
