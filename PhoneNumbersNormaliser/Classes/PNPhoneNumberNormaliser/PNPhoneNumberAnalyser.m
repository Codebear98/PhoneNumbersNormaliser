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
	PNPhoneNumber *pnPhoneNumber = nil;

	NSString *region = (self.defaultRegion) ? self.defaultRegion:PNRegion_BackFill;

	NBPhoneNumberUtil *phoneUtil = [NBPhoneNumberUtil sharedInstance];

	NSError *aError = nil;
	NBPhoneNumber *nbPhoneNumber = [phoneUtil parse:phoneNubmerString defaultRegion:region error:&aError];

	if (!aError) {
		// Should check error
		pnPhoneNumber = [self convertToPNPhoneNumber:nbPhoneNumber];
		pnPhoneNumber.isValid = [phoneUtil isValidNumber:nbPhoneNumber];
		
	} else {

		if ([aError.domain isEqualToString:@"INVALID_COUNTRY_CODE"]) {

			// Guess the country code
			pnPhoneNumber = [PNPhoneNumber new];
			pnPhoneNumber.nationalNumber = phoneNubmerString;
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
	} else {

		pnPhoneNumber.areaCode = [self extractAreaCode:nbPhoneNumber];
	}

	pnPhoneNumber.nationalNumber = nbPhoneNumber.nationalNumber.stringValue;
	pnPhoneNumber.countryCode = nbPhoneNumber.countryCode.stringValue;

	return pnPhoneNumber;
}

- (NSString *)extractAreaCode:(NBPhoneNumber *)nbPhoneNumber
{
	NBPhoneNumberUtil *phoneUtil = [NBPhoneNumberUtil sharedInstance];

	NSString *nationalDestinationCode = nil;
	NSString *nationalSignificantNumber = [phoneUtil getNationalSignificantNumber:nbPhoneNumber];

	NSError *aError = nil;
	int nationalDestinationCodeLength = [phoneUtil getLengthOfNationalDestinationCode:nbPhoneNumber error:&aError];

	if (!aError && nationalDestinationCodeLength > 0) {
		nationalDestinationCode = [nationalSignificantNumber substringToIndex:nationalDestinationCodeLength];
	}
	
	return nationalDestinationCode;
}

@end
