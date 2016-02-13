//
//  PNPhoneBook.m
//  PhoneNumbersNormaliser
//
//  Created by Henry Hong on 13/2/16.
//  Copyright © 2016 Henry Hong. All rights reserved.
//

#import "PNPhoneBook.h"

@interface PNPhoneBook()

/*
 One of the reason of having this class is low coupling. By separating data and logic, you can switch to other data source without affacting too much on the logic.
 */
@property (nonatomic, strong) NSMutableArray *phoneDatas;

@end

@implementation PNPhoneBook

+ (instancetype)sharedInstance {

	static PNPhoneBook * _sharedInstance = nil;
	static dispatch_once_t onceToken;

	dispatch_once(&onceToken, ^{
		_sharedInstance = [[PNPhoneBook alloc] init];
	});

	return _sharedInstance;
}

- (instancetype)init {
	self = [super init];
	if (self) {
		self.phoneDatas = [[NSMutableArray alloc]init];
	}

	return self;
}

#pragma mark - main logic

- (nullable NSString *)phoneNumberAtIndex:(NSUInteger)index {

	// guard clause
	if (![self validateIndex:index]) {
		return nil;
	}

	return [self.phoneDatas objectAtIndex:index];;
}

- (BOOL)addPhoneNumber:(nonnull NSString *)phoneNumber {

	// guard clause
	if (phoneNumber.length<1) {
		return NO;
	}

	[self.phoneDatas addObject:phoneNumber];

	return YES;
}

- (BOOL)removePhoneNumberAtIndex:(NSUInteger)index {

	// guard clause
	if (![self validateIndex:index]) {
		return NO;
	}

	[self.phoneDatas removeObjectAtIndex:index];

	return YES;
}

- (NSUInteger)numberOfRecords {

	return [self.phoneDatas count];
}

- (void)reset {

	[self.phoneDatas removeAllObjects];
}

#pragma mark - helper

// verify if given index is valid
- (BOOL)validateIndex:(NSUInteger)index {

	return index < self.phoneDatas.count;
}

@end
