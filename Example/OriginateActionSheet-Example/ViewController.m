//
//  ViewController.m
//  OriginateActionSheet-Example
//
//  Created by Philip Kluz on 01/01/16.
//  Copyright © 2016 Originate Inc. All rights reserved.
//

#import "ViewController.h"

#define ACTION_SHOW_IN_WINDOW_TAG 1
#define ACTION_SHOW_IN_VIEW_TAG 2

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CGFloat buttonHeight = 44.0;
    CGFloat buttonWidth = 220.0;
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame = CGRectMake(CGRectGetMidX(self.view.bounds) - (buttonWidth / 2.0),
                               CGRectGetMidY(self.view.bounds) - (buttonHeight / 2.0) - 3.0,
                               buttonWidth,
                               buttonHeight);
    button1.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.35];
    button1.tag = ACTION_SHOW_IN_WINDOW_TAG;
    [button1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button1 setTitle:@"Show Full Screen" forState:UIControlStateNormal];
    [button1 addTarget:self
                action:@selector(showActionSheet:)
      forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:button1];
    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    button2.frame = CGRectMake(CGRectGetMidX(self.view.bounds) - (buttonWidth / 2.0),
                               CGRectGetMidY(self.view.bounds) + (buttonHeight / 2.0) + 3.0,
                               buttonWidth,
                               buttonHeight);
    button2.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.35];
    [button2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button2 setTitle:@"Show In View" forState:UIControlStateNormal];
    button2.tag = ACTION_SHOW_IN_VIEW_TAG;
    [button2 addTarget:self
                action:@selector(showActionSheet:)
      forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:button2];
}

- (void)showActionSheet:(UIButton *)sender
{
    BOOL showInWindow = sender.tag == ACTION_SHOW_IN_WINDOW_TAG;
    
    OriginateActionSheet *sheet = [[OriginateActionSheet alloc] init];
    
    OriginateActionSheetButton *helloButton = [[OriginateActionSheetButton alloc] initWithTitle:@"Hello There!"
                                                                                           type:OriginateActionSheetButtonTypeDefault
                                                                                        command:nil];
    OriginateActionSheetButton *cancelButton = [[OriginateActionSheetButton alloc] initWithTitle:@"No, Cancel"
                                                                                            type:OriginateActionSheetButtonTypeCancel
                                                                                         command:nil];
    OriginateActionSheetButton *deleteButton = [[OriginateActionSheetButton alloc] initWithTitle:@"Yes, Delete Something"
                                                                                            type:OriginateActionSheetButtonTypeDestructive
                                                                                         command:nil];
    
    [sheet addButton:helloButton];
    [sheet addButton:cancelButton];
    [sheet addButton:deleteButton];
    
    if (showInWindow) {
        [sheet showInApplicationWindow];
    } else {
        [sheet showInView:self.view];
    }
}

@end
