//
//  AppDelegate.m
//  PhoneNumbersNormaliser
//
//  Created by Henry Hong on 13/2/16.
//  Copyright © 2016 Henry Hong. All rights reserved.
//

#import "AppDelegate.h"

#import "PNPhoneBookViewController.h"
#import "PNPhoneBook.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
	// Override point for customization after application launch.

	// dummy data
	[[PNPhoneBook sharedInstance] addPhoneNumber:@"+852 56232322"];		  // random mobile
	[[PNPhoneBook sharedInstance] addPhoneNumber:@"+852 92136233"];		  // random mobile
	[[PNPhoneBook sharedInstance] addPhoneNumber:@"+852 62136233"];		  // random mobile
	[[PNPhoneBook sharedInstance] addPhoneNumber:@"+852 22136233"];		  // random fixed line
	[[PNPhoneBook sharedInstance] addPhoneNumber:@"+852 12136233"];		  // invalid number
	[[PNPhoneBook sharedInstance] addPhoneNumber:@"56232322"];		      // random mobile without country code
	[[PNPhoneBook sharedInstance] addPhoneNumber:@"22136230"];			  // without country code
	[[PNPhoneBook sharedInstance] addPhoneNumber:@"92136233"];			  // without country code
	[[PNPhoneBook sharedInstance] addPhoneNumber:@"9213623"];			  // invalid number
	[[PNPhoneBook sharedInstance] addPhoneNumber:@"+442071234567"];		  // no space
	[[PNPhoneBook sharedInstance] addPhoneNumber:@"+44 2  0 71234 56 7"]; // random spaces
	[[PNPhoneBook sharedInstance] addPhoneNumber:@"+44 10 7123 4567"];	  // invalid number
	[[PNPhoneBook sharedInstance] addPhoneNumber:@"44 20 7123 4567"];	  // without + for UK
	[[PNPhoneBook sharedInstance] addPhoneNumber:@"+44 7700 900344"];	  // UK mobile
	[[PNPhoneBook sharedInstance] addPhoneNumber:@"+44 3069 990840"];	  // UK fixed line
	[[PNPhoneBook sharedInstance] addPhoneNumber:@"+1-202-555-0161"];	  // US fixed line
	[[PNPhoneBook sharedInstance] addPhoneNumber:@"1-202555-0-161"];	  // without + for US
	[[PNPhoneBook sharedInstance] addPhoneNumber:@"1-a2b0c2d5e550161"];   // with letters
	[[PNPhoneBook sharedInstance] addPhoneNumber:@"202555-0-161"];		  // without country code


	self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[PNPhoneBookViewController new]];

	return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
	// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
	// Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
	// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
	// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
	// Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
	// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
	// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
