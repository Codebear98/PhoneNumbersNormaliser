//
//  PNPhoneNumberAnalyser.m
//  PhoneNumbersNormaliser
//
//  Created by Henry Hong on 13/2/16.
//  Copyright © 2016 Henry Hong. All rights reserved.
//

#import "PNPhoneNumberAnalyser.h"
#import <libPhoneNumber-iOS/NBPhoneNumber.h>
#import <libPhoneNumber-iOS/NBPhoneNumberDefines.h>
#import <libPhoneNumber-iOS/NBPhoneNumberUtil.h>

static const NSString * PNRegion_BackFill = @"HK";

@interface PNPhoneNumberAnalyser()

@property (nonatomic, strong) NSString *defaultRegion;

@end

@implementation PNPhoneNumberAnalyser

- (nonnull instancetype)initWithDefaultRegion:(nonnull NSString *)defaultRegion
{
	self = [super init];
	if (self) {
		self.defaultRegion = defaultRegion;
	}

	return self;
}

- (nonnull PNPhoneNumber *)analyse:(nonnull NSString *)phoneNubmerString
{

	NBPhoneNumberUtil *phoneUtil = [NBPhoneNumberUtil sharedInstance];
	phoneNubmerString = [phoneUtil normalizeDigitsOnly:phoneNubmerString];
	PNPhoneNumber *pnPhoneNumber = nil;

	NSString *region = (self.defaultRegion) ? self.defaultRegion:PNRegion_BackFill;

	NSError *aError = nil;
	NBPhoneNumber *nbPhoneNumber = [phoneUtil parse:phoneNubmerString defaultRegion:region error:&aError];

	if (!aError) {
		// Should check error
		pnPhoneNumber = [self convertToPNPhoneNumber:nbPhoneNumber];

		if ([phoneUtil isValidNumber:nbPhoneNumber]) {
			pnPhoneNumber.isValid = YES;

		} else {
			// check if it just missing "+"
			NSString *phoneNubmerStringPlus = [NSString stringWithFormat:@"+%@", phoneNubmerString];

			NBPhoneNumber *plusNBPhoneNumber = [phoneUtil parse:phoneNubmerStringPlus defaultRegion:region error:&aError];

			if ([phoneUtil isValidNumber:plusNBPhoneNumber]) {
				pnPhoneNumber = [self convertToPNPhoneNumber:plusNBPhoneNumber];
				pnPhoneNumber.isValid = YES;
			}
		}

	} else {

		if ([aError.domain isEqualToString:@"INVALID_COUNTRY_CODE"]) {

			// Guess the country code
			pnPhoneNumber = [PNPhoneNumber new];
			pnPhoneNumber.phoneNumber = phoneNubmerString;
			pnPhoneNumber.countryCode = [phoneUtil getCountryCodeForRegion:region].stringValue;

			pnPhoneNumber.isValid = NO;
		}
		
		NSLog(@"Error : %@", [aError localizedDescription]);
	}

	return pnPhoneNumber;
}

- (nonnull PNPhoneNumber *)analyseWithCarrierRegion:(nonnull NSString *)phoneNubmerString
{
	PNPhoneNumber *pnPhoneNumber = nil;

	NBPhoneNumberUtil *phoneUtil = [NBPhoneNumberUtil sharedInstance];

	NSError *aError = nil;
	NBPhoneNumber *nbPhoneNumber = [phoneUtil parseWithPhoneCarrierRegion:phoneNubmerString error:&aError];

	if (!aError) {
		// Should check error
		pnPhoneNumber = [self convertToPNPhoneNumber:nbPhoneNumber];

	} else {
		NSLog(@"Error : %@", [aError localizedDescription]);
	}

	return pnPhoneNumber;
}

- (PNPhoneNumber *)convertToPNPhoneNumber:(NBPhoneNumber *)nbPhoneNumber
{

	NBPhoneNumberUtil *phoneUtil = [NBPhoneNumberUtil sharedInstance];

	PNPhoneNumber *pnPhoneNumber = [PNPhoneNumber new];

	NBEPhoneNumberType phoneNumberType = [phoneUtil getNumberType:nbPhoneNumber];

	if (phoneNumberType == NBEPhoneNumberTypeMOBILE) {

		pnPhoneNumber.isMobile = YES;
		pnPhoneNumber.phoneNumber = nbPhoneNumber.nationalNumber.stringValue;

	} else {

		NSString *phoneNumberString = nil;
		pnPhoneNumber.areaCode = [self extractAreaCodeAndPhoneNumber:&phoneNumberString withNBPhoneNumber:nbPhoneNumber];
		pnPhoneNumber.phoneNumber = phoneNumberString;

	}

	pnPhoneNumber.countryCode = nbPhoneNumber.countryCode.stringValue;

	return pnPhoneNumber;
}

- (NSString *)extractAreaCodeAndPhoneNumber:(NSString **)phoneNumber withNBPhoneNumber:(NBPhoneNumber *)nbPhoneNumber
{
	NBPhoneNumberUtil *phoneUtil = [NBPhoneNumberUtil sharedInstance];

	NSString *areaCode = nil;
	NSString *nationalSignificantNumber = [phoneUtil getNationalSignificantNumber:nbPhoneNumber];

	NSError *aError = nil;
	int codeLength = [phoneUtil getLengthOfGeographicalAreaCode:nbPhoneNumber error:&aError];

	if (!aError && codeLength > 0) {
		areaCode = [nationalSignificantNumber substringToIndex:codeLength];
		*phoneNumber = [nationalSignificantNumber substringFromIndex:codeLength];

	} else {

		*phoneNumber = nationalSignificantNumber;
	}

	return areaCode;
}

@end
