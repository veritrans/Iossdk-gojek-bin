//
//  VTClient.m
//  iossdk-gojek
//
//  Created by Akbar Taufiq Herlangga on 3/8/16.
//  Copyright © 2016 Veritrans. All rights reserved.
//

#import "VTClient.h"
#import "VTConfig.h"
#import "VTNetworking.h"
#import "VTHelper.h"

@implementation VTClient

+ (id)sharedClient {
    // Idea stolen from http://www.galloway.me.uk/tutorials/singleton-classes/
    static VTClient *instance = nil;
    @synchronized(self) {
        if (instance == nil) {
            instance = [[self alloc] init];
        }
    }
    
    return instance;
}

- (void)generateToken:(VTTokenizeRequest *)tokenizeRequest
           completion:(void (^)(NSString *token, NSError *error))completion {
    NSString *URL = [NSString stringWithFormat:@"%@/%@", [CONFIG baseUrl], @"token"];
    
    [[VTNetworking sharedInstance] getFromURL:URL parameters:[tokenizeRequest dictionaryValue] callback:^(id response, NSError *error) {
        if (error) {
            if (completion) completion(nil, error);
        } else {
            if (completion) completion(response[@"token_id"], nil);
            
        }
    }];
}

- (void)registerCreditCard:(VTCreditCard *)creditCard
                completion:(void (^)(VTMaskedCreditCard *maskedCard, NSError *error))completion {
    NSString *URL = [NSString stringWithFormat:@"%@/%@", [CONFIG baseUrl], @"card/register"];
    
    double year = creditCard.expiryYear.doubleValue + 2000;
    
    NSDictionary *param = @{@"client_key":[CONFIG clientKey],
                            @"card_number":creditCard.number,
                            @"card_exp_month":creditCard.expiryMonth,
                            @"card_exp_year":@(year)};
    
    [[VTNetworking sharedInstance] getFromURL:URL parameters:param callback:^(id response, NSError *error) {
        if (response) {
            VTMaskedCreditCard *maskedCard = [VTMaskedCreditCard maskedCardFromData:response];
            if (completion) completion(maskedCard, error);
        } else {
            if (completion) completion(nil, error);
        }
    }];
}

@end
