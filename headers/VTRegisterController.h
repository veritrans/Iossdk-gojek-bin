//
//  VTRegisterController.h
//  iossdk-gojek
//
//  Created by Nanang Rafsanjani on 4/19/16.
//  Copyright © 2016 Veritrans. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VTEnvironment.h"
#import "VTMaskedCreditCard.h"

@protocol VTRegisterControllerDelegate;

@interface VTRegisterController : UIViewController
@property (nonatomic, assign) id<VTRegisterControllerDelegate>delegate;
- (instancetype)initWithEnvironment:(VTServerEnvironment)environment merchantURL:(NSString *)merchantURL;
@end

@protocol VTRegisterControllerDelegate <NSObject>
- (void)viewController:(VTRegisterController *)controller registerSucceed:(VTMaskedCreditCard *)maskedCard;
- (void)viewController:(VTRegisterController *)controller registerError:(NSError *)error;
@end
