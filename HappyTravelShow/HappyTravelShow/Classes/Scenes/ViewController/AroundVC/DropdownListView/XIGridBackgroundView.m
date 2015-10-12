

#import "XIGridBackgroundView.h"

@interface XIGridBackgroundView ()
{
    float lineWidth;
    NSMutableArray *lineAnchorPoints;
}
@end

@implementation XIGridBackgroundView
@synthesize numberOfItems=_numberOfItems;
@synthesize separatorLineColor=_separatorLineColor;
@synthesize lineInsets=_lineInsets;

- (instancetype)initWithFrame:(CGRect)frame
{
    if(self=[super initWithFrame:frame]){
        [self commonInit];
    }
    return self;
}

- (void)updateDisplayIfNeeded
{
    float vWidth = self.frame.size.width;
    float iWidth = vWidth/_numberOfItems;
    
    if(lineAnchorPoints.count>0){
        [lineAnchorPoints removeAllObjects];
    }
    for(int i=0; i<_numberOfItems-1; i++){
        float px = iWidth*(i+1);
        float py = _lineInsets.top;
        [lineAnchorPoints addObject:[NSValue valueWithCGPoint:CGPointMake(px, py)]];
    }
    
    [self setNeedsDisplay];
}

- (void)setNumberOfItems:(int)number
{
    _numberOfItems = number;
    
    [self updateDisplayIfNeeded];
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    [self updateDisplayIfNeeded];
}

- (void)setSeparatorLineColor:(UIColor *)color
{
    _separatorLineColor = color;
    [self setNeedsDisplay];
}

- (void)setLineInsets:(UIEdgeInsets)insets
{
    _lineInsets = insets;
    [self setNeedsDisplay];
}

- (void)commonInit
{
    lineAnchorPoints = [NSMutableArray array];
    _numberOfItems = 0;
    _separatorLineColor = [UIColor colorWithRed:236.0/255.0 green:236.0/255.0 blue:236.0/255.0 alpha:1.0];
    lineWidth = 0.5f;
    _lineInsets = UIEdgeInsetsMake(4, 0, 4, 0);
}

- (void)awakeFromNib
{
    [self commonInit];
    self.numberOfItems = 4;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    [super drawRect:rect];
    if(_numberOfItems>0){
        CGContextRef ctxt = UIGraphicsGetCurrentContext();
        CGContextSetStrokeColorWithColor(ctxt,_separatorLineColor.CGColor);
        CGContextSetLineWidth(ctxt, lineWidth);
        CGContextSetShouldAntialias(ctxt, NO);
        for (int i=0; i<lineAnchorPoints.count; i++) {
            
            CGPoint from = [lineAnchorPoints[i] CGPointValue];
            CGPoint to = CGPointMake(from.x, CGRectGetHeight(rect)-_lineInsets.bottom);
            CGContextMoveToPoint(ctxt, from.x, from.y);
            CGContextAddLineToPoint(ctxt, to.x, to.y);
        }
        CGContextStrokePath(ctxt);
    }
}

@end