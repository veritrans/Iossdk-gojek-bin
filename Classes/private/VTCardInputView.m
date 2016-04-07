//
//  VTCardInputView.m
//  iossdk-gojek
//
//  Created by Nanang Rafsanjani on 3/23/16.
//  Copyright © 2016 Veritrans. All rights reserved.
//

#import "VTCardInputView.h"
#import "JKTextField.h"
#import "VTSmallButton.h"
#import "VTHelper.h"
#import "VTCreditCardHelper.h"

#import "VTCvvInfoViewController.h"
#import "UIViewController+Modal.h"

@interface VTCardInputView()<JKTextFieldDelegate>
@property (strong, nonatomic) IBOutlet JKTextField *numberTextField;
@property (strong, nonatomic) IBOutlet JKTextField *expiryTextField;
@property (strong, nonatomic) IBOutlet JKTextField *cvvTextField;

@end

@implementation VTCardInputView

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

- (void)awakeFromNib {
    _cvvTextField.jkDelegate = self;
}

- (VTCreditCard *)validatedCardWithError:(NSError **)error {
    NSString *cardNumber = [_numberTextField.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    VTCreditCardType type = [VTCreditCardHelper typeWithNumber:cardNumber];
    if (type == VTCreditCardTypeUnknown) {
        *error = [NSError errorWithDomain:ErrorDomain code:0 userInfo:@{NSLocalizedDescriptionKey:@"Please enter valid card number"}];
        return nil;
    }
    
    NSArray *dates = [_expiryTextField.text componentsSeparatedByString:@"/"];
    if ([dates count] != 2) {
        *error = [NSError errorWithDomain:ErrorDomain code:0 userInfo:@{NSLocalizedDescriptionKey:@"Please enter valid expiry date"}];
        return nil;
    }
    NSString *expMonth = dates[0];
    NSString *expYear = dates[1];
    
    if ([_cvvTextField.text length] != 3) {
        *error = [NSError errorWithDomain:ErrorDomain code:0 userInfo:@{NSLocalizedDescriptionKey:@"Please enter valid CVV number"}];
        return nil;
    }
    
    return [VTCreditCard cardWithNumber:cardNumber expiryMonth:expMonth expiryYear:expYear cvv:_cvvTextField.text];
}

- (UIImage *)iconDarkWithNumber:(NSString *)number {
    VTCreditCardType type = [VTCreditCardHelper typeWithNumber:number];
    switch (type) {
        case VTCreditCardTypeVisa:
            return [UIImage imageNamed:@"visaIcon" inBundle:VTBundle compatibleWithTraitCollection:nil];
        case VTCreditCardTypeJCB:
            return [UIImage imageNamed:@"jcbIcon" inBundle:VTBundle compatibleWithTraitCollection:nil];
        case VTCreditCardTypeMasterCard:
            return [UIImage imageNamed:@"masterCardIcon" inBundle:VTBundle compatibleWithTraitCollection:nil];
        case VTCreditCardTypeUnknown:
            return nil;
    }
}

#pragma mark - JKTextFieldDelegate

- (void)textField:(JKTextField *)textField didSelectInfo:(UIButton *)sender {
    VTCvvInfoViewController *guide = [[VTCvvInfoViewController alloc] initWithNibName:@"VTCvvInfoViewController" bundle:VTBundle];
    guide.modalSize = guide.view.bounds.size;
    [[UIApplication rootViewController] presentCustomViewController:guide completion:nil];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if ([textField isEqual:_numberTextField]) {
        [_expiryTextField becomeFirstResponder];
    }
    else if ([textField isEqual:_expiryTextField]) {
        [_cvvTextField becomeFirstResponder];
    }
    else if ([textField isEqual:_cvvTextField]) {
        [self endEditing:YES];
    }
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if ([textField isEqual:_expiryTextField]) {
        return [textField filterCreditCardExpiryDate:string range:range];
    }
    else if ([textField isEqual:_numberTextField]) {
        BOOL shouldChange = [textField filterCreditCardWithString:string range:range];
        if (shouldChange == NO) {
            _numberTextField.imageButton = [self iconDarkWithNumber:[_numberTextField.text stringByReplacingOccurrencesOfString:@" " withString:@""]];
        }
        return shouldChange;
    }
    else if ([textField isEqual:_cvvTextField]) {
        return [textField filterCvvNumber:string range:range];
    }
    else {
        return YES;
    }
}

@end
