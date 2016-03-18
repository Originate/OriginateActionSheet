//
//  OriginateActionSheet.m
//
//  Created by Philip Kluz on 7/27/15.
//  Copyright (c) 2015 Originate. All rights reserved.
//

#import "OriginateActionSheet.h"
#import "OriginateActionSheetButton.h"

@interface OriginateActionSheet ()

#pragma mark - Properties
@property (nonatomic, strong, readwrite) NSMutableArray *buttons;
@property (nonatomic, strong, readwrite) OriginateActionSheetButton *cancelButton;
@property (nonatomic, strong, readwrite) UIView *buttonsContainerView;
@property (nonatomic, strong, readwrite) UIView *maskBackgroundView;

@end

@implementation OriginateActionSheet

static CGFloat const OriginateActionSheetButtonHeight = 55.0;
static CGFloat const OriginateActionSheetCancelButtonMargin = 5.0;
static CGFloat const OriginateShowAnimationDuration = 0.45;
static CGFloat const OriginateDismissAnimationDuration = 0.25;
static CGFloat const OriginateAnimationSpringDamping = 0.8;

#pragma mark - OriginateActionSheet

- (instancetype)init
{
    self = [super initWithFrame:CGRectZero];
    
    if (self) {
        self.userInteractionEnabled = YES;
        self.buttons = [NSMutableArray array];
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                     action:@selector(didTapView:)];
        [self addGestureRecognizer:tapGesture];
    }
    
    return self;
}

- (void)didMoveToSuperview
{
    self.frame = self.superview.bounds;
    CGRect bounds = self.bounds;
    
    self.maskBackgroundView.frame = bounds;
    
    CGFloat buttonYCoor = 0.0;
    CGFloat buttonWidth = bounds.size.width;
    CGFloat buttonXCoor = floorf(bounds.size.width / 2.0 - buttonWidth / 2.0);
    
    for (OriginateActionSheetButton *button in self.buttons) {
        button.frame = CGRectMake(buttonXCoor, buttonYCoor, buttonWidth, OriginateActionSheetButtonHeight);
        buttonYCoor = CGRectGetMaxY(button.frame);
    }
    
    self.buttonsContainerView.frame = CGRectMake(0.0, bounds.size.height, bounds.size.width, buttonYCoor);
    self.cancelButton.frame = CGRectMake(buttonXCoor,
                                         CGRectGetMaxY(self.buttonsContainerView.frame) + OriginateActionSheetCancelButtonMargin,
                                         buttonWidth,
                                         OriginateActionSheetButtonHeight);
}

- (void)showInApplicationWindow
{
    UIWindow *mainWindow = [[[UIApplication sharedApplication] delegate] window];
    [self showInView:mainWindow pushBack:YES];
}

- (void)showInView:(UIView *)view
{
    [self showInView:view pushBack:NO];
}

- (void)showInView:(UIView *)view pushBack:(BOOL)push
{
    [self addSubview:self.maskBackgroundView];
    
    [self.buttons enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [self.buttonsContainerView addSubview:obj];
    }];
    
    [self addSubview:self.buttonsContainerView];
    
    if (self.cancelButton) {
        [self addSubview:self.cancelButton];
    }
    
    if (self.actionSheetWillAppearBlock) {
        self.actionSheetWillAppearBlock(self);
    }
    
    [view addSubview:self];
    
    CGFloat buttonContainerLastYCoor = CGRectGetHeight(self.frame) - (CGRectGetHeight(self.buttonsContainerView.frame) + CGRectGetHeight(self.cancelButton.frame) + (OriginateActionSheetCancelButtonMargin * 2.0));
    
    if (self.actionSheetWillAppearBlock) {
        self.actionSheetWillAppearBlock(self);
    }
    
    [UIView animateWithDuration:OriginateShowAnimationDuration
                          delay:0.0
         usingSpringWithDamping:OriginateAnimationSpringDamping
          initialSpringVelocity:1.0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         if (push) {
                             UIViewController *root = [[[[UIApplication sharedApplication] delegate] window] rootViewController];
                             root.view.transform = CGAffineTransformMakeScale(0.9, 0.9);
                         }
                         
                         self.maskBackgroundView.alpha = 0.5;
                         
                         CGRect frame = self.buttonsContainerView.frame;
                         frame.origin.y = buttonContainerLastYCoor;
                         self.buttonsContainerView.frame = frame;
                     }
                     completion:nil];
    
    CGFloat cancelButtonLastYCoor = CGRectGetHeight(self.frame) - (CGRectGetHeight(self.cancelButton.frame) + OriginateActionSheetCancelButtonMargin);
    
    [UIView animateWithDuration:OriginateShowAnimationDuration
                          delay:0.15
         usingSpringWithDamping:OriginateAnimationSpringDamping
          initialSpringVelocity:1.0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         CGRect frame = self.cancelButton.frame;
                         frame.origin.y = cancelButtonLastYCoor;
                         self.cancelButton.frame = frame;
                     }
                     completion:^(BOOL finished) {
                         if (self.actionSheetDidAppearBlock) {
                             self.actionSheetDidAppearBlock(self);
                         }
                     }];
}

- (void)dismiss
{
    self.userInteractionEnabled = NO;
    
    if (self.actionSheetWillDisappearBlock) {
        self.actionSheetWillDisappearBlock(self);
    }
    
    CGFloat yCoorDifferenceBetweenContainerAndCancelButton = ABS(self.buttonsContainerView.frame.origin.y - self.cancelButton.frame.origin.y);
    
    [UIView animateWithDuration:OriginateDismissAnimationDuration
                     animations:^{
                         UIViewController *root = [[[[UIApplication sharedApplication] delegate] window] rootViewController];
                         root.view.transform = CGAffineTransformIdentity;
                         
                         CGRect buttonContainerFrame = self.buttonsContainerView.frame;
                         buttonContainerFrame.origin.y = CGRectGetHeight(self.frame);
                         
                         CGRect cancelButtonFrame = self.cancelButton.frame;
                         cancelButtonFrame.origin.y = buttonContainerFrame.origin.y + yCoorDifferenceBetweenContainerAndCancelButton;
                         
                         self.buttonsContainerView.frame = buttonContainerFrame;
                         self.cancelButton.frame = cancelButtonFrame;
                     }
                     completion:^(BOOL finished) {
                         self.backgroundColor = [UIColor clearColor];
                     }];
    
    [UIView animateWithDuration:OriginateDismissAnimationDuration + 0.1
                     animations:^{
                         self.maskBackgroundView.alpha = 0.0;
                     }
                     completion:^(BOOL finished) {
                         if (self.actionSheetDidDisappearBlock) {
                             self.actionSheetDidDisappearBlock(self);
                         }
                         
                         [self removeFromSuperview];
                     }];
}

- (OriginateActionSheetButton *)destructiveButton
{
    if ([self.buttons count] > 0) {
        OriginateActionSheetButton *button = self.buttons[0];
        if (button.type == OriginateActionSheetButtonTypeDestructive) {
            return button;
        }
    }
    
    return nil;
}

- (void)addButton:(OriginateActionSheetButton *)button
{
    button.actionSheet = self;
    if (button.type == OriginateActionSheetButtonTypeDestructive) {
        [self.buttons insertObject:button atIndex:0];
    }
    else if (button.type == OriginateActionSheetButtonTypeCancel) {
        self.cancelButton = button;
    }
    else {
        [self.buttons addObject:button];
    }
}

- (void)didTapView:(UITapGestureRecognizer *)recognizer
{
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        [self dismiss];
    }
}

- (UIView *)maskBackgroundView
{
    if (!_maskBackgroundView) {
        _maskBackgroundView = [[UIView alloc] init];
        _maskBackgroundView.backgroundColor = [UIColor blackColor];
        _maskBackgroundView.alpha = 0.0;
    }
    
    return _maskBackgroundView;
}

- (UIView *)buttonsContainerView
{
    if (!_buttonsContainerView) {
        _buttonsContainerView = [[UIView alloc] init];
    }
    
    return _buttonsContainerView;
}

@end
