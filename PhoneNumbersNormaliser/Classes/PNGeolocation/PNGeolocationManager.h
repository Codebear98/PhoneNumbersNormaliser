//
//  PNGeolocationManager.h
//  PhoneNumbersNormaliser
//
//  Created by Henry Hong on 14/2/16.
//  Copyright © 2016 Henry Hong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

typedef void (^PNGeolocationManagerResult)(CLPlacemark *_Nullable placemark);

@interface PNGeolocationManager : NSObject

/**
 * Singleton for the PNGeolocationManager
 */
+ (nonnull instancetype)sharedInstance;

/**
 * retrieve the current location
 * @param resultCallback, the callback block which return geolocation information
 */
- (void)requestCurrentPlacemark:(nullable PNGeolocationManagerResult)resultCallback;

@end
