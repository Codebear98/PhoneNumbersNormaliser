//
//  PNGeolocationManagerSpec.m
//  PhoneNumbersNormaliser
//
//  Created by Henry Hong on 14/2/16.
//  Copyright © 2016 Henry Hong. All rights reserved.
//

#import <Kiwi/Kiwi.h>

#import "PNGeolocationManager.h"
#import "PNGeolocationManager+Internal.h"

#import "PNMacros.h"

SPEC_BEGIN(PNGeolocationManagerSpec)

describe(@"PNGeolocationManagerSpec", ^{

	__block PNGeolocationManager *geolocationManager = nil;

	__block CLLocationManager *mockCLLocationManagerAlloc = [CLLocationManager nullMock];
	__block CLLocationManager *mockCLLocationManager = [CLLocationManager nullMock];

	beforeEach(^{
		[CLLocationManager stub:@selector(alloc) andReturn:mockCLLocationManagerAlloc];
		[mockCLLocationManagerAlloc stub:@selector(init) andReturn:mockCLLocationManager];

	});

	describe(@"When initialising", ^{

		it(@"should not be nil", ^{
			geolocationManager = [PNGeolocationManager new];
			[[geolocationManager shouldNot] beNil];
		});

		it(@"should init CLLocationManager", ^{

			[[CLLocationManager should]receive:@selector(alloc)];
			[[mockCLLocationManagerAlloc should]receive:@selector(init)];

			[PNGeolocationManager new];
		});

		it(@"should ask user for granting geolocation access for iOS 8 or above", ^{

			if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
				[[mockCLLocationManager should]receive:@selector(requestWhenInUseAuthorization)];
			} else {
				[[mockCLLocationManager shouldNot]receive:@selector(requestWhenInUseAuthorization)];
			}

			[PNGeolocationManager new];
		});
	});

	describe(@"When making request for geolocation information", ^{

		it(@"should make a request a to CLLocationManager", ^{

			[[mockCLLocationManager should] receive:@selector(requestLocation)];

			[geolocationManager requestCurrentPlacemark:nil];
		});

		it(@"should trigger reverseGeocodeLocation when location is updated", ^{

			CLGeocoder *mockGeocoder = [CLGeocoder nullMock];
			[geolocationManager stub:@selector(geocoder) andReturn:mockGeocoder];
			
			[[mockGeocoder should]receive:@selector(reverseGeocodeLocation:completionHandler:)];
			
			CLLocation *mockCLLocation = [CLLocation nullMock];
			[geolocationManager locationManager:mockCLLocationManager didUpdateLocations:@[mockCLLocation]];

		});

		it(@"should still notify to callback when location is failed to update", ^{

			[[geolocationManager should]receive:@selector(notifyWithResult)];

			[geolocationManager locationManager:mockCLLocationManager didFailWithError:[NSError nullMock]];
		});


		it(@"should return detected location object if notifyWithResult is trigger", ^{

			__block CLPlacemark *mockCLPlacemark = [CLPlacemark nullMock];
			__block CLPlacemark *returnPlacemark = nil;

			[geolocationManager stub:@selector(currentPlacemark) andReturn:mockCLPlacemark];

			[geolocationManager requestCurrentPlacemark:^(CLPlacemark *_Nullable placemark) {

				returnPlacemark = placemark;
			}];

			// Delay execution of my block for 1 seconds.
			dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
				[geolocationManager notifyWithResult];
			});

			[[expectFutureValue(returnPlacemark) shouldEventuallyBeforeTimingOutAfter(3.0)] beNonNil];

		});

	});

});

SPEC_END
