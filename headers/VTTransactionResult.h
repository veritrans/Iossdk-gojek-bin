//
//  VTTransactionResult
//  iossdk-gojek
//
//  Created by Akbar Taufiq Herlangga on 3/15/16.
//  Copyright © 2016 Veritrans. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VTMaskedCreditCard.h"

/**
 Object that represent the successful transaction.
 */
@interface VTTransactionResult : NSObject

/**
 The HTTP status code received from server.
 */
@property(nonatomic, readonly) NSInteger statusCode;

/**
 The server's message about this transaction.
 */
@property(nonatomic, readonly) NSString *statusMessage;

/**
 The transaction ID generated by server.
 */
@property(nonatomic, readonly) NSString *transactionId;

/**
 The resulting transaction status.
 */
@property(nonatomic, readonly) NSString *transactionStatus;

/**
 The date and time when transaction recorded.
 */
@property(nonatomic, readonly) NSDate *transactionTime;

/**
 The order ID for this transaction. This value is generated client-side.
 */
@property(nonatomic, readonly) NSString *orderId;

/**
 Value of gross amount of this transaction.
 */
@property(nonatomic, readonly) NSNumber *grossAmount;

/**
 The type of the payment.
 */
@property(nonatomic, readonly) NSString *paymentType;

/**
 Data holder object that contains various payment-specific data.
 */
@property(nonatomic, readonly) NSDictionary *additionalData;

/**
 Masked card object, will not be nil if doing charge with save card feature enabled
 */
@property(nonatomic, readonly) VTMaskedCreditCard *maskedCreditCard;

///---------------------
/// @name Initialization
///---------------------

/**
 TODO: This should only be used internally.
 */

- (instancetype)initWithTransactionResponse:(NSDictionary *)response;

- (instancetype)initWithStatusCode:(NSInteger)statusCode
                     statusMessage:(NSString *)statusMessage
                     transactionId:(NSString *)transactionId
                 transactionStatus:(NSString *)transactionStatus
                           orderId:(NSString *)orderId
                       paymentType:(NSString *)paymentType
                    additionalData:(NSDictionary *)additionalData;

@end
