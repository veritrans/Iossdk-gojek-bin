//
//  VTNetworkOperation.h
//  iossdk-gojek
//
//  Created by Nanang Rafsanjani on 2/19/16.
//  Copyright © 2016 Veritrans. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VTNetworkOperation : NSOperation

@property (nonatomic, strong) NSString *identifier;

+ (instancetype)operationWithRequest:(NSURLRequest *)request callback:(void(^)(id response, NSError *error))callback;

@end
