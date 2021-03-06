//
//  UILabelOverlay.m
//
//  Created by Seb on 13.02.14.
//  MIT license
//

#import "UILabelOverlay.h"

@interface UILabelOverlay ()

@property (nonatomic, strong) UIView *textOverlayView;

@end


@implementation UILabelOverlay

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addGestureRecognizer];
    }
    return self;
}

- (id)init {
    if (self = [super init]) {
        [self addGestureRecognizer];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self addGestureRecognizer];
}

- (void)addGestureRecognizer {
    self.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped:)];
    [self addGestureRecognizer:tapRecognizer];
}

- (void)tapped:(UIGestureRecognizer*)recognizer {
    if (_isShown) {
        [self hideOverlay];
    }
    else {
        [self showOverlay];
    }
}

- (void)showOverlay {
    _isShown = YES;
    
    CGSize size = [self.text sizeWithAttributes:@{NSFontAttributeName: self.font}];
    CGFloat width = MIN(size.width, self.maxWidth);
    
    UILabel *textLabel = [[UILabel alloc] init];
    textLabel.text = self.text;
    textLabel.font = self.font;
    textLabel.textColor = self.textColor;
    [textLabel setLineBreakMode:NSLineBreakByTruncatingTail];
    
    self.textOverlayView.frame = CGRectMake(self.frame.origin.x + _insets.left, self.frame.origin.y + _insets.top,
                                            width + _insets.right, size.height + _insets.bottom);
    self.textOverlayView.alpha = 0.0f;
    
    [self.textOverlayView addSubview:textLabel];
    
    textLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.textOverlayView addConstraint:[NSLayoutConstraint constraintWithItem:textLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.textOverlayView attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
    [self.textOverlayView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-2.5-[textLabel]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(textLabel)]];
    
    [self.superview addSubview:self.textOverlayView];
    
    UITapGestureRecognizer *overLayViewTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped:)];
    [self.textOverlayView addGestureRecognizer:overLayViewTapRecognizer];
    
    [UIView animateWithDuration:0.4f animations:^{
        self.textOverlayView.alpha = 1.0f;
    }];
}

- (void)hideOverlay {
    if (_textOverlayView) {
        [UIView animateWithDuration:0.4f animations:^{
            _textOverlayView.alpha = 0.0f;
        } completion:^(BOOL finished) {
            [_textOverlayView removeFromSuperview];
            
            _textOverlayView = nil;
            
            _isShown = NO;
        }];
    }
}

- (UIView*)textOverlayView {
    if (!_textOverlayView) {
        UIView *textOverlay = [[UIView alloc] init];
        textOverlay.backgroundColor = [UIColor whiteColor];
        textOverlay.layer.borderColor = [UIColor blackColor].CGColor;
        textOverlay.layer.borderWidth = 0.8f;
        
        _textOverlayView = textOverlay;
    }
    
    return _textOverlayView;
}
@end
