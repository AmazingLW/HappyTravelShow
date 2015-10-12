

#ifndef CommonKit_XIBackgroundViewProtocol_h
#define CommonKit_XIBackgroundViewProtocol_h
#import <UIKit/UIKit.h>

@protocol XIBackgroundViewProtocol <NSObject>

@property(nonatomic, assign) UIEdgeInsets lineInsets;
@property(nonatomic, assign) int numberOfItems;
@property(nonatomic, strong) UIColor *separatorLineColor;

@end

#endif
