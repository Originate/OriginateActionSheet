//
//  OriginateActionSheet.h
//
//  Created by Philip Kluz on 7/27/15.
//  Copyright (c) 2015 Originate. All rights reserved.
//

@import UIKit;

#import "OriginateActionSheetButton.h"

@class OriginateActionSheet;

typedef void(^OriginateActionSheetAppearBlock)(OriginateActionSheet *actionSheet);

@interface OriginateActionSheet : UIView

#pragma mark - Properties
@property (nonatomic, copy, readwrite) OriginateActionSheetAppearBlock actionSheetWillAppearBlock;
@property (nonatomic, copy, readwrite) OriginateActionSheetAppearBlock actionSheetDidAppearBlock;
@property (nonatomic, copy, readwrite) OriginateActionSheetAppearBlock actionSheetWillDisappearBlock;
@property (nonatomic, copy, readwrite) OriginateActionSheetAppearBlock actionSheetDidDisappearBlock;

#pragma mark - Methods
- (void)showInApplicationWindow;
- (void)showInView:(UIView *)view;
- (void)dismiss;
- (void)addButton:(OriginateActionSheetButton *)button;

@end
