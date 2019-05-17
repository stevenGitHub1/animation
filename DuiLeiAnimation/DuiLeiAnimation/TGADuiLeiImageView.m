//
//  TGADuiLeiImageView.m
//  DuiLeiAnimation
//
//  Created by vspn_iMac2 on 2019/5/13.
//  Copyright © 2019 vspn_iMac2. All rights reserved.
//

#import "TGADuiLeiImageView.h"

@interface TGADuiLeiImageView ()
@property (nonatomic, strong) CALayer *imageLayer;
@property (nonatomic, strong) CALayer *animationLayer;
@property (nonatomic, strong) CALayer *normalLayer;
@property (nonatomic, strong) CALayer *leftLayer;
@property (nonatomic, strong) CALayer *cursorLayer;
@property (nonatomic, strong) CALayer *starBackgroundLayer;
@property (nonatomic, strong) CALayer *starLayer;
@property (nonatomic, strong) CALayer *maskLayer;
@property (nonatomic, strong) UIImage *animateImage;
@property (nonatomic, strong) UIImage *starBackgroundImage;
@property (nonatomic, strong) UIImage *starImage;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) UIImage *cursorImage;
@end

@implementation TGADuiLeiImageView

//- (instancetype)initWithFrame:(CGRect)frame viewMode:(TGADuiLeiViewMode)viewMode maxWidth:(CGFloat)maxWidth image:(nonnull UIImage *)image
//{
//    self = [super initWithFrame:frame];
//    if (self) {
//        
//    }
//    return self;
//}

- (instancetype)initWithFrame:(CGRect)frame image:(UIImage *)image animateImage:(UIImage *)animateImage starBackground:(nonnull UIImage *)starBackground star:(nonnull UIImage *)star {
    self = [super initWithFrame:frame];
    if (self) {
        [self setImage:image];
        [self setStarImage:star];
        [self setAnimateImage:animateImage];
        [self setStarBackgroundImage:starBackground];
        [self setCursorImage:[UIImage imageNamed:@"左边扫光@3x(1)"]];
        [self initAnimateLayer];
        [self initAnimation];
    }
    return self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    _animationLayer.speed = 0;
    _starBackgroundLayer.hidden = YES;
    _starLayer.hidden = YES;
//
//    [_normalLayer removeAllAnimations];
//    [_leftLayer removeAllAnimations];
//    [_cursorLayer removeAllAnimations];
//    [self initAnimation];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _maskLayer.frame = self.bounds;
    _imageLayer.frame = self.bounds;
    _starLayer.frame = CGRectMake(self.bounds.size.width-_starImage.size.width+5.5, -_starImage.size.height/2+5, _starImage.size.width, _starImage.size.height);
    _starBackgroundLayer.frame = CGRectMake(self.bounds.size.width-_starBackgroundImage.size.width, 0, _starBackgroundImage.size.width, _starBackgroundImage.size.height);
}

- (void)initAnimateLayer {
    _maskLayer = [CALayer layer];
    _maskLayer.contents = (id)[self getCapsImage:_image].CGImage;
    
    _imageLayer = [CALayer layer];
    _imageLayer.contents = (id)[self getCapsImage:_image].CGImage;
    
    _animationLayer = [CALayer layer];
    _animationLayer.mask = _maskLayer;
    
    _normalLayer = [CALayer layer];
    _normalLayer.contents = (id)[self getCapsImage:_animateImage].CGImage;
    
    _leftLayer = [CALayer layer];
    _leftLayer.contents = (id)[self getCapsImage:_animateImage].CGImage;
    
    _cursorLayer = [CALayer layer];
    _cursorLayer.contents = (id)_cursorImage.CGImage;
    
    [_animationLayer addSublayer:_normalLayer];
    [_animationLayer addSublayer:_leftLayer];
    [_animationLayer addSublayer:_cursorLayer];
    
    _starLayer = [CALayer layer];
    _starLayer.contents = (id)_starImage.CGImage;
    
    _starBackgroundLayer = [CALayer layer];
    _starBackgroundLayer.contents = (id)_starBackgroundImage.CGImage;
    
    _maskLayer.frame = self.bounds;
    _imageLayer.frame = self.bounds;
    _normalLayer.frame = self.bounds;
    _animationLayer.frame = self.bounds;
    _leftLayer.frame = CGRectMake(-self.bounds.size.width, 0, self.bounds.size.width, self.bounds.size.height);
    _starLayer.frame = CGRectMake(self.bounds.size.width-_starImage.size.width+5.5, -_starImage.size.height/2+5, _starImage.size.width, _starImage.size.height);
    _starBackgroundLayer.frame = CGRectMake(self.bounds.size.width-_starBackgroundImage.size.width, 0, _starBackgroundImage.size.width, _starBackgroundImage.size.height);
    _cursorLayer.frame = CGRectMake(-_cursorImage.size.width, 0, _cursorImage.size.width, _cursorImage.size.height);
    
    [self.layer addSublayer:_starLayer];
    [self.layer addSublayer:_imageLayer];
    [self.layer addSublayer:_animationLayer];
    [self.layer addSublayer:_starBackgroundLayer];
}

- (void)initAnimation {
    CABasicAnimation *contentAnimation = [CABasicAnimation animationWithKeyPath:@"position.x"];
    contentAnimation.toValue = [NSNumber numberWithFloat:_normalLayer.position.x+self.bounds.size.width];
    contentAnimation.duration = 2.f;
    contentAnimation.repeatCount = NSIntegerMax;
    [_normalLayer addAnimation:contentAnimation forKey:@"1"];
    
    CABasicAnimation *animateAnimation = [CABasicAnimation animationWithKeyPath:@"position.x"];
    animateAnimation.toValue = [NSNumber numberWithFloat:_leftLayer.position.x+self.bounds.size.width];
    animateAnimation.duration = 2.f;
    animateAnimation.repeatCount = NSIntegerMax;
    [_leftLayer addAnimation:animateAnimation forKey:@"2"];
    
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"bounds"];
    scaleAnimation.toValue = [NSValue valueWithCGRect:CGRectMake(0, 0, _starImage.size.width*1.3, _starImage.size.height*1.3)];
    scaleAnimation.duration = 1.f;
    scaleAnimation.repeatCount = NSIntegerMax;
    scaleAnimation.autoreverses = YES;
    [_starLayer addAnimation:scaleAnimation forKey:@"3"];
    
    CAKeyframeAnimation *cursorAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position.x"];
    cursorAnimation.values = @[[NSNumber numberWithFloat:_cursorLayer.position.x],
                               [NSNumber numberWithFloat:_cursorLayer.position.x+self.bounds.size.width+_cursorLayer.bounds.size.width],
                               [NSNumber numberWithFloat:_cursorLayer.position.x+self.bounds.size.width+_cursorLayer.bounds.size.width]];
    cursorAnimation.keyTimes = @[@(0),@(0.5), @(1)];
    cursorAnimation.duration = 2.f;
    cursorAnimation.repeatCount = NSIntegerMax;
    [_cursorLayer addAnimation:cursorAnimation forKey:@"3"];
    
    NSLog(@"%@", _normalLayer.animationKeys);
}

- (UIImage *)getCapsImage:(UIImage *)image {
    UIGraphicsBeginImageContext(CGSizeMake(self.bounds.size.width, self.bounds.size.height));
    [image drawInRect:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
    UIImage *drawImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return drawImage;
}
@end
