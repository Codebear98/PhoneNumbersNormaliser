//
//  PNPhoneListViewPresenter.m
//  PhoneNumbersNormaliser
//
//  Created by Henry Hong on 13/2/16.
//  Copyright © 2016 Henry Hong. All rights reserved.
//

#import "PNPhoneListViewPresenter.h"
#import "PNPhoneBookDataSource.h"

// views
#import "PNPhoneListCell.h"

// Models
#import "PNPhoneNumber.h"

@interface PNPhoneListViewPresenter () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSArray<NSString*> *phoneNumberStrings;
@property (nonatomic, strong) NSArray<PNPhoneNumber*> *analyzedPhoneNumbers;

@end

@implementation PNPhoneListViewPresenter

// PNPhoneListViewPresenter is not bounded to PNPhoneBook, it bounds to any data source that confirms PNPhoneBookDataSource protocol
- (instancetype)initWithPhoneBookData:(id <PNPhoneBookDataSource>)phoneBookData
						phoneListView:(PNPhoneListView *)phoneListView
{
	self = [super init];
	if (self) {

		self.phoneBookData = phoneBookData;

		self.phoneListView = phoneListView;
		self.phoneListView.delegate = self;
		self.phoneListView.dataSource = self;

		[self.phoneListView registerClass:[PNPhoneListCell class] forCellReuseIdentifier:@"PNPhoneListCell"];
	}

	return self;
}

- (void)displayPhoneListFromPhoneBookData
{
	self.phoneNumberStrings = [self.phoneBookData findAllPhoneRecords];
	[self.phoneListView reloadData];
}

- (void)displayNormalisedPhoneListFromPhoneBookData
{

	NSMutableArray *normalisedPhoneNumbers = [[NSMutableArray alloc]init];

	NSArray *phoneNumberStrings = [self.phoneBookData findAllPhoneRecords];

	for (NSString *string in phoneNumberStrings) {

	}

	self.analyzedPhoneNumbers = normalisedPhoneNumbers;

}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [_phoneNumberStrings count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString * CellIdentifier = @"PNPhoneListCell";
	PNPhoneListCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	[cell textLabel].text = [_phoneNumberStrings objectAtIndex:indexPath.row];

	return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	// do nothing
}

@end
