//
//  PNPhoneNumberAnalyserSpec.m
//  PhoneNumbersNormaliser
//
//  Created by Henry Hong on 13/2/16.
//  Copyright © 2016 Henry Hong. All rights reserved.
//

#import <Kiwi/Kiwi.h>

#import "PNPhoneNumberAnalyser.h"
#import "PNMacros.h"

SPEC_BEGIN(PNPhoneNumberAnalyserSpec)

describe(@"PNPhoneNumberAnalyserSpec", ^{

	describe(@"When initialising", ^{
		__block PNPhoneNumberAnalyser *phoneNumberAnalyser = nil;

		beforeEach(^{

			phoneNumberAnalyser = [PNPhoneNumberAnalyser new];
		});

		it(@"should not be nil", ^{

			[[phoneNumberAnalyser shouldNot] beNil];
		});

		describe(@"When anaylse a wrong phone number", ^{

			it(@"Should return a non-null object", ^{

				PNPhoneNumber *phoneNumber = [phoneNumberAnalyser analyse:@"432432"];

				[[phoneNumber shouldNot]beNil];

				phoneNumber = [phoneNumberAnalyser analyse:@"3243455"];

				[[phoneNumber shouldNot]beNil];

				phoneNumber = [phoneNumberAnalyser analyse:@"55555"];

				[[phoneNumber shouldNot]beNil];

				phoneNumber = [phoneNumberAnalyser analyse:@"98937247234832"];

				[[phoneNumber shouldNot]beNil];
				
			});
		});

		describe(@"When anaylse a valid phone number without areacode and country code", ^{

			__block NSString *numberString = @"52345674";

			it(@"Should return a non-null object", ^{

				PNPhoneNumber *phoneNumber = [phoneNumberAnalyser analyse:numberString];

				[[phoneNumber shouldNot]beNil];

			});

			it(@"Should be able to identify national number", ^{

				PNPhoneNumber *phoneNumber = [phoneNumberAnalyser analyse:numberString];

				[[phoneNumber.phoneNumber should]equal:numberString];
				
			});

			it(@"Should be able to identify correct country code with given default Region", ^{

				PNPhoneNumberAnalyser *analyserForUKNumber = [[PNPhoneNumberAnalyser alloc]initWithDefaultRegion:@"GB"];

				PNPhoneNumber *phoneNumber = [analyserForUKNumber analyse:numberString];

				[[phoneNumber.countryCode should]equal:@"44"];

				analyserForUKNumber = [[PNPhoneNumberAnalyser alloc]initWithDefaultRegion:@"HK"];

				phoneNumber = [analyserForUKNumber analyse:numberString];

				[[phoneNumber.countryCode should]equal:@"852"];

			});
		});

		describe(@"When anaylse a HK phone number", ^{

			__block NSString *numberString = @"+852 52345674";

			it(@"Should return a valid PNPhoneNumber object", ^{

				PNPhoneNumber *phoneNumber = [phoneNumberAnalyser analyse:numberString];

				[[phoneNumber.countryCode should]equal:@"852"];
				[[phoneNumber.phoneNumber should]equal:@"52345674"];
			});
			
		});

		describe(@"When anaylse a HK mobile number beginning with 9", ^{

			__block PNPhoneNumber *phoneNumber = nil;

			beforeAll(^{

				phoneNumber = [phoneNumberAnalyser analyse:@"+852 92345674"];
			});

			it(@"Should return be able to identify the country code", ^{

				[[phoneNumber.countryCode should]equal:@"852"];
				[[phoneNumber.phoneNumber should]equal:@"92345674"];
			});

			it(@"Should return be able to identify as mobile number", ^{

				[[theValue(phoneNumber.isMobile) should]equal:theValue(YES)];
			});

			it(@"Should return nil areacode", ^{

				[[phoneNumber.areaCode should]beNil];
			});

		});

		describe(@"When anaylse a HK mobile number beginning with 6", ^{

			__block PNPhoneNumber *phoneNumber = nil;

			beforeAll(^{

				phoneNumber = [phoneNumberAnalyser analyse:@"+852 62345674"];
			});

			it(@"Should return be able to identify the country code and national number", ^{

				[[phoneNumber.countryCode should]equal:@"852"];
				[[phoneNumber.phoneNumber should]equal:@"62345674"];
			});

			it(@"Should return be able to identify as mobile number", ^{

				[[theValue(phoneNumber.isMobile) should]equal:theValue(YES)];
			});

			it(@"Should return nil areacode", ^{

				[[phoneNumber.areaCode should]beNil];
			});

		});

		describe(@"When anaylse a UK international mobile number", ^{

			__block PNPhoneNumber *phoneNumber = nil;

			beforeAll(^{

				phoneNumber = [phoneNumberAnalyser analyse:@"+44 7700 900344"];
			});

			it(@"Should return be able to identify the country code and national number", ^{

				[[phoneNumber.countryCode should]equal:@"44"];
				[[phoneNumber.phoneNumber should]equal:@"7700900344"];
			});

			it(@"Should return be able to identify as mobile number", ^{

				[[theValue(phoneNumber.isMobile) should]equal:theValue(YES)];
			});

			it(@"Should return nil areacode", ^{

				[[phoneNumber.areaCode should]beNil];
			});
			
		});

	});

});

SPEC_END
