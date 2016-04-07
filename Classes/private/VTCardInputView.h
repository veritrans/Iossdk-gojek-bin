//
//  VTCardInputView.h
//  iossdk-gojek
//
//  Created by Nanang Rafsanjani on 3/23/16.
//  Copyright © 2016 Veritrans. All rights reserved.
//

#import "VTXibView.h"
#import "VTCreditCard.h"

@interface VTCardInputView : VTXibView

- (VTCreditCard *)validatedCardWithError:(NSError **)error;

@end
