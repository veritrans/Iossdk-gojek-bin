//
//  VTRadioCell.m
//  iossdk-gojek
//
//  Created by Nanang Rafsanjani on 3/23/16.
//  Copyright © 2016 Veritrans. All rights reserved.
//

#import "VTRadioCell.h"
#import "VTHelper.h"
#import "VTCreditCardHelper.h"

@interface VTRadioCell()
@property (strong, nonatomic) IBOutlet UIImageView *radioView;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UIImageView *infoView;

@end

@implementation VTRadioCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
    _radioView.image = selected? [UIImage imageNamed:@"radioOn" inBundle:VTBundle compatibleWithTraitCollection:nil] : [UIImage imageNamed:@"radioOff" inBundle:VTBundle compatibleWithTraitCollection:nil];
}

- (void)setMaskedCard:(VTMaskedCreditCard *)maskedCard {
    _maskedCard = maskedCard;
    
    if (!maskedCard) return;
    
    _maskedCard = maskedCard;
    
    _titleLabel.text = [maskedCard.maskedNumber formattedCreditCardNumber];
    
    NSString *iconName = [VTCreditCardHelper typeStringWithNumber:maskedCard.maskedNumber];
    _infoView.image = [UIImage imageNamed:iconName];
}

@end
