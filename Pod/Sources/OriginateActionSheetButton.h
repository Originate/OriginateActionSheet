//
//  OriginateActionSheetButton.h
//
//  Created by Philip Kluz on 7/27/15.
//  Copyright (c) 2015 Originate. All rights reserved.
//

@import UIKit;

typedef NS_ENUM(NSUInteger, OriginateActionSheetButtonType)
{
    OriginateActionSheetButtonTypeDefault,
    OriginateActionSheetButtonTypeCancel,
    OriginateActionSheetButtonTypeDestructive
};

@class OriginateActionSheet;
@class OriginateActionSheetButton;

typedef void(^OriginateActionSheetButtonCommand)(OriginateActionSheetButton *);

@interface OriginateActionSheetButton : UIButton

#pragma mark - Properties
@property (nonatomic, assign, readonly) OriginateActionSheetButtonType type;

@property (nonatomic, copy, readwrite) OriginateActionSheetButtonCommand command;

@property (nonatomic, strong, readwrite) UIColor *normalBackgroundColor;
@property (nonatomic, strong, readwrite) UIColor *selectedBackgroundColor;
@property (nonatomic, strong, readwrite) UIColor *highlightedBackgroundColor;

@property (nonatomic, strong, readwrite) UIColor *titleColor;
@property (nonatomic, strong, readwrite) UIColor *selectedTitleColor;
@property (nonatomic, strong, readwrite) UIColor *highlightedTitleColor;

@property (nonatomic, strong, readwrite) UIFont *titleFont;

@property (nonatomic, weak, readwrite) OriginateActionSheet *actionSheet;

#pragma mark - Methods
- (instancetype)initWithTitle:(NSString *)title
                         type:(OriginateActionSheetButtonType)type
                      command:(OriginateActionSheetButtonCommand)command;

@end
