//
//  PNGeolocationManager.h
//  PhoneNumbersNormaliser
//
//  Created by Henry Hong on 14/2/16.
//  Copyright © 2016 Henry Hong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

typedef void (^PNGeolocationManagerResult)(CLLocation *_Nullable location);

@interface PNGeolocationManager : NSObject

/**
 * Singleton for the phonebook
 */
+ (nonnull instancetype)sharedInstance;

/**
 * retrieve the current location
 */
- (void)requestLocation:(nullable PNGeolocationManagerResult)resultCallback;

@end
