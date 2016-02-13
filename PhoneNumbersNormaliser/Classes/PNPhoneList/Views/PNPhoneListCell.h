//
//  PNPhoneListCell.h
//  PhoneNumbersNormaliser
//
//  Created by Henry Hong on 13/2/16.
//  Copyright © 2016 Henry Hong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PNPhoneListCell : UITableViewCell

@property (nonatomic, strong) UILabel *originalNumberLabel;
@property (nonatomic, strong) UILabel *nationalNumberLabel;
@property (nonatomic, strong) UILabel *countryCodeLabel;
@property (nonatomic, strong) UILabel *areaCodeLabel;
@property (nonatomic, strong) UILabel *statusLabel;
@property (nonatomic, strong) UILabel *phoneTypeLabel;

@end
