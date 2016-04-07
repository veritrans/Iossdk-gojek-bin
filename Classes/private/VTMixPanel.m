//
//  VTMixPanel.m
//  iossdk-gojek
//
//  Created by Nanang Rafsanjani on 4/5/16.
//  Copyright © 2016 Veritrans. All rights reserved.
//

#import "VTMixPanel.h"
#import "VTHelper.h"
#import "VTNetworking.h"
#import "VTConfig.h"

@implementation VTMixPanel {
    NSDate *startDate;
}

- (void)startTrack {
    startDate = [NSDate date];
    
}

- (NSUUID *)deviceUUID {
    NSUUID *uuid;
#if TARGET_OS_SIMULATOR
    uuid = [[NSUUID alloc] initWithUUIDString:@"E621E1F8-C36C-495A-93FC-0C247A3E6E5F"];
#else
    uuid = [UIDevice currentDevice].identifierForVendor;
#endif
    
    return uuid;
}

- (NSDictionary *)properties {
    NSDate *now = [NSDate date];
    long interval = [now timeIntervalSinceDate:startDate] * 1000;
    return @{@"Response Time":@(interval),
             @"token":[CONFIG mixpanelToken],
             @"Platform":@"iOS",
             @"Device ID":[self deviceUUID].UUIDString,
             @"Merchant":@"Go-Jek",
             @"SDK Version":VERSION,
             @"Payment Type":@"cc"};
}

- (void)endTrackWithEventSuccess:(VTTransactionResult *)successResult {

    NSDictionary *event = @{@"event":@"Transaction Success",
                            @"properties":[self properties]};
    NSData *decoded = [NSJSONSerialization dataWithJSONObject:event options:NSJSONWritingPrettyPrinted error:nil];
    NSString *base64String = [decoded base64EncodedStringWithOptions:0];
    
    NSString *URL = @"https://api.mixpanel.com/track";
    NSDictionary *parameter = @{@"data":base64String};
    
    [[VTNetworking sharedInstance] getFromURL:URL parameters:parameter callback:nil];
}

- (void)endTrackWithEventError:(NSError *)error {
    NSMutableDictionary *properties = [NSMutableDictionary dictionaryWithDictionary:[self properties]];
    properties[@"Error Message"] = error.localizedDescription;
    
    NSDictionary *event = @{@"event":@"Transaction Failed",
                            @"properties":properties};
    NSData *decoded = [NSJSONSerialization dataWithJSONObject:event options:NSJSONWritingPrettyPrinted error:nil];
    NSString *base64String = [decoded base64EncodedStringWithOptions:0];
    
    NSString *URL = @"https://api.mixpanel.com/track";
    NSDictionary *parameter = @{@"data":base64String};
    
    [[VTNetworking sharedInstance] getFromURL:URL parameters:parameter callback:nil];
}

@end
