//
//  TGADuiLeiImageView.h
//  DuiLeiAnimation
//
//  Created by vspn_iMac2 on 2019/5/13.
//  Copyright © 2019 vspn_iMac2. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, TGADuiLeiViewMode) {
    TGADuiLeiViewLeftMode = 1,
    TGADuiLeiViewRightMode
};

NS_ASSUME_NONNULL_BEGIN

@interface TGADuiLeiImageView : UIView
- (instancetype)initWithFrame:(CGRect)frame image:(UIImage *)image animateImage:(UIImage *)animateImage starBackground:(UIImage *)starBackground star:(UIImage *)star;
- (void)pause;
- (void)setAnimationSpeed:(float)speed;

- (void)initWithFrame:(CGRect)frame viewMode:(TGADuiLeiViewMode)viewMode maxWidth:(CGFloat)maxWidth image:(UIImage *)image;
@end

NS_ASSUME_NONNULL_END
