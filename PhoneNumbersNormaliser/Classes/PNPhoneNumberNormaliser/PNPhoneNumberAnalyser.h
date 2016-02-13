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
 * displays in normalised mode
 */
- (nonnull instancetype)initWithDefaultRegion:(nonnull NSString *)defaultRegion;

/**
 * analyse the given phone number with default region
 * @param the phone number string
 * @return a PNPhoneNumber object with analysed phone information
 */
- (nonnull PNPhoneNumber *)analyse:(nonnull NSString *)phoneNubmerString;

/**
 * analyse the given phone number with carrier region, the region where the sim card registered.
 * @param the phone number string
 * @return a PNPhoneNumber object with analysed phone information
 */
- (nonnull PNPhoneNumber *)analyseWithCarrierRegion:(nonnull NSString *)phoneNubmerString;

@end
