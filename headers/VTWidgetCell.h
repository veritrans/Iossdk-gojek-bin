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

@interface VTWidgetCell : UITableViewCell

@property (nonatomic) BOOL enableSaveCardFeature;

- (instancetype)initWithTableView:(__weak UITableView *)tableView
                      environment:(VTServerEnvironment)environment
                      merchantURL:(NSString *)merchantURL
                   enableSaveCard:(BOOL)enableSaveCard
                            token:(NSString *)token;

- (void)setHeaderAuth:(NSDictionary *)headerAuth;

- (CGFloat)cellHeight;

- (void)payWithTransactionDetails:(VTTransactionDetails *)transactionDetails
                  customerDetails:(VTCustomerDetails *)customerDetails
                      itemDetails:(NSArray <VTItemDetail *>*)itemDetails
                       completion:(void (^)(VTTransactionResult *result, NSError *error))completion;

@end
