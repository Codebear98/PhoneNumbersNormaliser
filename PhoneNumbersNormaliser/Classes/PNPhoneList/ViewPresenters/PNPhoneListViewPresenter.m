//
//  PNPhoneListViewPresenter.m
//  PhoneNumbersNormaliser
//
//  Created by Henry Hong on 13/2/16.
//  Copyright © 2016 Henry Hong. All rights reserved.
//

#import "PNPhoneListViewPresenter.h"
#import "PNPhoneBookDataSource.h"

#import "PNPhoneNumberAnalyser.h"

// views
#import "PNPhoneListCell.h"

// Models
#import "PNPhoneNumber.h"

// helper
#import "PNMacros.h"

static CGFloat const kCellHeight			 = 70.0;

typedef NS_ENUM(NSInteger, PNPhoneListViewMode) {
	PNPhoneListViewModeOriginal,
	PNPhoneListViewModeNormalised
};

@interface PNPhoneListViewPresenter () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, assign) PNPhoneListViewMode listViewMode;
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
	self.listViewMode = PNPhoneListViewModeOriginal;

	[self.phoneListView reloadData];
}

- (void)displayNormalisedPhoneListFromPhoneBookData
{

	NSMutableArray *normalisedPhoneNumbers = [[NSMutableArray alloc]init];

	NSArray *phoneNumberStrings = [self.phoneBookData findAllPhoneRecords];

	PNPhoneNumberAnalyser *phoneNumberAnalyser = [[PNPhoneNumberAnalyser alloc]initWithDefaultRegion:@"HK"];
	for (NSString *string in phoneNumberStrings) {

		[normalisedPhoneNumbers addObject:[phoneNumberAnalyser analyse:string]];
	}

	self.analyzedPhoneNumbers = normalisedPhoneNumbers;
	self.listViewMode = PNPhoneListViewModeNormalised;
	self.phoneNumberStrings = phoneNumberStrings;

	[self.phoneListView reloadData];
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

	cell.originalNumberLabel.text = [_phoneNumberStrings objectAtIndex:indexPath.row];

	if (self.listViewMode == PNPhoneListViewModeNormalised) {

		PNPhoneNumber *phoneNumber = [_analyzedPhoneNumbers objectAtIndex:indexPath.row];
		cell.phoneNumberLabel.text = phoneNumber.phoneNumber;
		cell.areaCodeLabel.text = phoneNumber.areaCode;
		cell.countryCodeLabel.text = phoneNumber.countryCode;
		cell.statusLabel.text = (phoneNumber.isValid) ? @"Valid":@"Invalid";
		cell.statusLabel.textColor = (phoneNumber.isValid) ? UIColorFromHex(0x00B200):UIColorFromHex(0xCC0000);
		cell.phoneTypeLabel.text = (phoneNumber.isMobile) ? @"YES":@"NO";

	}

	return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return kCellHeight;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	// do nothing
}

@end
