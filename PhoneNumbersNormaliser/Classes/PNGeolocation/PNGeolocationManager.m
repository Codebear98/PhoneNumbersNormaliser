//
//  PNGeolocationManager.m
//  PhoneNumbersNormaliser
//
//  Created by Henry Hong on 14/2/16.
//  Copyright © 2016 Henry Hong. All rights reserved.
//

#import "PNGeolocationManager.h"
#import "PNGeolocationManager+Internal.h"

#import <UIKit/UIKit.h>

@implementation PNGeolocationManager

+ (instancetype)sharedInstance
{

	static PNGeolocationManager * _sharedInstance = nil;
	static dispatch_once_t onceToken;

	dispatch_once(&onceToken, ^{
		_sharedInstance = [[PNGeolocationManager alloc] init];
	});

	return _sharedInstance;
}

- (instancetype)init
{
	self = [super init];
	if (self) {

		_locationManager = [[CLLocationManager alloc] init];
		_locationManager.delegate = self;
		_locationManager.distanceFilter = kCLDistanceFilterNone;
		_locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;

		if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {

			[self.locationManager requestWhenInUseAuthorization];
		}
	}

	return self;
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager
	 didUpdateLocations:(NSArray<CLLocation * > *)locations
{
	if (locations.count > 0) {
		self.currentDetectedLocation = [locations lastObject];
		NSLog(@"DetectedLocation updated: %@", self.currentDetectedLocation);
		[self notifyWithResult];
	}
}

- (void)locationManager:(CLLocationManager *)manager
	   didFailWithError:(NSError *)error
{

	NSLog(@"Location updated failed: %@", error);
	[self notifyWithResult];
}

- (void)requestLocation:(nullable PNGeolocationManagerResult)resultCallback
{

	self.resultCallback = resultCallback;
	[_locationManager requestLocation];
}

- (void)notifyWithResult
{
	if (self.resultCallback) {
		self.resultCallback(_currentDetectedLocation);
		self.resultCallback = nil;
	}
}

@end
