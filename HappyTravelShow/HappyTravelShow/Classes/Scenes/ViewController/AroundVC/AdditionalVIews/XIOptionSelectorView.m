//  ddlt
//
//  Created by yxlong on 15/7/27.
//  Copyright (c) 2015年 QQ:854072335. All rights reserved.
//

#import "XIOptionSelectorView.h"
#import "XIButton.h"
#import "XIColorHelper.h"
#import "FXBlurView.h"

@interface ALOverlayView : UIView
{
    @private
    FXBlurView *blurView;
    UIButton *overlayButton;
}
@property(nonatomic, strong) FXBlurView *blurView;
@property(nonatomic, copy) void(^pressDownBlock)(void);
@end

@implementation ALOverlayView
@synthesize blurView;

- (instancetype)initWithFrame:(CGRect)frame
{
    if(self=[super initWithFrame:frame]){
        
        blurView = [[FXBlurView alloc] initWithFrame:self.bounds];
        blurView.blurRadius = 12;
        blurView.tintColor = [UIColor blackColor];
        blurView.dynamic = NO;
        [self addSubview:blurView];
        blurView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
        
        overlayButton = [[UIButton alloc] initWithFrame:blurView.frame];
        overlayButton.autoresizingMask = blurView.autoresizingMask;
        overlayButton.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
        [self addSubview:overlayButton];
        [overlayButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)buttonAction:(id)sender
{
    if(_pressDownBlock){
        _pressDownBlock();
    }
}

@end


// Implementation of XISelectorItem

@implementation XISelectorItem

+ (instancetype)createItemButtonWithType:(XIContentAlign)type
{
    XIButton *btn = [super createItemButtonWithType:type];
    if(btn){
        btn.preferedFont = [UIFont systemFontOfSize:15.0f];
        [btn setTitleColor:[UIColor opaqueColorWithRGBBytes:0x8d91a0] forState:UIControlStateNormal];
        [btn setTitleColor:[XIColorHelper ThemeColor] forState:UIControlStateSelected];
        [btn setTitleColor:[UIColor opaqueColorWithRGBBytes:0x8d91a0] forState:UIControlStateDisabled];
    }
    return (XISelectorItem *)btn;
}
@end


static NSInteger const _number_items = 3;
#define kItemTagBase 100

@interface XIOptionSelectorView ()
{
    XISelectorItem *statusSwitchButton;
    XISelectorItem *sortButton;
    XISelectorItem *moreItemButton;
    ALOverlayView *_overlayView;
    
    BOOL _overlayViewPositioned;
    NSMutableArray *_items;
    NSMutableArray *_dropdownListViews;
    NSMutableArray *_rawFrames;
}
@end

@implementation XIOptionSelectorView

- (void)dealloc
{
    self.viewAtIndex = nil;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if(self=[super initWithFrame:frame]){
        
        _overlayViewPositioned = NO;
        self.backgroundColor = [UIColor colorWithWhite:1 alpha:1];
        _selectedItemIndex = 0;
        _dropdownListViews = [NSMutableArray array];
        _rawFrames = [NSMutableArray arrayWithObjects:[NSValue valueWithCGRect:CGRectZero],
                      [NSValue valueWithCGRect:CGRectZero],
                      [NSValue valueWithCGRect:CGRectZero], nil];
        _items = [NSMutableArray array];
        
        self.borderColor = [XIColorHelper SeparatorLineColor];
        self.borderWidth = 1.0;
        self.borderSides = UIRectEdgeBottom;
        
        self.numberOfItems = _number_items;
        self.separatorLineColor = [XIColorHelper SeparatorLineColor];
        self.lineInsets = UIEdgeInsetsMake(10, 0, 10, 0);
        
        NSArray *_itemTitles = @[NSLocalizedString(@"默认排序", nil), NSLocalizedString(@"景点", nil), NSLocalizedString(@"筛选", nil)];
        
        for(int i=0; i< _itemTitles.count; i++){
            XISelectorItem *item = [XISelectorItem createItemButtonWithType:XIContentAlignHorizontalCenterImageRight];
            item.tag = kItemTagBase+i;
            [self addSubview:item];
            [item setImage:[UIImage imageNamed:@"option_arrow_down"] title:_itemTitles[i] controlState:UIControlStateNormal];
            [item setImage:[UIImage imageNamed:@"option_arrow_up"] title:_itemTitles[i] controlState:UIControlStateSelected];
            [item addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
            
            _items[i]=item;
        }
        statusSwitchButton = _items[0];
        sortButton = _items[1];
        moreItemButton = _items[2];
        
        for(int i=0; i<_number_items; i++){
            _dropdownListViews[i] = [NSNull null];
        }
        // Apply constraints on views
        [self setupConstraints];
    }
    return self;
}

- (void)setTitle:(NSString *)title forItem:(NSInteger)itemIndex
{
    NSAssert(itemIndex<_number_items, @"'itemIndex' is invalid!");
    [_items[itemIndex] setTitle:title forState:UIControlStateNormal];
}

- (void)createOverlayViewIfNeeded
{
    if(_overlayView==nil){
        _overlayView = [[ALOverlayView alloc] initWithFrame:CGRectZero];
        __weak XIOptionSelectorView *weakSelf = self;
        [_overlayView setPressDownBlock:^{
            [weakSelf hideSelectedDropdownlistView];
        }];
    }
    if(_overlayViewPositioned==NO && [self.superview.subviews containsObject:_overlayView]==NO){
        
        _overlayViewPositioned = YES;
        _overlayView.frame = UIEdgeInsetsInsetRect(self.superview.bounds, UIEdgeInsetsMake(64, 0, 0, 0));
        _overlayView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
        _overlayView.blurView.underlyingView = self.parentView;
        [self.parentView addSubview:_overlayView];
    }
}

- (void)setupConstraints
{
    statusSwitchButton.translatesAutoresizingMaskIntoConstraints = NO;
    sortButton.translatesAutoresizingMaskIntoConstraints = NO;
    moreItemButton.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSDictionary *bindingViews = NSDictionaryOfVariableBindings(statusSwitchButton, sortButton, moreItemButton);
    NSArray *contraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[statusSwitchButton]-[sortButton(==statusSwitchButton)]-[moreItemButton(==statusSwitchButton)]-|"
                                                                  options:0
                                                                  metrics:nil
                                                                    views:bindingViews];
    [self addConstraints:contraints];
    contraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-2-[statusSwitchButton]-2-|" options:0 metrics:nil views:bindingViews];
    [self addConstraints:contraints];
    contraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-2-[sortButton]-2-|" options:0 metrics:nil views:bindingViews];
    [self addConstraints:contraints];
    contraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-2-[moreItemButton]-2-|" options:0 metrics:nil views:bindingViews];
    [self addConstraints:contraints];
}

- (void)closeView
{
    [self hideSelectedDropdownlistView];
}

- (void)hideSelectedDropdownlistView
{
    UIView *selectedView = [self loadViewAtIndex:_selectedItemIndex];
    CGRect changedFrame = selectedView.frame;
    changedFrame.size.height = 0;
    
    _overlayView.alpha = 1.0f;
    [UIView animateWithDuration:0.35 animations:^{
        _overlayView.alpha = 0.0f;
        selectedView.frame = changedFrame;
    } completion:^(BOOL finished) {
        if(finished){
            _overlayView.alpha = 1.0f;
            _overlayView.hidden = YES;
            selectedView.hidden = YES;
            selectedView.frame = [_rawFrames[self.selectedItemIndex] CGRectValue];
        }
        else{
            NSLog(@"%s", __FUNCTION__);
        }
    }];
    
    self.selectedItemIndex = _selectedItemIndex;
}

- (void)setSelectedItemIndex:(NSInteger)index
{
    _selectedItemIndex = index;
    for(UIButton *btn in _items){
        if(btn.tag==index+kItemTagBase){
            btn.selected = !btn.selected;
        }
        else{
            btn.selected = NO;
        }
    }
}

- (void)showDropdownListViewAtIndex:(NSInteger)index
{
    UIView *lastSelectedView = [self loadViewAtIndex:self.selectedItemIndex];
    UIView *willSelectedView = [self loadViewAtIndex:index];
    if(self.selectedItemIndex==index){
        // If lastSelectedView is visible, we should hide it animated, do the same thing in reverse.
        // Do hide or show
        if(lastSelectedView.hidden){
            
            [self createOverlayViewIfNeeded];
            _overlayView.hidden = NO;
            lastSelectedView.hidden = NO;
            // Adjust _overlayView position
            [self.parentView bringSubviewToFront:_overlayView];
            [self.parentView bringSubviewToFront:self];
            [self.parentView bringSubviewToFront:lastSelectedView];
            
            CGRect changedFrame = lastSelectedView.frame;
            changedFrame.size.height = 0;
            _overlayView.alpha = 0;
            lastSelectedView.frame = changedFrame;
            [UIView animateWithDuration:0.35 animations:^{
                lastSelectedView.frame = [_rawFrames[self.selectedItemIndex] CGRectValue];
                _overlayView.alpha = 1;
            } completion:^(BOOL finished) {
                
            }];
        }
        else{
            // Hide
            CGRect changedFrame = lastSelectedView.frame;
            changedFrame.size.height = 0;
            
            _overlayView.alpha = 1.0f;
            [UIView animateWithDuration:0.35 animations:^{
                _overlayView.alpha = 0.0f;
                lastSelectedView.frame = changedFrame;
            } completion:^(BOOL finished) {
                if(finished){
                    _overlayView.alpha = 1.0f;
                    _overlayView.hidden = YES;
                    lastSelectedView.hidden = YES;
                    lastSelectedView.frame = [_rawFrames[self.selectedItemIndex] CGRectValue];
                }
            }];
        }
    }
    else{
        [self createOverlayViewIfNeeded];
        _overlayView.hidden = NO;
        lastSelectedView.hidden = YES;
        willSelectedView.hidden = NO;
        // Adjust _overlayView position
        [self.parentView bringSubviewToFront:_overlayView];
        [self.parentView bringSubviewToFront:self];
        [self.parentView bringSubviewToFront:willSelectedView];
        
        CGRect changedFrame = willSelectedView.frame;
        changedFrame.size.height = 0;
        willSelectedView.frame = changedFrame;
        [UIView animateWithDuration:0.35 animations:^{
            willSelectedView.frame = [_rawFrames[index] CGRectValue];
        } completion:^(BOOL finished) {
            
        }];
    }
}

- (UIView *)loadViewAtIndex:(NSInteger)index
{
    id view = _dropdownListViews[index];
    if([view isKindOfClass:[UIView class]] &&
       [view conformsToProtocol:@protocol(XIDropdownlistViewProtocol)]){
        return view;
    }
    if(_viewAtIndex){
        view = _viewAtIndex(index, self);
        [_dropdownListViews replaceObjectAtIndex:index withObject:view];
        // Store the raw frame of each view
        [_rawFrames replaceObjectAtIndex:index withObject:[NSValue valueWithCGRect:((UIView *)view).frame]];
    }
    return view;
}

- (void)buttonAction:(UIButton *)btn
{
    NSInteger itemIndex = btn.tag-kItemTagBase;
    
    [self showDropdownListViewAtIndex:itemIndex];
    
    self.selectedItemIndex = itemIndex;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self setNeedsDisplay];
}
@end
