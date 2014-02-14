//
//  UILabelOverlay.h
//
//  Created by Seb on 13.02.14.
//  MIOT licence
//

#import <UIKit/UIKit.h>

/**
 *  UILabel subclass to show a overlay view with the complete text.
 *
 *  Idea: Maybe you have a UILabel that is truncated, but you want to show the complete text when clicking on the UILabel.
 *  This implementation is adding a UITapGestureRecognizer and is showing a overlay UIView with the complete text of the UILabel.
 *
 *  Attention: The maximum width of the overlay has to be defined with `maxWidth`. Maybe additional implementations have to be done (maybe provide more than one line). An automatic truncating would be nice.
 */
@interface UILabelOverlay : UILabel

/// Determine or set the state
@property(nonatomic, assign) BOOL isShown;

/// Maximum width of the overlay
@property(nonatomic, assign) CGFloat maxWidth;

@property(nonatomic, assign) UIEdgeInsets insets;

/**
 *  Hide the overlay.
 */
- (void)hideOverlay;

/**
 *  Show the overlay.
 */
- (void)showOverlay;

@end
