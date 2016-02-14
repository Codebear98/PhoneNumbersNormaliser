//
//  PNPhoneNumberAnalyser.h
//  PhoneNumbersNormaliser
//
//  Created by Henry Hong on 13/2/16.
//  Copyright © 2016 Henry Hong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PNPhoneNumber.h"

@interface PNPhoneNumberAnalyser : NSObject

/**
 * init with default region(country code)
 * if no region is given, it will try to extract region from sim card
 * if still unable retrieve region from sim card, it will use backfill region @"HK"
 *
 * @param defaultRegion, a country code that you can retrieve from geolocation service.
 * @return a PhoneNumberAnalyser instance
 */
- (nonnull instancetype)initWithDefaultRegion:(nonnull NSString *)defaultRegion;

/**
 * analyse the given phone number with default region
 * @param the phone number string
 * @return a PNPhoneNumber object with analysed phone information
 */
- (nonnull PNPhoneNumber *)analyse:(nonnull NSString *)phoneNubmerString;

@end
