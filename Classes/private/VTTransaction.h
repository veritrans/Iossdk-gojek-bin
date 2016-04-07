//
//  VTTransactionData.h
//  iossdk-gojek
//
//  Created by Akbar Taufiq Herlangga on 3/3/16.
//  Copyright © 2016 Veritrans. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "VTPaymentDetails.h"
#import "VTTransactionDetails.h"
#import "VTCustomerDetails.h"
#import "VTItem.h"

/**
 VTTransaction contains aggregated data needed to do a transaction.
 
 There are two mandatory fields here: `paymentDetails` and `transactionDetails`. The rest are optional.
 */
@interface VTTransaction : NSObject

/**
 The payment details. This object contains payment-specific data. Each payment type has its own data structure.
 */
@property (nonatomic, readonly) id<VTPaymentDetails> paymentDetails;

/**
 The transaction's data/information.
 */
@property (nonatomic, readonly) VTTransactionDetails *transactionDetails;

/**
 The information about the credit card's owner.
 */
@property (nonatomic) VTCustomerDetails *customerDetails;

/**
 The details about purchased items.
 */
@property (nonatomic) NSArray<VTItem*> *itemDetails;

/**
 Set the value for the first custom field. The label for this field can be set in MAP.
 */
@property (nonatomic) NSString *customField1;

/**
 Set the value for the second custom field. The label for this field can be set in MAP.
 */
@property (nonatomic) NSString *customField2;

/**
 Set the value for the third custom field. The label for this field can be set in MAP.
 */
@property (nonatomic) NSString *customField3;

- (instancetype)initWithPaymentDetails:(id<VTPaymentDetails>)paymentDetails
                    transactionDetails:(VTTransactionDetails *)transactionDetails;

- (instancetype)initWithPaymentDetails:(id<VTPaymentDetails>)paymentDetails
                    transactionDetails:(VTTransactionDetails *)transactionDetails
                       customerDetails:(VTCustomerDetails *)customerDetails
                           itemDetails:(NSArray<VTItem*> *)itemDetails;

- (NSDictionary *)dictionaryValue;

@end
