

#import <UIKit/UIKit.h>

// Direction
typedef enum {
    ArrowDirectionRight,
    ArrowDirectionLeft//,
    //ArrowDirectionUp,
    //ArrowDirectionDown
}ArrowDirection;

@protocol XIArrowSetting <NSObject>

@property(nonatomic, assign) ArrowDirection arrowDirection;
@property(nonatomic, strong) UIColor *strokeColor;
@property(nonatomic, strong) UIColor *highlightedStrokeColor;
@property(nonatomic, assign) CGFloat lineWidth;
@property(nonatomic) CGLineCap lineCapStyle;

@end

@interface XIArrowView : UIView<XIArrowSetting>
@property(nonatomic, assign) BOOL highlighted;

- (void)setStrokeColor:(UIColor *)color dirction:(ArrowDirection)dirction lineWidth:(CGFloat)lineWidth lineCapStyle:(CGLineCap)lineCapStyle;
@end

@interface XIArrowButton : UIButton<XIArrowSetting>
@end


