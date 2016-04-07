//
//  VTConfig.m
//  iossdk-gojek
//
//  Created by Nanang Rafsanjani on 2/16/16.
//  Copyright © 2016 Veritrans. All rights reserved.
//

#import "VTConfig.h"
#import "VTMerchantClient.h"
#import "Obfuscator/Obfuscator.h"

@interface VTConfig ()
@property (nonatomic, readwrite) NSString *baseUrl;
@property (nonatomic, readwrite) NSString *clientKey;
@property (nonatomic, readwrite) NSString *merchantServerURL;
@property (nonatomic, readwrite) NSString *mixpanelToken;
@end

@implementation VTConfig

- (NSString *)merchantServerURL {
    NSAssert(_merchantServerURL, @"Please set your merchant server URL in VTConfig");
    return _merchantServerURL;
}

- (NSString *)clientKey {
    NSAssert(_clientKey, @"Please set your Veritrans Client Key in VTConfig");
    return _clientKey;
}

+ (id)sharedInstance {
    static VTConfig *shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [[self alloc] init];
    });
    return shared;
}

- (void)setEnvironment:(VTServerEnvironment)environment {
    _environment = environment;
    
#warning obfuscate client key before live in production
    
    switch (environment) {
        case VTServerEnvironmentProduction:
            self.baseUrl = @"https://api.veritrans.co.id/v2";
            
#warning fill all these data before live in production
            self.merchantServerURL = @"";
            self.clientKey = @"";
            self.mixpanelToken = @"cc005b296ca4ce612fe3939177c668bb";
            break;
        case VTServerEnvironmentSandbox:
            self.baseUrl = @"https://api.sandbox.veritrans.co.id/v2";
            self.merchantServerURL = @"http://188.166.243.158/v2";
            self.clientKey = @"VT-client-P15EFHb_Z_ADN8tJ";
            self.mixpanelToken = @"0269722c477a0e085fde32e0248c6003";
            break;
        default:
            break;
    }
}

@end