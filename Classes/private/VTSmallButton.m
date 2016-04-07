//
//  VTSmallButton.m
//  iossdk-gojek
//
//  Created by Nanang Rafsanjani on 3/23/16.
//  Copyright © 2016 Veritrans. All rights reserved.
//

#import "VTSmallButton.h"

@implementation VTSmallButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    CGRect bounds = self.bounds;
    
    //Calculate offsets from buttons bounds
    CGFloat widthDelta = (44. - bounds.size.width) > 0 ? (44. - bounds.size.width) : 0;
    CGFloat heightDelta = (44. - bounds.size.height) > 0 ? (44. - bounds.size.height) : 0;
    bounds = CGRectInset(bounds, -(widthDelta/2.), -(heightDelta/2.));
    
    return CGRectContainsPoint(bounds, point);
}

@end
