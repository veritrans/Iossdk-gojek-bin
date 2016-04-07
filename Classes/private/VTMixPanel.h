//
//  VTMixPanel.h
//  iossdk-gojek
//
//  Created by Nanang Rafsanjani on 4/5/16.
//  Copyright © 2016 Veritrans. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VTTransactionResult.h"

@interface VTMixPanel : NSObject

- (void)startTrack;
- (void)endTrackWithEventSuccess:(VTTransactionResult *)successResult;
- (void)endTrackWithEventError:(NSError *)error;

@end
