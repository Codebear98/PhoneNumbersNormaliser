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
		_locationManager.desiredAccuracy = kCLLocationAccuracyBest;

		_geocoder = [[CLGeocoder alloc]init];
		
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
		NSLog(@"Detected location: %@", _currentDetectedLocation);

		[self.geocoder reverseGeocodeLocation:self.currentDetectedLocation completionHandler:^(NSArray *placemarks, NSError *error) {
			NSLog(@"Finding address");
			if (error) {
				NSLog(@"Error %@", error.description);
			} else {

				self.currentPlacemark = [placemarks lastObject];
				NSLog(@"Detected placemark: %@", _currentPlacemark);
			}

			[self notifyWithResult];
		}];
	}
}

- (void)locationManager:(CLLocationManager *)manager
	   didFailWithError:(NSError *)error
{

	NSLog(@"Location updated failed: %@", error);
	[self notifyWithResult];
}

- (void)requestCurrentPlacemark:(nullable PNGeolocationManagerResult)resultCallback
{

	self.resultCallback = resultCallback;
	[_locationManager requestLocation];
}

- (void)notifyWithResult
{
	 if (self.resultCallback) {
		self.resultCallback(self.currentPlacemark);
		self.resultCallback = nil;
	}
}

@end
