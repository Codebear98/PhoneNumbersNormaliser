//
//  PNPhoneBookViewController.m
//  PhoneNumbersNormaliser
//
//  Created by Henry Hong on 13/2/16.
//  Copyright © 2016 Henry Hong. All rights reserved.
//

#import "PNPhoneBookViewController.h"

#import "PNPhoneBook.h"

// views
#import "PNPhoneListView.h"
#import "PNPhoneListViewPresenter.h"

// helpers
#import "UIView+AutoLayoutHelper.h"

@interface PNPhoneBookViewController ()

@property (nonnull, nonatomic, strong) PNPhoneListViewPresenter *phoneListViewPresenter;

@end

@implementation PNPhoneBookViewController

- (instancetype)init
{
	self = [super init];
	if (self) {

		// dummy data
		[[PNPhoneBook sharedInstance] addPhoneNumber:@"123456789"];
		[[PNPhoneBook sharedInstance] addPhoneNumber:@"8976543"];
		[[PNPhoneBook sharedInstance] addPhoneNumber:@"76543"];
		[[PNPhoneBook sharedInstance] addPhoneNumber:@"2345678765"];
		[[PNPhoneBook sharedInstance] addPhoneNumber:@"345678"];
		[[PNPhoneBook sharedInstance] addPhoneNumber:@"3456"];

	}

	return self;
}

- (void)loadView
{
    [super loadView];

	self.view.backgroundColor = [UIColor whiteColor];

	[self setupBarButtons];
	[self setupPhoneListView];

	[self setupConstraints];

}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];

	[self.phoneListViewPresenter displayPhoneListFromPhoneBookData];
}

- (void)setupBarButtons
{

	UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"Normalise" style:UIBarButtonItemStylePlain target:self action:@selector(userDidPressNormaliserButton:)];
	self.navigationItem.rightBarButtonItem = rightButton;

}

- (void)setupPhoneListView
{
	self.phoneListViewPresenter = [self createPhoneListViewPresenter];
	[self.view addSubview:self.phoneListViewPresenter.phoneListView];
}

- (void)setupConstraints
{
	[self.phoneListViewPresenter.phoneListView fillSuperView:UIEdgeInsetsZero];
}

- (PNPhoneListViewPresenter *)createPhoneListViewPresenter
{
	id<PNPhoneBookDataSource> phoneBookData = [PNPhoneBook sharedInstance];

	PNPhoneListView *listView = [[PNPhoneListView alloc]init];
	PNPhoneListViewPresenter *presenter = [[PNPhoneListViewPresenter alloc] initWithPhoneBookData:phoneBookData
																					phoneListView:listView];

	return presenter;
}

#pragma mark - button actions

- (void)userDidPressNormaliserButton:(id)sender
{

	[self.phoneListViewPresenter displayNormalisedPhoneListFromPhoneBookData];
}

@end
