//
//  VTWidgetCell.m
//  iossdk-gojek
//
//  Created by Nanang Rafsanjani on 3/22/16.
//  Copyright © 2016 Veritrans. All rights reserved.
//

#import "VTWidgetCell.h"
#import "JKTextField.h"
#import "VTHelper.h"
#import "VTRadioCell.h"
#import "VTCardInputView.h"

#import "VTMerchantClient.h"
#import "VTMaskedCreditCard.h"
#import "VTTokenizeRequest.h"
#import "VTCreditCard.h"
#import "VTClient.h"
#import "VTPaymentCreditCard.h"
#import "VTTransactionDetails.h"
#import "VTTransaction.h"
#import "VTCustomerDetails.h"
#import "VTItem.h"
#import "VTSmallButton.h"
#import "VTMixPanel.h"
#import "VTConfig.h"

@interface VTWidgetCell() < UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UIButton *payNewCardButton;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet VTCardInputView *cardInputView;

@property (nonatomic) IBOutlet NSLayoutConstraint *listHeight;
@property (nonatomic) IBOutlet UIView *listView;
@property (nonatomic) IBOutlet UIView *saveCardView;
@property (nonatomic) IBOutlet NSLayoutConstraint *saveCardHeight;
@property (nonatomic) IBOutlet NSLayoutConstraint *viewTopMargin;

@property (nonatomic) NSArray *savedCards;
@property (nonatomic) NSString *token;

@property (nonatomic, weak) UITableView *containerTableView;

@property (nonatomic) VTMixPanel *mixPanel;

@end

@implementation VTWidgetCell {
    BOOL _inputCardWillShow;
}

+ (instancetype)widgetWithTableView:(__weak UITableView *)tableView
                        environment:(VTServerEnvironment)enviroment
                           andToken:(NSString *)token
{
    [CONFIG setEnvironment:enviroment];
    
    VTWidgetCell *cell = [VTBundle loadNibNamed:@"VTWidgetCell" owner:self options:nil][0];
    cell.token = token;
    cell.containerTableView = tableView;
    cell.mixPanel = [[VTMixPanel alloc] init];
    
    return cell;
}

#define radioCellHeight 40

//- (BOOL)exceptionHandler:(NSExceptionHandler *)sender shouldLogException:(NSException *)exception mask:(unsigned int)mask
//{
//    [self printStackTrace:exception];
//    return YES;
//}

- (void)awakeFromNib {
    // Initialization code

    [_tableView setDelegate:self];
    [_tableView setDataSource:self];
    [_tableView registerNib:[UINib nibWithNibName:@"VTRadioCell" bundle:VTBundle] forCellReuseIdentifier:@"VTRadioCell"];
    
    UIImage *background = [UIImage imageNamed:@"buttonBackground" inBundle:VTBundle compatibleWithTraitCollection:nil];
    [_payNewCardButton setScretchableBackground:background cap:15];
    
    //set default value
    self.yPadding = 8;
    self.enableSavedCard = NO;
    
    _viewTopMargin.constant = _yPadding;
}

- (void)setEnableSavedCard:(BOOL)enableSavedCard {
    _enableSavedCard = enableSavedCard;
    
    if (enableSavedCard) {
        [[VTMerchantClient sharedClient] fetchMerchantAuthDataWithCompletion:^(id response, NSError *error) {
            [CONFIG setMerchantClientData:response];
            
            [[VTMerchantClient sharedClient] fetchMaskedCardsWithCompletion:^(NSArray *maskedCards, NSError *error) {
                __weak VTWidgetCell *wself = self;
                wself.savedCards = maskedCards;
                [self updateSavedCardListHeight];
            }];
        }];
    }
    
    _saveCardHeight.constant = enableSavedCard ? 55 : 0;
    
    [self updateSavedCardListHeight];
}

- (void)updateSavedCardListHeight {
    if ([_savedCards count] == 0) {
        _listHeight.constant = 0;
        [self showInputCardAnimated:NO];
    } else {
        _listHeight.constant = ([_savedCards count] + 1) * radioCellHeight;
        [self hideInputCardAnimated:NO];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (CGFloat)cellHeight {
    [self layoutIfNeeded];
    [self setNeedsLayout];
    
    if (_inputCardWillShow) {
        return CGRectGetMaxY(_saveCardView.frame) + _yPadding;
    } else {
        return CGRectGetMaxY(_payNewCardButton.frame) + _yPadding;
    }
}

- (void)updateTableViewContainerHeight {
    [_containerTableView beginUpdates];
    [_containerTableView endUpdates];
}

- (void)showInputCardAnimated:(BOOL)animated {
    _inputCardWillShow = YES;
    
    [self updateTableViewContainerHeight];
    
    if (animated) {
        _cardInputView.hidden = NO;
        _cardInputView.alpha = 0.0;
        
        [UIView animateWithDuration:0.3 animations:^{
            _payNewCardButton.alpha = 0;
            _cardInputView.alpha = 1.0;
        } completion:^(BOOL finished) {
            _payNewCardButton.hidden = YES;
        }];
    } else {
        _payNewCardButton.hidden = YES;
        _cardInputView.hidden = NO;
    }
}

- (void)hideInputCardAnimated:(BOOL)animated {
    if (_cardInputView.hidden) return;
    
    _inputCardWillShow = NO;
    
    [self updateTableViewContainerHeight];
    
    if (animated) {
        _payNewCardButton.hidden = NO;
        _payNewCardButton.alpha = 0.0;
        
        [UIView animateWithDuration:0.3 animations:^{
            _payNewCardButton.alpha = 1.0;
            _cardInputView.alpha = 0;
        } completion:^(BOOL finished) {
            _cardInputView.hidden = YES;
        }];
    } else {
        _payNewCardButton.hidden = NO;
        _cardInputView.hidden = YES;
    }
}

#pragma mark - IBAction

- (IBAction)saveCardOptionPressed:(UIButton *)sender {
    sender.selected = !sender.selected;
}

- (IBAction)newCardPressed:(UIButton *)sender {
    [_tableView deselectRowAtIndexPath:[_tableView indexPathForSelectedRow] animated:YES];
    [self showInputCardAnimated:YES];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_savedCards count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    VTRadioCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VTRadioCell"];
    cell.maskedCard = _savedCards[indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return radioCellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self hideInputCardAnimated:YES];
}

#pragma mark - Payment

- (void)purchaseItemWithPrice:(NSNumber *)price completion:(void(^)(VTTransactionResult *result, NSError *error))completion {
    
    [_mixPanel startTrack];
    
    NSUncaughtExceptionHandler* usedException = NSGetUncaughtExceptionHandler();
    NSSetUncaughtExceptionHandler(&exceptionHandler);
    
    NSError *error;
    VTCreditCard *creditCard = [_cardInputView validatedCardWithError:&error];
    
    if (error) {
        [_mixPanel endTrackWithEventError:error];
        
        NSSetUncaughtExceptionHandler(usedException);
        
        if (completion) completion(nil, error);
        
        return;
    }
    
    VTTokenizeRequest *tokenRequest = [VTTokenizeRequest tokenForNormalTransactionWithCreditCard:creditCard
                                                                                     grossAmount:price];
    
    [[VTClient sharedClient] generateToken:tokenRequest completion:^(NSString *token, NSError *error) {
        if (token) {
            VTPaymentCreditCard *payDetail = [VTPaymentCreditCard paymentUsingFeature:VTCreditCardPaymentFeatureNormal
                                                                           forTokenId:token];
            VTTransactionDetails *transDetail = [[VTTransactionDetails alloc] initWithGrossAmount:price];
            VTTransaction *trans = [[VTTransaction alloc] initWithPaymentDetails:payDetail transactionDetails:transDetail];
            trans.customField1 = self.token;
            
            [[VTMerchantClient sharedClient] performCreditCardTransaction:trans completion:^(VTTransactionResult *result, NSError *error) {
                
                if (result) {
                    [_mixPanel endTrackWithEventSuccess:result];
                } else {
                    [_mixPanel endTrackWithEventError:error];
                }
                
                NSSetUncaughtExceptionHandler(usedException);
                
                if (completion) completion(result, error);
                
            }];
        }
        else {
            [_mixPanel endTrackWithEventError:error];
            
            NSSetUncaughtExceptionHandler(usedException);
            
            if (completion) completion(nil, error);
        }
    }];
    
}

void exceptionHandler(NSException *exception)
{
    NSArray *stack = [exception callStackReturnAddresses];
    NSLog(@"Stack trace: %@", stack);
}

@end
