//  PNPhoneListCell.m
//  PhoneNumbersNormaliser
//
//  Created by Henry Hong on 13/2/16.
//  Copyright © 2016 Henry Hong. All rights reserved.
//

#import "PNPhoneListCell.h"
#import "PNMacros.h"
#import "UIView+AutoLayoutHelper.h"

static CGFloat const kPNPhoneListCell_LeftPadding = 15.0f;
static CGFloat const kPNPhoneListCell_RightPadding = 15.0f;
static CGFloat const kPNPhoneListCell_Padding = 5.0f;
static CGFloat const kPNPhoneListCell_TitleLabelWidth = 85.0f;

#define PNPhoneListCell_SmallFont [UIFont systemFontOfSize:10.0]
#define PNPhoneListCell_LargeFont [UIFont systemFontOfSize:16.0]
#define PNPhoneListCell_NormalFont [UIFont systemFontOfSize:13.0]
#define PNPhoneListCell_TitleColor UIColorFromHex(0x3A5D61)
#define PNPhoneListCell_TextColor UIColorFromHex(0x3E7D00)
#define PNPhoneListCell_OrgColor UIColorFromHex(0x53868B)

@interface PNPhoneListCell()

@property (nonatomic, strong) UILabel *phoneNumberTitleLabel;
@property (nonatomic, strong) UILabel *countryCodeTitleLabel;
@property (nonatomic, strong) UILabel *areaCodeTitleLabel;
@property (nonatomic, strong) UILabel *phoneTypeTitleLabel;
@property (nonatomic, strong) UILabel *statusTitleLabel;

@end

@implementation PNPhoneListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier
{

	self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
	if (self) {

		[self setup];
	}

	return self;
}

- (void)setup
{
	[self setupTitleLabels];
	[self setupContentLabels];
	[self setupConstraints];
}

- (void)setupContentLabels

{
	_originalNumberLabel = [UILabel new];
	_phoneNumberLabel = [UILabel new];
	_countryCodeLabel = [UILabel new];
	_areaCodeLabel = [UILabel new];
	_statusLabel = [UILabel new];
	_phoneTypeLabel = [UILabel new];

	_originalNumberLabel.font = PNPhoneListCell_LargeFont;
	_originalNumberLabel.textColor = PNPhoneListCell_OrgColor;
	_originalNumberLabel.textAlignment = NSTextAlignmentLeft;

	_phoneNumberLabel.font = PNPhoneListCell_SmallFont;
	_phoneNumberLabel.textColor = PNPhoneListCell_TextColor;
	_phoneNumberLabel.textAlignment = NSTextAlignmentLeft;

	_countryCodeLabel.font = PNPhoneListCell_SmallFont;
	_countryCodeLabel.textColor = PNPhoneListCell_TextColor;
	_countryCodeLabel.textAlignment = NSTextAlignmentLeft;

	_areaCodeLabel.font = PNPhoneListCell_SmallFont;
	_areaCodeLabel.textColor = PNPhoneListCell_TextColor;
	_areaCodeLabel.textAlignment = NSTextAlignmentLeft;

	_phoneTypeLabel.font = PNPhoneListCell_SmallFont;
	_phoneTypeLabel.textColor = PNPhoneListCell_TextColor;
	_phoneTypeLabel.textAlignment = NSTextAlignmentLeft;

	_statusLabel.font = PNPhoneListCell_SmallFont;
	_statusLabel.textColor = PNPhoneListCell_TextColor;
	_statusLabel.textAlignment = NSTextAlignmentLeft;

	[self.contentView addSubview:_originalNumberLabel];
	[self.contentView addSubview:_phoneNumberLabel];
	[self.contentView addSubview:_countryCodeLabel];
	[self.contentView addSubview:_areaCodeLabel];
	[self.contentView addSubview:_statusLabel];
	[self.contentView addSubview:_phoneTypeLabel];

}

- (void)setupTitleLabels
{
	UIFont *smallFont = [UIFont systemFontOfSize:10.0];
	UIColor *titleColor = UIColorFromHex(0x415677);

	_phoneNumberTitleLabel = [UILabel new];
	_countryCodeTitleLabel = [UILabel new];
	_areaCodeTitleLabel = [UILabel new];
	_statusTitleLabel = [UILabel new];
	_phoneTypeTitleLabel = [UILabel new];

	_phoneNumberTitleLabel.font = smallFont;
	_phoneNumberTitleLabel.textColor = titleColor;
	_countryCodeTitleLabel.font = smallFont;
	_countryCodeTitleLabel.textColor = titleColor;
	_areaCodeTitleLabel.font = smallFont;
	_areaCodeTitleLabel.textColor = titleColor;
	_statusTitleLabel.font = smallFont;
	_statusTitleLabel.textColor = titleColor;
	_phoneTypeTitleLabel.font = smallFont;
	_phoneTypeTitleLabel.textColor = titleColor;

	_phoneNumberTitleLabel.text = @"Phone Number: ";
	_countryCodeTitleLabel.text = @"Country Code: ";
	_areaCodeTitleLabel.text = @"Area Code: ";
	_statusTitleLabel.text = @"Status: ";
	_phoneTypeTitleLabel.text = @"IsMobile: ";

	[self.contentView addSubview:_phoneNumberTitleLabel];
	[self.contentView addSubview:_countryCodeTitleLabel];
	[self.contentView addSubview:_areaCodeTitleLabel];
	[self.contentView addSubview:_statusTitleLabel];
	[self.contentView addSubview:_phoneTypeTitleLabel];

}

#pragma mark - Constraints

- (void)setupConstraints
{
	[self setupOrginalNumberConstraints];
	[self setupCountryCodeConstaints];
	[self setupAreaCodeConstraints];
	[self setupNationalNumberConstraints];
	[self setupPhoneTypeConstraints];
	[self setupStatusLabelConstraints];
}

- (void)setupOrginalNumberConstraints
{
	_originalNumberLabel.translatesAutoresizingMaskIntoConstraints = NO;
	[_originalNumberLabel addLeftConstraintToView:self.contentView relation:NSLayoutRelationEqual constant:kPNPhoneListCell_LeftPadding];
	[_originalNumberLabel addCenterYConstraintToView:self.contentView];
	[_originalNumberLabel addWidthConstraintWithRelation:NSLayoutRelationEqual constant:160.0];
}

- (void)setupCountryCodeConstaints
{
	_countryCodeTitleLabel.translatesAutoresizingMaskIntoConstraints = NO;
	[_countryCodeTitleLabel addLeftConstraintToView:_originalNumberLabel attribute:NSLayoutAttributeRight relation:NSLayoutRelationEqual constant:kPNPhoneListCell_Padding];
	[_countryCodeTitleLabel addTopConstraintToView:self.contentView relation:NSLayoutRelationEqual constant:kPNPhoneListCell_Padding];
	[_countryCodeTitleLabel addWidthConstraintWithRelation:NSLayoutRelationEqual constant:kPNPhoneListCell_TitleLabelWidth];

	_countryCodeLabel.translatesAutoresizingMaskIntoConstraints = NO;
	[_countryCodeLabel addLeftConstraintToView:_countryCodeTitleLabel attribute:NSLayoutAttributeRight relation:NSLayoutRelationEqual constant:kPNPhoneListCell_Padding];
	[_countryCodeLabel addRightConstraintToView:self.contentView attribute:NSLayoutAttributeRight relation:NSLayoutRelationEqual constant:-kPNPhoneListCell_RightPadding];
	[_countryCodeLabel addCenterYConstraintToView:_countryCodeTitleLabel];
}

- (void)setupAreaCodeConstraints
{
	_areaCodeTitleLabel.translatesAutoresizingMaskIntoConstraints = NO;
	[_areaCodeTitleLabel addLeftConstraintToView:_originalNumberLabel attribute:NSLayoutAttributeRight relation:NSLayoutRelationEqual constant:kPNPhoneListCell_Padding];
	[_areaCodeTitleLabel addTopConstraintToView:_countryCodeTitleLabel attribute:NSLayoutAttributeBottom relation:NSLayoutRelationEqual constant:kPNPhoneListCell_Padding / 2.0];
	[_areaCodeTitleLabel addWidthConstraintWithRelation:NSLayoutRelationEqual constant:kPNPhoneListCell_TitleLabelWidth];

	_areaCodeLabel.translatesAutoresizingMaskIntoConstraints = NO;
	[_areaCodeLabel addLeftConstraintToView:_areaCodeTitleLabel attribute:NSLayoutAttributeRight relation:NSLayoutRelationEqual constant:kPNPhoneListCell_Padding];
	[_areaCodeLabel addRightConstraintToView:self.contentView attribute:NSLayoutAttributeRight relation:NSLayoutRelationEqual constant:-kPNPhoneListCell_RightPadding];
	[_areaCodeLabel addCenterYConstraintToView:_areaCodeTitleLabel];
}

- (void)setupNationalNumberConstraints
{
	_phoneNumberTitleLabel.translatesAutoresizingMaskIntoConstraints = NO;
	[_phoneNumberTitleLabel addLeftConstraintToView:_originalNumberLabel attribute:NSLayoutAttributeRight relation:NSLayoutRelationEqual constant:kPNPhoneListCell_Padding];
	[_phoneNumberTitleLabel addTopConstraintToView:_areaCodeTitleLabel attribute:NSLayoutAttributeBottom relation:NSLayoutRelationEqual constant:kPNPhoneListCell_Padding / 2.0];
	[_phoneNumberTitleLabel addWidthConstraintWithRelation:NSLayoutRelationEqual constant:kPNPhoneListCell_TitleLabelWidth];

	_phoneNumberLabel.translatesAutoresizingMaskIntoConstraints = NO;
	[_phoneNumberLabel addLeftConstraintToView:_phoneNumberTitleLabel attribute:NSLayoutAttributeRight relation:NSLayoutRelationEqual constant:kPNPhoneListCell_Padding];
	[_phoneNumberLabel addRightConstraintToView:self.contentView attribute:NSLayoutAttributeRight relation:NSLayoutRelationEqual constant:-kPNPhoneListCell_RightPadding];
	[_phoneNumberLabel addCenterYConstraintToView:_phoneNumberTitleLabel];
}

- (void)setupPhoneTypeConstraints
{
	_phoneTypeTitleLabel.translatesAutoresizingMaskIntoConstraints = NO;
	[_phoneTypeTitleLabel addLeftConstraintToView:_originalNumberLabel attribute:NSLayoutAttributeRight relation:NSLayoutRelationEqual constant:kPNPhoneListCell_Padding];
	[_phoneTypeTitleLabel addTopConstraintToView:_phoneNumberTitleLabel attribute:NSLayoutAttributeBottom relation:NSLayoutRelationEqual constant:kPNPhoneListCell_Padding / 2.0];
	[_phoneTypeTitleLabel addWidthConstraintWithRelation:NSLayoutRelationEqual constant:kPNPhoneListCell_TitleLabelWidth];

	_phoneTypeLabel.translatesAutoresizingMaskIntoConstraints = NO;
	[_phoneTypeLabel addLeftConstraintToView:_phoneTypeTitleLabel attribute:NSLayoutAttributeRight relation:NSLayoutRelationEqual constant:kPNPhoneListCell_Padding];
	[_phoneTypeLabel addRightConstraintToView:self.contentView attribute:NSLayoutAttributeRight relation:NSLayoutRelationEqual constant:-kPNPhoneListCell_RightPadding];
	[_phoneTypeLabel addCenterYConstraintToView:_phoneTypeTitleLabel];

}

- (void)setupStatusLabelConstraints
{
	_statusLabel.translatesAutoresizingMaskIntoConstraints = NO;
	[_statusLabel addLeftConstraintToView:self.contentView relation:NSLayoutRelationEqual constant:kPNPhoneListCell_LeftPadding];
	[_statusLabel addTopConstraintToView:self.contentView relation:NSLayoutRelationEqual constant:kPNPhoneListCell_Padding];
	[_statusLabel addWidthConstraintWithRelation:NSLayoutRelationEqual constant:kPNPhoneListCell_TitleLabelWidth];
	[_statusLabel addHeightConstraintWithRelation:NSLayoutRelationEqual constant:20.0f];

}

#pragma mark - Reuse Identifier

+ (NSString *)reuseIdentifier
{
	return NSStringFromClass([self class]);
}

@end
