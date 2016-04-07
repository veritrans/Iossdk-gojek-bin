//
//  VTWidgetCell.h
//  iossdk-gojek
//
//  Created by Nanang Rafsanjani on 3/22/16.
//  Copyright © 2016 Veritrans. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "VTTransactionResult.h"
#import "VTEnvironment.h"

@interface VTWidgetCell : UITableViewCell

@property (nonatomic) CGFloat yPadding;
@property (nonatomic) BOOL enableSavedCard;

+ (instancetype)widgetWithTableView:(__weak UITableView *)tableView
                        environment:(VTServerEnvironment)enviroment
                           andToken:(NSString *)token;

- (CGFloat)cellHeight;

- (void)purchaseItemWithPrice:(NSNumber *)price completion:(void(^)(VTTransactionResult *result, NSError *error))completion;

@end
