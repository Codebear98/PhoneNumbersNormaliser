//
//  PNPhoneNumber.h
//  PhoneNumbersNormaliser
//
//  Created by Henry Hong on 13/2/16.
//  Copyright © 2016 Henry Hong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PNPhoneNumber : NSObject

@property (nonatomic, strong) NSString *phoneNumber;
@property (nonatomic, strong) NSString *countryCode;
@property (nonatomic, strong) NSString *areaCode;
@property (nonatomic, assign) BOOL isMobile;

@end
