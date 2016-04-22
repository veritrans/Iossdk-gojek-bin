//
//  JKTextField.h
//  iossdk-gojek-demo
//
//  Created by Nanang Rafsanjani on 3/23/16.
//  Copyright © 2016 Veritrans. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JKTextFieldDelegate;

@interface JKTextField : UITextField

@property (nonatomic) IBInspectable UIImage *imageIcon;
@property (nonatomic) IBInspectable UIImage *imageButton;
@property (nonatomic) IBInspectable NSString *errorText;
@property (nonatomic) IBInspectable UIColor *underLineColor;
@property (nonatomic) IBInspectable UIColor *underLineActiveColor;

@property (nonatomic, assign) id<JKTextFieldDelegate>jkDelegate;

@end

@protocol JKTextFieldDelegate <NSObject>

- (void)textField:(JKTextField *)textField didSelectInfo:(UIButton *)sender;

@end
