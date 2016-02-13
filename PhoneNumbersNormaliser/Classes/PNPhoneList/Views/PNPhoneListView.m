//
//  PNPhoneListView.m
//  PhoneNumbersNormaliser
//
//  Created by Henry Hong on 13/2/16.
//  Copyright © 2016 Henry Hong. All rights reserved.
//

// please note that this class is overkill for the current requirements, just reverse as a placeholder.

#import "PNPhoneListView.h"
#import "UIView+AutoLayoutHelper.h"

@implementation PNPhoneListView

- (instancetype)init
{
	self = [super initWithFrame:CGRectZero style:UITableViewStylePlain];
	if (self) {

		[self setupView];
		[self setupConstraints];
	}

	return self;
}

- (void)setupView
{
	// setup all subviews
	self.backgroundColor = [UIColor whiteColor];
}

- (void)setupConstraints
{
	// setup all constraints within this view hierarchy
	self.translatesAutoresizingMaskIntoConstraints = NO;
}

@end
