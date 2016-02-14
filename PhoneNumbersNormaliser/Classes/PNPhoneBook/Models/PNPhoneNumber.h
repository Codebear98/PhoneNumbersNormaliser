//
//  PNPhoneNumber.h
//  PhoneNumbersNormaliser
//
//  Created by Henry Hong on 13/2/16.
//  Copyright © 2016 Henry Hong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PNPhoneNumber : NSObject

@property (nullable, nonatomic, strong) NSString *phoneNumber;
@property (nullable, nonatomic, strong) NSString *countryCode;
@property (nullable, nonatomic, strong) NSString *areaCode;
@property (nonatomic, assign) BOOL isMobile;
@property (nonatomic, assign) BOOL isValid;

@end
