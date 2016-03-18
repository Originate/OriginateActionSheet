//
//  OriginateActionSheetButton.m
//
//  Created by Philip Kluz on 7/27/15.
//  Copyright (c) 2015 Originate. All rights reserved.
//

#import "OriginateActionSheetButton.h"
#import "OriginateActionSheet.h"

@interface OriginateActionSheetButton ()

#pragma mark - Properties
@property (nonatomic, assign, readwrite) OriginateActionSheetButtonType type;

@end

@implementation OriginateActionSheetButton

#pragma mark - OriginateActionSheetButton

- (instancetype)initWithTitle:(NSString *)title
                         type:(OriginateActionSheetButtonType)type
                      command:(OriginateActionSheetButtonCommand)command
{
    self = [super init];
    
    if (self) {
        [self setTitle:title forState:UIControlStateNormal];
        [self addTarget:self action:@selector(executeCommand:) forControlEvents:UIControlEventTouchUpInside];
        
        _type = type;
        _command = command;
        
        [self setupButtonForType:type];
    }
    
    return self;
}

- (void)setupButtonForType:(OriginateActionSheetButtonType)type
{
    self.titleFont = [UIFont boldSystemFontOfSize:16.0];
    
    switch (type) {
        case OriginateActionSheetButtonTypeCancel: {
            self.titleColor = [UIColor colorWithRed:213.0/255.0 green:27.0/255.0 blue:30.0/255.0 alpha:1.0];
            self.selectedTitleColor = self.titleColor;
            self.highlightedTitleColor = self.titleColor;
            
            self.normalBackgroundColor = [UIColor colorWithRed:240.0/255.0 green:240.0/255.0 blue:240.0/255.0 alpha:1.0];
            self.selectedBackgroundColor = [UIColor colorWithRed:200.0/255.0 green:200.0/255.0 blue:200.0/255.0 alpha:1.0];
            self.highlightedBackgroundColor = [UIColor colorWithRed:200.0/255.0 green:200.0/255.0 blue:200.0/255.0 alpha:1.0];
        }
            break;
            
        case OriginateActionSheetButtonTypeDestructive: {
            self.titleColor = [UIColor whiteColor];
            self.selectedTitleColor = self.titleColor;
            self.highlightedTitleColor = self.titleColor;
            
            self.normalBackgroundColor = [UIColor colorWithRed:213.0/255.0 green:27.0/255.0 blue:30.0/255.0 alpha:1.0];
            self.selectedBackgroundColor = [UIColor colorWithRed:173.0/255.0 green:25.0/255.0 blue:28.0/255.0 alpha:1.0];
            self.highlightedBackgroundColor = [UIColor colorWithRed:173.0/255.0 green:25.0/255.0 blue:28.0/255.0 alpha:1.0];
        }
            break;
            
        case OriginateActionSheetButtonTypeDefault: {
            self.titleColor = [UIColor darkGrayColor];
            self.selectedTitleColor = [UIColor whiteColor];
            self.highlightedTitleColor = self.selectedTitleColor;
            
            self.normalBackgroundColor = [UIColor colorWithRed:240.0/255.0 green:240.0/255.0 blue:240.0/255.0 alpha:1.0];
            self.selectedBackgroundColor = [UIColor colorWithRed:220.0/255.0 green:220.0/255.0 blue:220.0/255.0 alpha:1.0];
            self.highlightedBackgroundColor = [UIColor colorWithRed:220.0/255.0 green:220.0/255.0 blue:220.0/255.0 alpha:1.0];
        }
            break;
            
        default:
            break;
    }
    
    self.backgroundColor = self.normalBackgroundColor;
}

- (void)executeCommand:(id)sender
{
    [self.actionSheet dismiss];
    
    if (self.command) {
        self.command(self);
    }
}

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    
    if (selected) {
        self.backgroundColor = self.selectedBackgroundColor;
    }
    else if (self.isHighlighted) {
        self.backgroundColor = self.highlightedBackgroundColor;
    }
    else {
        self.backgroundColor = self.normalBackgroundColor;
    }
}

- (void)setHighlighted:(BOOL)highlighted
{
    [super setHighlighted:highlighted];
    
    if (highlighted) {
        self.backgroundColor = self.selectedBackgroundColor;
    }
    else if (self.isSelected) {
        self.backgroundColor = self.highlightedBackgroundColor;
    }
    else {
        self.backgroundColor = self.normalBackgroundColor;
    }
}

- (UIFont *)titleFont
{
    return self.titleLabel.font;
}

- (void)setTitleFont:(UIFont *)titleFont
{
    self.titleLabel.font = titleFont;
}

- (void)setTitleColor:(UIColor *)titleColor
{
    [self setTitleColor:titleColor forState:UIControlStateNormal];
}

- (UIColor *)titleColor
{
    return [self titleColorForState:UIControlStateNormal];
}

- (void)setSelectedTitleColor:(UIColor *)selectedTitleColor
{
    [self setTitleColor:selectedTitleColor forState:UIControlStateSelected];
}

- (UIColor *)selectedTitleColor
{
    return [self titleColorForState:UIControlStateSelected];
}

- (void)setHighlightedTitleColor:(UIColor *)highlightedTitleColor
{
    [self setTitleColor:highlightedTitleColor forState:UIControlStateHighlighted];
}

- (UIColor *)highlightedTitleColor
{
    return [self titleColorForState:UIControlStateHighlighted];
}

@end
