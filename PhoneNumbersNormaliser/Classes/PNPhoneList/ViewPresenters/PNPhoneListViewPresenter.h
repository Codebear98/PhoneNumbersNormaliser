//
//  PNPhoneListViewPresenter.h
//  PhoneNumbersNormaliser
//
//  Created by Henry Hong on 13/2/16.
//  Copyright © 2016 Henry Hong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PNPhoneListView.h"

@protocol PNPhoneBookDataSource;

@interface PNPhoneListViewPresenter : NSObject

@property (nonatomic, strong) PNPhoneListView *phoneListView;
@property (nonatomic, strong) id<PNPhoneBookDataSource> phoneBookData;

- (instancetype)initWithPhoneBookData:(id <PNPhoneBookDataSource>)phoneBookData
						phoneListView:(PNPhoneListView *)phoneListView;

/**
 * fetch data from the datasource and populate to views.
 */
- (void)displayPhoneListFromPhoneBookData;

/**
 * displays the normalised information
 */
- (void)displayNormalisedPhoneListFromPhoneBookData;

@end
