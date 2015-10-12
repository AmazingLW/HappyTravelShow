

#import "XIButton.h"

@interface XIButton ()
{
    NSMutableDictionary *titleDict;
    NSMutableDictionary *imageDict;
    NSMutableDictionary *titleColorDict;
}
- (void)setupConstraints;
@end

#define defaultTitleForegroundColor  [UIColor blackColor]
#define defaultTitleHighlightedColor [UIColor lightGrayColor]

@implementation XIButton
@synthesize preferedImageSize;
@synthesize preferedFont;
@synthesize preferedColor;
@synthesize preferedHighlightedColor;


- (instancetype)initWithFrame:(CGRect)frame
{
    if(self=[super initWithFrame:frame]){
        shouldChangeImageSize = NO;
        preferedImageSize = CGSizeZero;
        preferedFont = [UIFont systemFontOfSize:15.0f];
        preferedColor = defaultTitleForegroundColor;
        preferedHighlightedColor = defaultTitleHighlightedColor;
        titleDict = [NSMutableDictionary dictionary];
        imageDict = [NSMutableDictionary dictionary];
        titleColorDict = [NSMutableDictionary dictionary];
    }
    return self;
}

+ (instancetype)createItemButtonWithType:(XIContentAlign)type
{
    XIButton *item;
    if(type==XIContentAlignVertical){
        item = [[XIContentAlignVerticalButton alloc] initWithFrame:CGRectZero];
    }
    else if (type==XIContentAlignHorizontalCenter){
        item = [[XIContentAlignHorizontalCenterButton alloc] initWithFrame:CGRectZero];
    }
    else if(type==XIContentAlignHorizontalCenterImageRight){
        item = [[XIContentAlignHorizontalCenterImageRightButton alloc] initWithFrame:CGRectZero];
    }
    else if (type==XIContentAlignHorizontalLeft){
        item = [[XIContentAlignHorizontalLeftButton alloc] initWithFrame:CGRectZero];
    }
    return item;
}

- (void)setupConstraints
{
    // Implemented by subclass.
}

- (void)setPreferedImageSize:(CGSize)size
{
    preferedImageSize = size;
    shouldChangeImageSize = YES;
    [self setNeedsUpdateConstraints];
}


- (void)setPreferedFont:(UIFont *)font
{
    preferedFont = font;
    proLabel.font = font;
    [self setNeedsUpdateConstraints];
}

- (void)setPreferedColor:(UIColor *)color
{
    preferedColor = color;
    proLabel.textColor = preferedColor;
}

- (void)setPreferedHighlightedColor:(UIColor *)color
{
    preferedHighlightedColor = color;
    proLabel.highlightedTextColor = color;
}

- (NSString *)titleForNormalState
{
    return proLabel.text;
}

- (void)setImage:(UIImage *)image title:(NSString *)title controlState:(UIControlState)state
{
    titleDict[@((NSUInteger)state)] = title;
    imageDict[@((NSUInteger)state)] = image;
    
    if(state==UIControlStateNormal){
        proImageView.image = image;
        proLabel.text = title;
    }
    else if (state==UIControlStateHighlighted){
        proImageView.highlightedImage = image;
    }
    
    [self setNeedsUpdateConstraints];
}

- (void)setTitle:(NSString *)title forState:(UIControlState)state
{
    titleDict[@((NSUInteger)state)] = title;
    if(state==UIControlStateNormal){
        proLabel.text = title;
    }
    else if (state==UIControlStateHighlighted){
        
    }
    else if (state==UIControlStateSelected){
        
    }
}

- (void)setTitleColor:(UIColor *)color forState:(UIControlState)state
{
    titleColorDict[@((NSUInteger)state)] = color;
    if(state==UIControlStateNormal){
        proLabel.textColor = color;
    }
    else if (state==UIControlStateHighlighted){
        proLabel.highlightedTextColor = color;
    }
}

- (void)setHighlighted:(BOOL)highlighted
{
    [super setHighlighted:highlighted];
    proLabel.highlighted = highlighted;
    proImageView.highlighted = highlighted;
}

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    if(selected){
        proImageView.image = imageDict[@((NSUInteger)UIControlStateSelected)];
        proLabel.textColor = titleColorDict[@((NSUInteger)UIControlStateSelected)];
    }
    else{
        proImageView.image = imageDict[@((NSUInteger)UIControlStateNormal)];
        proLabel.textColor = titleColorDict[@((NSUInteger)UIControlStateNormal)];
    }
}

@end

@implementation XIContentAlignHorizontalButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if(self=[super initWithFrame:frame]){
        
        [self doPreparation];
    }
    return self;
}

- (void)awakeFromNib
{
    [self doPreparation];
}

- (void)doPreparation
{
    containerView = [[UIView alloc] initWithFrame:CGRectZero];
    [self addSubview:containerView];
    containerView.translatesAutoresizingMaskIntoConstraints = NO;
    containerView.backgroundColor = [UIColor clearColor];
    containerView.userInteractionEnabled = NO;
    
    proImageView = [[UIImageView alloc] init];
    proImageView.contentMode = UIViewContentModeScaleToFill;
    proImageView.backgroundColor = [UIColor clearColor];
    [containerView addSubview:proImageView];
    proImageView.translatesAutoresizingMaskIntoConstraints = NO;
    
    proLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    proLabel.textAlignment = NSTextAlignmentCenter;
    proLabel.numberOfLines = 1;
    proLabel.minimumScaleFactor = 0.5;
    proLabel.textColor = preferedColor;
    proLabel.backgroundColor = [UIColor clearColor];
    proLabel.highlightedTextColor = preferedHighlightedColor;
    [containerView addSubview:proLabel];
    proLabel.translatesAutoresizingMaskIntoConstraints = NO;
}

// |--image--title--|
- (void)setupConstraints
{
    NSDictionary *bindingViews = NSDictionaryOfVariableBindings(proImageView,proLabel);
    NSArray *constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(5)-[proImageView]-(5)-[proLabel]-(5)-|"
                                                                   options:0
                                                                   metrics:nil
                                                                     views:bindingViews];
    [containerView addConstraints:constraints];
    
    // image CenterY
    NSLayoutConstraint *_imageConstraint = [NSLayoutConstraint constraintWithItem:proImageView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:containerView attribute:NSLayoutAttributeCenterY multiplier:1 constant:0];
    [containerView addConstraint:_imageConstraint];
    [proImageView setContentHuggingPriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisHorizontal];
    [proImageView setContentHuggingPriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisVertical];
    
    // title CenterY
    NSLayoutConstraint *_titleConstraint = [NSLayoutConstraint constraintWithItem:proLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:containerView attribute:NSLayoutAttributeCenterY multiplier:1 constant:0];
    [containerView addConstraint:_titleConstraint];
    // title Top
    _titleConstraint = [NSLayoutConstraint constraintWithItem:proLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:containerView attribute:NSLayoutAttributeTop multiplier:1 constant:2];
    [containerView addConstraint:_titleConstraint];
    // title Bottom
    _titleConstraint = [NSLayoutConstraint constraintWithItem:proLabel attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:containerView attribute:NSLayoutAttributeBottom multiplier:1 constant:-2];
    [containerView addConstraint:_titleConstraint];
    
    // title Hugging content first
    [proLabel setContentHuggingPriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisHorizontal];
    [proLabel setContentHuggingPriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisVertical];
}

// |--title--image--|
- (void)setupTitleImageConstraints
{
    NSDictionary *bindingViews = NSDictionaryOfVariableBindings(proImageView,proLabel);
    NSArray *constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(5)-[proLabel]-(5)-[proImageView]-(5)-|"
                                                                   options:0
                                                                   metrics:nil
                                                                     views:bindingViews];
    [containerView addConstraints:constraints];
    
    // image CenterY
    NSLayoutConstraint *_imageConstraint = [NSLayoutConstraint constraintWithItem:proImageView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:containerView attribute:NSLayoutAttributeCenterY multiplier:1 constant:0];
    [containerView addConstraint:_imageConstraint];
    
    [proImageView setContentHuggingPriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisHorizontal];
    [proImageView setContentHuggingPriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisVertical];
    
    // title CenterY
    NSLayoutConstraint *_titleConstraint = [NSLayoutConstraint constraintWithItem:proLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:containerView attribute:NSLayoutAttributeCenterY multiplier:1 constant:0];
    [containerView addConstraint:_titleConstraint];
    // title Top
    _titleConstraint = [NSLayoutConstraint constraintWithItem:proLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:containerView attribute:NSLayoutAttributeTop multiplier:1 constant:2];
    [containerView addConstraint:_titleConstraint];
    // title Bottom
    _titleConstraint = [NSLayoutConstraint constraintWithItem:proLabel attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:containerView attribute:NSLayoutAttributeBottom multiplier:1 constant:-2];
    [containerView addConstraint:_titleConstraint];
    
    // title Hugging content first
    [proLabel setContentHuggingPriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisHorizontal];
    [proLabel setContentHuggingPriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisVertical];
}

- (void)updateConstraints
{
    //if(CGSizeEqualToSize(preferedImageSize, CGSizeZero)==NO && shouldChangeImageSize)
    if(shouldChangeImageSize){
        shouldChangeImageSize = NO;
        
        [proImageView setContentHuggingPriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
        [proImageView setContentHuggingPriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisVertical];
        
        if(imageWidthConstraint){
            [containerView removeConstraint:imageWidthConstraint];
        }
        if(imageWidthConstraint){
            [containerView removeConstraint:imageWidthConstraint];
        }
        
        // Width
        imageWidthConstraint = [NSLayoutConstraint constraintWithItem:proImageView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:self.preferedImageSize.width];
        [containerView addConstraint:imageWidthConstraint];
        // Height
        imageHeightConstraint = [NSLayoutConstraint constraintWithItem:proImageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:self.preferedImageSize.height];
        [containerView addConstraint:imageHeightConstraint];
    }
    [super updateConstraints];
}

@end

///////////////////////////////////////////////////////////////////////////////////////////////////////////////
// XIContentAlignHorizontalLeftButton
///////////////////////////////////////////////////////////////////////////////////////////////////////////////

@implementation XIContentAlignHorizontalLeftButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if(self=[super initWithFrame:frame]){
        
        [self setupConstraints];
        
        [self setupContainerConstraints];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setupConstraints];
    [self setupContainerConstraints];
}

- (void)setupContainerConstraints
{
    NSLayoutConstraint *containerConstraint = [NSLayoutConstraint constraintWithItem:containerView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
    [self addConstraint:containerConstraint];
    
    containerConstraint = [NSLayoutConstraint constraintWithItem:containerView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1 constant:0];
    [self addConstraint:containerConstraint];
    
    // Left
    containerConstraint = [NSLayoutConstraint constraintWithItem:containerView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1 constant:5];
    containerConstraint.priority = UILayoutPriorityDefaultLow;
    [self addConstraint:containerConstraint];
    // Right
    containerConstraint = [NSLayoutConstraint constraintWithItem:containerView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1 constant:-5];
    containerConstraint.priority = UILayoutPriorityDefaultLow;
    [self addConstraint:containerConstraint];
    
    containerConstraint = [NSLayoutConstraint constraintWithItem:containerView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationLessThanOrEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:1 constant:0];
    containerConstraint.priority = UILayoutPriorityRequired;
    [self addConstraint:containerConstraint];
    
    containerConstraint = [NSLayoutConstraint constraintWithItem:containerView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationLessThanOrEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:1 constant:0];
    containerConstraint.priority = UILayoutPriorityRequired;
    [self addConstraint:containerConstraint];
}

@end

///////////////////////////////////////////////////////////////////////////////////////////////////////////////
// XIContentAlignHorizontalCenterImageRightButton
///////////////////////////////////////////////////////////////////////////////////////////////////////////////

@implementation XIContentAlignHorizontalCenterImageRightButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if(self=[super initWithFrame:frame]){
        
        [self setupTitleImageConstraints];
        [self setupContainerConstraints];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setupTitleImageConstraints];
    [self setupContainerConstraints];
}

- (void)setEnabled:(BOOL)enabled
{
    [super setEnabled:enabled];
    proImageView.hidden = !enabled;
    
    if(enabled){
        
    }
    else{
        self.preferedImageSize = CGSizeMake(0, 0);
    }
}

- (void)setupContainerConstraints
{
    NSLayoutConstraint *_imageConstraint = [NSLayoutConstraint constraintWithItem:containerView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
    [self addConstraint:_imageConstraint];
    
    _imageConstraint = [NSLayoutConstraint constraintWithItem:containerView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1 constant:0];
    [self addConstraint:_imageConstraint];
}

@end

///////////////////////////////////////////////////////////////////////////////////////////////////////////////
// XIContentAlignHorizontalCenterButton
///////////////////////////////////////////////////////////////////////////////////////////////////////////////

@implementation XIContentAlignHorizontalCenterButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if(self=[super initWithFrame:frame]){
        [self setupConstraints];
        [self setupContainerConstraints];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setupConstraints];
    [self setupContainerConstraints];
}

- (void)setupContainerConstraints
{
    NSLayoutConstraint *_imageConstraint = [NSLayoutConstraint constraintWithItem:containerView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
    [self addConstraint:_imageConstraint];
    
    _imageConstraint = [NSLayoutConstraint constraintWithItem:containerView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1 constant:0];
    [self addConstraint:_imageConstraint];
}

@end


///////////////////////////////////////////////////////////////////////////////////////////////////////////////
// XIContentAlignVerticalButton
///////////////////////////////////////////////////////////////////////////////////////////////////////////////

@implementation XIContentAlignVerticalButton
@synthesize imageOffsetSize=_imageOffsetSize;

- (instancetype)initWithFrame:(CGRect)frame
{
    if(self=[super initWithFrame:frame]){
        needUpdateImageOffset = NO;
        _imageOffsetSize = CGSizeMake(0, 0);
        [self doPreparation];
        [self setupConstraints];
    }
    return self;
}

- (void)awakeFromNib
{
    [self doPreparation];
    [self setupConstraints];
}

- (void)doPreparation
{
    proImageView = [[UIImageView alloc] init];
    proImageView.contentMode = UIViewContentModeScaleToFill;
    proImageView.backgroundColor = [UIColor clearColor];
    [self addSubview:proImageView];
    proImageView.translatesAutoresizingMaskIntoConstraints = NO;
    
    proLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    proLabel.textAlignment = NSTextAlignmentCenter;
    proLabel.numberOfLines = 2;
    proLabel.minimumScaleFactor = 0.5;
    proLabel.textColor = preferedColor;
    proLabel.backgroundColor = [UIColor clearColor];
    proLabel.highlightedTextColor = defaultTitleHighlightedColor;
    [self addSubview:proLabel];
    proLabel.translatesAutoresizingMaskIntoConstraints = NO;
}

- (void)setImageOffsetSize:(CGSize)_offsetSize
{
    needUpdateImageOffset = YES;
    _imageOffsetSize = _offsetSize;
    [self setNeedsUpdateConstraints];
}

- (void)setupConstraints
{
    // image CenterY
    _imageConstraintCenterY = [NSLayoutConstraint constraintWithItem:proImageView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1 constant:_imageOffsetSize.height];
    [self addConstraint:_imageConstraintCenterY];
    
    // image CenterX
    NSLayoutConstraint *_imageConstraint = [NSLayoutConstraint constraintWithItem:proImageView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
    [self addConstraint:_imageConstraint];
    [proImageView setContentHuggingPriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisHorizontal];
    [proImageView setContentHuggingPriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisVertical];
    
    // Constraint Top margin
    _imageConstraint = [NSLayoutConstraint constraintWithItem:proImageView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1 constant:2];
    _imageConstraint.priority = UILayoutPriorityDefaultLow;
    [self addConstraint:_imageConstraint];
    
    
    
    // title Top
    NSLayoutConstraint *_titleConstraint = [NSLayoutConstraint constraintWithItem:proLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:proImageView attribute:NSLayoutAttributeBottom multiplier:1 constant:10];
    [self addConstraint:_titleConstraint];
    
    // title Left
    _titleConstraint = [NSLayoutConstraint constraintWithItem:proLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1 constant:2];
    _titleConstraint.priority = UILayoutPriorityRequired;
    [self addConstraint:_titleConstraint];
    // title Right
    _titleConstraint = [NSLayoutConstraint constraintWithItem:proLabel attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1 constant:-2];
    _titleConstraint.priority = UILayoutPriorityRequired;
    [self addConstraint:_titleConstraint];
    
    // title Bottom
    _titleConstraint = [NSLayoutConstraint constraintWithItem:proLabel attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1 constant:-2];
    _titleConstraint.priority = UILayoutPriorityDefaultLow;
    [self addConstraint:_titleConstraint];
    
    // title Hugging content first
    [proLabel setContentHuggingPriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisHorizontal];
    [proLabel setContentHuggingPriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisVertical];
}

- (void)updateConstraints
{
    if(CGSizeEqualToSize(preferedImageSize, CGSizeZero)==NO && shouldChangeImageSize){
        shouldChangeImageSize = NO;
        
        [proImageView setContentHuggingPriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
        [proImageView setContentHuggingPriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisVertical];
        
        if(imageWidthConstraint){
            [self removeConstraint:imageWidthConstraint];
        }
        if(imageWidthConstraint){
            [self removeConstraint:imageWidthConstraint];
        }
        
        // Width
        imageWidthConstraint = [NSLayoutConstraint constraintWithItem:proImageView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:self.preferedImageSize.width];
        [self addConstraint:imageWidthConstraint];
        // Height
        imageHeightConstraint = [NSLayoutConstraint constraintWithItem:proImageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:self.preferedImageSize.height];
        [self addConstraint:imageHeightConstraint];
    }
    
    if(needUpdateImageOffset){
        needUpdateImageOffset = YES;
        if(_imageConstraintCenterY){
            [self removeConstraint:_imageConstraintCenterY];
        }
        _imageConstraintCenterY = [NSLayoutConstraint constraintWithItem:proImageView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1 constant:_imageOffsetSize.height];
        [self addConstraint:_imageConstraintCenterY];
    }
    
    [super updateConstraints];
}

@end



