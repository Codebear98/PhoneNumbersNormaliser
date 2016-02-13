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

- (nonnull instancetype)initWithDefaultRegion:(nonnull NSString *)defaultRegion;

- (nonnull PNPhoneNumber *)analyse:(nonnull NSString *)phoneNubmerString;

- (nonnull PNPhoneNumber *)analyseWithCarrierRegion:(nonnull NSString *)phoneNubmerString;

@end
