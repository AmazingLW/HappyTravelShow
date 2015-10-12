//  ddlt
//
//  Created by yxlong on 15/7/27.
//  Copyright (c) 2015年 QQ:854072335. All rights reserved.
//

#import "XIGridBackgroundView.h"
#import "XIDropdownlistViewProtocol.h"
#import "XIButton.h"

@interface XIOptionSelectorView : XIGridBackgroundView

@property(nonatomic, assign) NSInteger selectedItemIndex;
@property(nonatomic, weak) UIView *parentView;
@property(nonatomic, copy) UIView<XIDropdownlistViewProtocol>*(^viewAtIndex)(NSInteger index, __weak XIOptionSelectorView*optionSelectorView);

- (void)setTitle:(NSString *)title forItem:(NSInteger)itemIndex;
- (void)closeView;
@end

@interface XISelectorItem : XIButton
@end


