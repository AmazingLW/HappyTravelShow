

#import "XIBorderSideView.h"

@implementation XIBorderSideView
@synthesize borderColor = _borderColor;
@synthesize borderSides = _borderSides;
@synthesize borderWidth = _borderWidth;

- (void)awakeFromNib
{
    self.backgroundColor = [UIColor whiteColor];
    _borderSides = UIRectEdgeNone;
    _borderWidth = 1.0f;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor whiteColor];
        _borderSides = UIRectEdgeNone;
        _borderWidth = 1.0f;
    }
    return self;
}

- (void)layoutSubviews
{
    [self setNeedsDisplay];
    // If using autolayout, must call the [super layoutSubviews];
    [super layoutSubviews];
}

#pragma Drawing
- (void)drawRect:(CGRect)rect {
    
    if(_borderSides != UIRectEdgeNone){
        CGContextRef ctxt = UIGraphicsGetCurrentContext();
        //CGContextSetAllowsAntialiasing(ctxt, NO);//抗锯齿 don't recommond in this way.
        CGContextSetStrokeColorWithColor(ctxt,self.borderColor.CGColor);
        CGContextSetLineWidth(ctxt, _borderWidth);
        
        CGFloat min_y = 0;
        CGFloat min_x = 0;
        CGFloat max_y = CGRectGetMaxY(rect);
        CGFloat max_x = CGRectGetMaxX(rect);
        
        if(_borderSides & UIRectEdgeTop){
            CGContextMoveToPoint(ctxt, min_x, min_y);
            CGContextAddLineToPoint(ctxt, max_x, min_y);
        }
        if(_borderSides & UIRectEdgeLeft){
            CGContextMoveToPoint(ctxt, min_x, min_y);
            CGContextAddLineToPoint(ctxt, min_x, max_y);
        }
        if(_borderSides & UIRectEdgeBottom){
            CGContextMoveToPoint(ctxt, min_x, max_y);
            CGContextAddLineToPoint(ctxt, max_x, max_y);
        }
        if(_borderSides & UIRectEdgeRight){
            CGContextMoveToPoint(ctxt, max_x, min_y);
            CGContextAddLineToPoint(ctxt, max_x, max_y);
        }
        CGContextStrokePath(ctxt);
    }
    else{
        [super drawRect:rect];
    }
}

#pragma mark - Setters

- (void)setBorderColor:(UIColor *)color
{
    _borderColor = color;
    [self setNeedsDisplay];
}

- (void)setBorderSides:(UIRectEdge)rectSides
{
    _borderSides = rectSides;
    [self setNeedsDisplay];
}

- (void)setBorderWidth:(CGFloat)borderWidth{
    _borderWidth = borderWidth;
    [self setNeedsDisplay];
}

@end