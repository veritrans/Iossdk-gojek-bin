//
//  VTItem.h
//  iossdk-gojek
//
//  Created by Nanang Rafsanjani on 2/16/16.
//  Copyright © 2016 Veritrans. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VTItemDetail : NSObject

@property(nonatomic, readonly) NSString* itemId;
@property(nonatomic, readonly) NSNumber *price;
@property(nonatomic, readonly) NSNumber *quantity;
@property(nonatomic, readonly) NSString* name;

- (instancetype)initWithItemID:(NSString *)itemID
                          name:(NSString *)name
                         price:(NSNumber *)price
                      quantity:(NSNumber *)quantity;

- (NSDictionary *)dictionaryValue;

@end
