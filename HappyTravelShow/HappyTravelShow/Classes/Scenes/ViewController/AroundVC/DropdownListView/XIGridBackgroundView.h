

#import "XIBorderSideView.h"
#import "XIBackgroundViewProtocol.h"

@interface XIGridBackgroundView : XIBorderSideView<XIBackgroundViewProtocol>

- (void)updateDisplayIfNeeded;
@end