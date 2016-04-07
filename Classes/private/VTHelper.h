//
//  VTHelper.h
//  iossdk-gojek
//
//  Created by Nanang Rafsanjani on 3/23/16.
//  Copyright © 2016 Veritrans. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Obfuscator.h"

@interface UIButton (utilities)
- (void)setScretchableBackground:(UIImage *)background cap:(NSInteger)cap;
@end

extern NSString *const VTMaskedCardsUpdated;
extern NSString *const ErrorDomain;

@interface VTHelper : NSObject

#define VTBundle [VTHelper kitBundle]
+ (NSBundle*)kitBundle;

+ (id)nullifyIfNil:(id)object;
@end

@interface NSArray (item)
- (NSArray *)itemsRequestData;
- (NSNumber *)itemsPriceAmount;
@end

@interface NSString (random)
- (BOOL)isNumeric;
+ (NSString *)randomWithLength:(NSUInteger)length;
- (NSString *)formattedCreditCardNumber;
@end

@interface UIApplication (utilities)
+ (UIViewController *)rootViewController;
@end

@interface NSMutableDictionary (utilities)
- (id)objectThenDeleteForKey:(NSString *)key;
@end


@interface NSObject (utilities)
+ (NSNumberFormatter *)numberFormatterWith:(NSString *)identifier;
+ (NSDateFormatter *)dateFormatterWithIdentifier:(NSString *)identifier;
@end

@interface UITextField (helper)
- (BOOL)filterCreditCardWithString:(NSString *)string range:(NSRange)range;
- (BOOL)filterCvvNumber:(NSString *)string range:(NSRange)range;
- (BOOL)filterCreditCardExpiryDate:(NSString *)string range:(NSRange)range;
@end