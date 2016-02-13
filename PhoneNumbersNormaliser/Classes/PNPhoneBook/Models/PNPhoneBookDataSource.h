//
//  PNPhoneBookDataSource.h
//  PhoneNumbersNormaliser
//
//  Created by Henry Hong on 13/2/16.
//  Copyright © 2016 Henry Hong. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol PNPhoneBookDataSource <NSObject>

/**
 *
 * @return an Array of string
 */
@required
- (nonnull NSArray *)findAllPhoneRecords;

@end
