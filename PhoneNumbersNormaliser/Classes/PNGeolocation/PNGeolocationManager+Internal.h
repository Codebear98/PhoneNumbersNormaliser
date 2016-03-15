//
//  PNGeolocationManager+Internal.h
//  PhoneNumbersNormaliser
//
//  Created by Henry Hong on 14/2/16.
//  Copyright © 2016 Henry Hong. All rights reserved.
//

#import "PNGeolocationManager.h"

@interface PNGeolocationManager () <CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) CLGeocoder *geocoder;

@property (nonatomic, strong) CLLocation *currentDetectedLocation;
@property (nonatomic, strong) CLPlacemark *currentPlacemark;
@property (nonatomic, strong) PNGeolocationManagerResult resultCallback;

- (void)notifyWithResult;

@end