

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    XIContentAlignVertical,
    XIContentAlignHorizontalCenter,
    XIContentAlignHorizontalCenterImageRight,
    XIContentAlignHorizontalLeft
} XIContentAlign;


@interface XIButton : UIButton
{
    @protected
    CGSize preferedImageSize;
    UIFont *preferedFont;
    UIColor *preferedColor;
    UIColor *preferedHighlightedColor;
    BOOL shouldChangeImageSize;
    NSLayoutConstraint *imageWidthConstraint;
    NSLayoutConstraint *imageHeightConstraint;

    UIView *containerView;
    UIImageView *proImageView;
    UILabel *proLabel;
}
@property(nonatomic, assign) CGSize preferedImageSize;
@property(nonatomic, strong) UIFont *preferedFont;
@property(nonatomic, strong) UIColor *preferedColor;
@property(nonatomic, strong) UIColor *preferedHighlightedColor;

+ (instancetype)createItemButtonWithType:(XIContentAlign)type;
- (void)setImage:(UIImage *)image title:(NSString *)title controlState:(UIControlState)state;
- (NSString *)titleForNormalState;
@end

@interface XIContentAlignVerticalButton : XIButton
{
    @private
    NSLayoutConstraint *_imageConstraintCenterY;
    BOOL needUpdateImageOffset;
}
@property(nonatomic, assign) CGSize imageOffsetSize;
@end

@interface XIContentAlignHorizontalButton : XIButton
@end
@interface XIContentAlignHorizontalLeftButton : XIContentAlignHorizontalButton
@end
@interface XIContentAlignHorizontalCenterImageRightButton : XIContentAlignHorizontalButton
@end
@interface XIContentAlignHorizontalCenterButton : XIContentAlignHorizontalButton
@end

