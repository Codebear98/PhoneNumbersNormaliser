//
//  PNPhoneBook.h
//  PhoneNumbersNormaliser
//
//  Created by Henry Hong on 13/2/16.
//  Copyright © 2016 Henry Hong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PNPhoneBookDataSource.h"

/*
 A very simple phonebook where phone numbers could be in any format
 */
@interface PNPhoneBook : NSObject <PNPhoneBookDataSource>

/**
 * Singleton for the phonebook
 */
+ (nonnull instancetype)sharedInstance;

/**
 * Retrieve a phone number at given index
 * @param index of the phone number
 * @return a phone number in NSString, return nil if action is failed or invalid index
 */
- (nullable NSString *)phoneNumberAtIndex:(NSUInteger)index;

/**
 * Add a phone number in phonebook
 * @param a phone number in string format
 * @return a bool indicates fail or sucess
 */
- (BOOL)addPhoneNumber:(nonnull NSString *)phoneNumber;

/**
 * Remove a phone number at specify index
 * @param an index of phone number to be removed
 * @return a bool indicates fail or sucess
 */
- (BOOL)removePhoneNumberAtIndex:(NSUInteger)index;

/**
 * update a phone number in phonebook
 * @param a phone number in string format
 * @param an index of phone number to be updated
 * @return a bool indicates fail or sucess
 */
- (BOOL)updatePhoneNumber:(nonnull NSString *)phoneNumber atIndex:(NSUInteger)index;

/**
 * Retrieve total number of record in the phone book
 * @return an NSUInteger
 */
- (NSUInteger)numberOfRecords;

/**
 * Remove all phone number in the phonebook
 */
- (void)reset;

@end
