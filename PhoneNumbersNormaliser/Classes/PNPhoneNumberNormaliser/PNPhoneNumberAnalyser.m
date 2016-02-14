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

#define kBackFillCountryCode @"HK"

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

	BOOL withPlusSign = [phoneNubmerString rangeOfString:@"+"].location == 0;

	phoneNubmerString = [phoneUtil normalizeDigitsOnly:phoneNubmerString];

	if (withPlusSign && [phoneNubmerString rangeOfString:@"+"].location == NSNotFound) {
		// add it back if it lost plus sign after normalisation
		phoneNubmerString = [NSString stringWithFormat:@"+%@", phoneNubmerString];
	}

	PNPhoneNumber *pnPhoneNumber = nil;
	NSString *region = nil;

	if (self.defaultRegion.length > 0) {

		region = self.defaultRegion;
	} else {

		region = [phoneUtil countryCodeByCarrier]; // use carrier region
	}

	// if still no region
	if (region.length < 1 || [region isEqualToString:NB_UNKNOWN_REGION]) {
		region = kBackFillCountryCode;
	}

	NSError *aError = nil;
	NBPhoneNumber *nbPhoneNumber = [phoneUtil parse:phoneNubmerString defaultRegion:region error:&aError];

	if (!aError) {
		// Should check error
		pnPhoneNumber = [self convertToPNPhoneNumber:nbPhoneNumber];

		if ([phoneUtil isValidNumber:nbPhoneNumber]) {
			pnPhoneNumber.isValid = YES;

		} else {
			// check if error because of just missing "+"
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

#pragma mark - Internal Methods

- (PNPhoneNumber *)convertToPNPhoneNumber:(NBPhoneNumber *)nbPhoneNumber
{

	NBPhoneNumberUtil *phoneUtil = [NBPhoneNumberUtil sharedInstance];

	PNPhoneNumber *pnPhoneNumber = [PNPhoneNumber new];

	NBEPhoneNumberType phoneNumberType = [phoneUtil getNumberType:nbPhoneNumber];
	NSLog(@"%@, NBEPhoneNumberType %ld", nbPhoneNumber.nationalNumber, phoneNumberType);

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
