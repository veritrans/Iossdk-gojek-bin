//
//  VTWidgetCell.h
//  iossdk-gojek
//
//  Created by Nanang Rafsanjani on 3/22/16.
//  Copyright © 2016 Veritrans. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <objc/runtime.h>

#import "VTTransactionResult.h"
#import "VTEnvironment.h"
#import "VTItemDetail.h"
#import "VTCustomerDetails.h"
#import "VTTransactionDetails.h"

@protocol VTWidgetCellDelegate;

@interface VTWidgetCell : UITableViewCell

@property (nonatomic) BOOL enableSaveCardFeature;
@property (nonatomic, assign) id<VTWidgetCellDelegate>delegate;

- (instancetype)initWithTableView:(__weak UITableView *)tableView
                      environment:(VTServerEnvironment)environment
                      merchantURL:(NSString *)merchantURL
                   enableSaveCard:(BOOL)enableSaveCard
                            token:(NSString *)token;

- (void)setHeaderAuth:(NSDictionary *)headerAuth;

- (void)reset;

- (CGFloat)cellHeight;

- (void)payWithTransactionDetails:(VTTransactionDetails *)transactionDetails
                  customerDetails:(VTCustomerDetails *)customerDetails
                      itemDetails:(NSArray <VTItemDetail *>*)itemDetails;

@end

@protocol VTWidgetCellDelegate <NSObject>

- (void)widget:(VTWidgetCell *)widget didPaymentSuccess:(VTTransactionResult *)result;
- (void)widget:(VTWidgetCell *)widget didPaymentError:(NSError *)error;

@end
