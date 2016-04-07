//
//  JKTextField.m
//  iossdk-gojek-demo
//
//  Created by Nanang Rafsanjani on 3/23/16.
//  Copyright © 2016 Veritrans. All rights reserved.
//

#import "JKTextField.h"
#import "VTSmallButton.h"

#define InfoWidth 30.0f

@interface JKTextField()
@property (nonatomic) UIImageView *jkIconView;
@property (nonatomic) VTSmallButton *jkInfoButton;
@property (nonatomic) UIView *jkUnderline;
@end

@implementation JKTextField

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    _jkIconView = [UIImageView new];
    _jkIconView.contentMode = UIViewContentModeCenter;
    [self addSubview:_jkIconView];
    
    _jkInfoButton = [VTSmallButton buttonWithType:UIButtonTypeCustom];
    [_jkInfoButton addTarget:self action:@selector(infoPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_jkInfoButton];
    
    _jkUnderline = [UIView new];
    [self addSubview:_jkUnderline];
}

- (void)setImageIcon:(UIImage *)imageIcon {
    _imageIcon = imageIcon;
    _jkIconView.image = imageIcon;
}

- (void)setImageButton:(UIImage *)imageButton {
    _imageButton = imageButton;
    [_jkInfoButton setImage:imageButton forState:UIControlStateNormal];
    [self setNeedsLayout];
}

- (CGRect)textRectForBounds:(CGRect)bounds
{
    CGRect rect = [super textRectForBounds:bounds];
    rect = [self insetRectForBounds:rect];
    return CGRectIntegral(rect);
}

- (CGRect)editingRectForBounds:(CGRect)bounds
{
    CGRect rect = [super editingRectForBounds:bounds];
    rect = [self insetRectForBounds:rect];
    return CGRectIntegral(rect);
}

- (CGRect)insetRectForBounds:(CGRect)rect
{
    CGFloat x = CGRectGetWidth([self iconRect]) + 8;
    return CGRectMake(x,
                      rect.origin.y,
                      rect.size.width - (x + CGRectGetWidth([self infoRect])),
                      rect.size.height);
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGRect rect = self.bounds;
    
    _jkIconView.frame = [self iconRect];
    
    _jkUnderline.frame = CGRectMake(CGRectGetWidth([self iconRect])+8, CGRectGetHeight(rect)-1.0, CGRectGetWidth(rect), 1.0);
    
    _jkInfoButton.frame = [self infoRect];
    
    _jkUnderline.backgroundColor = self.isFirstResponder ? _underLineActiveColor : _underLineColor;
}

- (CGRect)iconRect {
    CGSize size = _imageIcon.size;
    CGRect fieldRect = self.bounds;
    return CGRectMake(CGRectGetMinX(fieldRect), CGRectGetMidY(fieldRect)-(size.height/2.0), size.width, size.height);
}

- (CGRect)infoRect {
    CGSize size = _imageButton.size;
    CGRect fieldRect = self.bounds;
    return CGRectMake(CGRectGetMaxX(fieldRect)-size.width, CGRectGetMidY(fieldRect)-(size.height/2.0), size.width, size.height);
}

- (void)infoPressed:(UIButton *)sender {
    if ([_jkDelegate respondsToSelector:@selector(textField:didSelectInfo:)]) {
        [_jkDelegate textField:self didSelectInfo:sender];
    }
}

@end
