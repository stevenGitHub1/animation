//
//  TGASupportAnimateView.m
//  TGALiveSDK
//
//  Created by vspn_iMac2 on 2019/5/16.
//  Copyright © 2019 Tencent. All rights reserved.
//

#define DURATION 2

#import "TGASupportAnimateView.h"

@interface TGASupportAnimateView ()
@property (nonatomic, assign) CGFloat maxWidth;
@property (nonatomic, strong) CALayer *maskLayer;
@property (nonatomic, strong) CALayer *imageLayer;
@property (nonatomic, strong) CALayer *highLightImageLayer;
@property (nonatomic, strong) CALayer *starLayer;
@property (nonatomic, strong) CALayer *arrowLayer;
@property (nonatomic, strong) CALayer *leftLayer;
@property (nonatomic, strong) CALayer *cursorLayer;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) UIImage *starImage;
@property (nonatomic, strong) UIImage *highLightImage;
@property (nonatomic, strong) UIImage *arrowImage;
@property (nonatomic, strong) UIImage *cursorImage;

@property (nonatomic, strong) NSTimer *animatingStopTimer;
@property (nonatomic, assign) NSTimeInterval time;
@property (nonatomic, assign) NSTimeInterval beginTime;
@property (nonatomic, strong) CALayer *animateLayer;
@property (nonatomic, assign) NSInteger moreThanOnce;
@end

@implementation TGASupportAnimateView

NSString * const kArrowAnimationKey = @"TGASupportArrowAnimationKey";
NSString * const kCurosrAnimationKey = @"TGASupportCursorAnimationKey";
NSString * const kStarAnimationKey = @"TGASupportStarAnimationKey";
- (instancetype)initWithFrame:(CGRect)frame viewMode:(TGASupportAnimateViewMode)viewMode maxWidth:(CGFloat)maxWidth image:(UIImage *)image {
    if (self = [super initWithFrame:frame]) {
        _image = image;
        _maxWidth = maxWidth;
        _viewMode = viewMode;
        [self initPropertys];
        [self initLayer];
        [self addCheerDynamicEffect];
        [self pause];
        [self demoStart];
    }
    return self;
}

- (void)demoStart {
    __block NSTimer *tmp = [NSTimer timerWithTimeInterval:1.5f target:self selector:@selector(play) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:tmp forMode:NSRunLoopCommonModes];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(8.f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [tmp invalidate];
        tmp = nil;
    });
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self play];
}

- (void)invalidateAnimatingTimer {
    [_animatingStopTimer invalidate];
    _animatingStopTimer = nil;
}

- (void)startAnimatingTimer {
    [self invalidateAnimatingTimer];
    
    _moreThanOnce++;
    CGFloat time = DURATION-_time;
    if (_moreThanOnce > 1) {
        time+=DURATION;
    }
    
    _animatingStopTimer = [NSTimer timerWithTimeInterval:time target:self selector:@selector(pause) userInfo:nil repeats:NO];
    [[NSRunLoop currentRunLoop] addTimer:_animatingStopTimer forMode:NSRunLoopCommonModes];
}

- (void)pause {
    NSLog(@"%f, %f", _time, _beginTime);
    _moreThanOnce = 0;
    [self invalidateAnimatingTimer];
    
    _starLayer.opacity = 0.f;
    _highLightImageLayer.opacity = 0.f;
    
//    CFTimeInterval pausedTime = [_animateLayer convertTime:CACurrentMediaTime() fromLayer:nil];
//    _animateLayer.speed = 0.f;
//    _animateLayer.timeOffset = pausedTime;
    
    CFTimeInterval pausedTime = [_arrowLayer convertTime:CACurrentMediaTime() fromLayer:nil];
    _arrowLayer.speed = 0.f;
    _arrowLayer.timeOffset = pausedTime;

    _leftLayer.speed = 0.f;
    _leftLayer.timeOffset = pausedTime;

    _cursorLayer.speed = 0.f;
    _cursorLayer.timeOffset = pausedTime;
}

- (void)play {
    if (!_animatingStopTimer) {
        _beginTime = [_animateLayer convertTime:CACurrentMediaTime() fromLayer:nil];
        _starLayer.opacity = 1.f;
        _highLightImageLayer.opacity = 1.f;
        
//        CFTimeInterval pausedTime = [_animateLayer timeOffset];
//        _animateLayer.speed = 1.0;
//        _animateLayer.timeOffset = 0.0;
//        _animateLayer.beginTime = 0.0;
//        CFTimeInterval timeSincePause = [_animateLayer convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;
//        _animateLayer.beginTime = timeSincePause;
        
        CFTimeInterval pausedTime = [_arrowLayer timeOffset];
        _arrowLayer.speed = 1.0;
        _arrowLayer.timeOffset = 0.0;
        _arrowLayer.beginTime = 0.0;
        CFTimeInterval timeSincePause = [_arrowLayer convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;
        _arrowLayer.beginTime = timeSincePause;

        _leftLayer.speed = 1.0;
        _leftLayer.timeOffset = 0.0;
        _leftLayer.beginTime = 0.0;
        _leftLayer.beginTime = timeSincePause;

        _cursorLayer.opacity = 1.f;
        _cursorLayer.speed = 1.0;
        _cursorLayer.timeOffset = 0.0;
        _cursorLayer.beginTime = 0.0;
        _cursorLayer.beginTime = timeSincePause;
    }
    
    _time = [_animateLayer convertTime:CACurrentMediaTime() fromLayer:nil]-_beginTime;
    NSInteger integer = (NSInteger)_time;
    CGFloat floa = _time-integer;
    integer = integer%DURATION;
    _time = integer+floa;
    
    [self startAnimatingTimer];
}

- (void)dealloc {
    NSLog(@"%s", __func__);
}

- (void)initPropertys {
    _image = [UIImage imageNamed:@"蓝色经验条@3x(1)"];
    _starImage = [UIImage imageNamed:@"右边光@3x(1)"];
    _arrowImage = [self getCapsImage:[[UIImage imageNamed:@"左边快速箭头光@3x(1)"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 9) resizingMode:UIImageResizingModeTile]];
    _highLightImage = [UIImage imageNamed:@"1122x"];
    
    if (_viewMode == TGASupportAnimateViewRightMode) {
        _image = [UIImage imageNamed:@"蓝色经验条@3x(1)"];
        _starImage = [UIImage imageNamed:@"右边光@3x(1)"];
        _arrowImage = [self getCapsImage:[[UIImage imageNamed:@"左边快速箭头光@3x(1)"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 9) resizingMode:UIImageResizingModeTile]];
        _highLightImage = [UIImage imageNamed:@"1122x"];
    }
}

- (void)initLayer {
    _imageLayer = [self layerWithImage:_image];
    _imageLayer.contentsCenter = CGRectMake(0.25, 0.25, 0.5, 0.5);
    
    _maskLayer = [self layerWithImage:_image];
    _maskLayer.contentsCenter = CGRectMake(0.25, 0.25, 0.5, 0.5);
    
    _starLayer = [self layerWithImage:_starImage];
    
    _highLightImageLayer = [self layerWithImage:_highLightImage];
    
    _animateLayer = [CALayer layer];
    
    _arrowLayer = [self layerWithImage:_arrowImage];
    _arrowLayer.frame = CGRectMake(0, 0, _maxWidth, 9);
    
    _leftLayer = [self layerWithImage:_arrowImage];
    _leftLayer.frame = CGRectMake(-_maxWidth, 0, _maxWidth, 9);
    
    UIImage *cursorImage = [UIImage imageNamed:@"左边扫光@3x(1)"];
    _cursorLayer = [self layerWithImage:cursorImage];
    _cursorLayer.frame = CGRectMake(-cursorImage.size.width, 0, cursorImage.size.width, cursorImage.size.height);
    
    [_animateLayer addSublayer:_leftLayer];
    [_animateLayer addSublayer:_arrowLayer];
    [_animateLayer addSublayer:_cursorLayer];
    [_animateLayer setMask:_maskLayer];
    
    [self.layer addSublayer:_starLayer];
    [self.layer addSublayer:_imageLayer];
    [self.layer addSublayer:_highLightImageLayer];
    [self.layer addSublayer:_animateLayer];
}

- (void)addCheerDynamicEffect {
    CABasicAnimation *arrowAnimation = [CABasicAnimation animationWithKeyPath:@"position.x"];
    arrowAnimation.toValue = [NSNumber numberWithFloat:_arrowLayer.position.x+_maxWidth];
    arrowAnimation.duration = DURATION;
    arrowAnimation.repeatCount = NSIntegerMax;
    [_arrowLayer addAnimation:arrowAnimation forKey:kArrowAnimationKey];
    
    CABasicAnimation *leftArrowAnimation = [CABasicAnimation animationWithKeyPath:@"position.x"];
    leftArrowAnimation.toValue = [NSNumber numberWithFloat:_leftLayer.position.x+_maxWidth];
    leftArrowAnimation.duration = DURATION;
    leftArrowAnimation.repeatCount = NSIntegerMax;
    [_leftLayer addAnimation:leftArrowAnimation forKey:kArrowAnimationKey];
    
    CAKeyframeAnimation *cursorAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position.x"];
    cursorAnimation.values = @[[NSNumber numberWithFloat:_cursorLayer.position.x],
                               [NSNumber numberWithFloat:_cursorLayer.position.x],
                               [NSNumber numberWithFloat:_cursorLayer.position.x+_maxWidth+_cursorLayer.bounds.size.width],
                               [NSNumber numberWithFloat:_cursorLayer.position.x+_maxWidth+_cursorLayer.bounds.size.width]];
    cursorAnimation.keyTimes = @[@(0),@(0.2),@(0.9), @(1)];
    cursorAnimation.duration = DURATION;
    cursorAnimation.repeatCount = NSIntegerMax;
    [_cursorLayer addAnimation:cursorAnimation forKey:kCurosrAnimationKey];
    
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"bounds"];
    scaleAnimation.toValue = [NSValue valueWithCGRect:CGRectMake(0, 0, _starImage.size.width*1.3, _starImage.size.height*1.3)];
    scaleAnimation.duration = DURATION/2;
    scaleAnimation.autoreverses = YES;
    scaleAnimation.repeatCount = NSIntegerMax;
    [_starLayer addAnimation:scaleAnimation forKey:kStarAnimationKey];
}

- (UIImage *)getCapsImage:(UIImage *)image {
    CGRect rect = CGRectMake(0, 0, _maxWidth, 9);
    UIGraphicsBeginImageContext(rect.size);
    [image drawInRect:rect];
    UIImage *drawImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return drawImage;
}

- (CALayer *)layerWithImage:(UIImage *)image {
    CALayer *tmp = [CALayer layer];
    tmp.contents = (id)image.CGImage;
    tmp.contentsScale = image.scale;
    return tmp;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _imageLayer.frame = self.bounds;
    _maskLayer.frame = self.bounds;
    _highLightImageLayer.frame = CGRectMake(self.bounds.size.width-_highLightImage.size.width, 0, _highLightImage.size.width, _highLightImage.size.height);
    _starLayer.frame = CGRectMake(self.bounds.size.width-_starImage.size.width+5.5, -_starImage.size.height/2+5, _starImage.size.width, _starImage.size.height);
}
@end
