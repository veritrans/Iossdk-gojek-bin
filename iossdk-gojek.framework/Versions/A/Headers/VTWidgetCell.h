//
//  VTWidgetCell.h
//  iossdk-gojek
//
//  Created by Nanang Rafsanjani on 3/22/16.
//  Copyright © 2016 Veritrans. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VTTransactionResult.h"

@interface VTWidgetCell : UITableViewCell

@property (nonatomic) CGFloat yPadding;
@property (nonatomic) BOOL enableSavedCard;

+ (instancetype)widgetWithTableView:(__weak UITableView *)tableView
                           andToken:(NSString *)token;

- (CGFloat)cellHeight;

- (void)purchaseItemWithPrice:(NSNumber *)price completion:(void(^)(VTTransactionResult *result, NSError *error))completion;

@end
