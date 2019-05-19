//
//  ViewController.m
//  DuiLeiAnimation
//
//  Created by vspn_iMac2 on 2019/5/13.
//  Copyright © 2019 vspn_iMac2. All rights reserved.
//

#import "ViewController.h"
#import "TGADuiLeiImageView.h"
#import "TGASupportAnimateView.h"

@interface ViewController ()
@property (nonatomic, strong) TGADuiLeiImageView *imageView;
@property (nonatomic, assign) CGFloat normalWidth;
@property (nonatomic, weak) TGASupportAnimateView *duolei;
@property (nonatomic, strong) CALayer *layer;
@property (nonatomic, strong) CALayer *layer1;
@property (nonatomic, assign) BOOL ischanged;
@end

@implementation ViewController
- (IBAction)remove:(id)sender {
    [_duolei removeFromSuperview];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blackColor];
    
//    UIImage *image = [[UIImage imageNamed:@"蓝色经验条@3x(1)"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 30) resizingMode:UIImageResizingModeStretch];
//    UIImage *starBackgroundImage = [[UIImage imageNamed:@"1122x"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 30) resizingMode:UIImageResizingModeStretch];
//    UIImage *arrowImage = [[UIImage imageNamed:@"左边快速箭头光@3x(1)"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0) resizingMode:UIImageResizingModeTile];
//    CGFloat imageWidth = arrowImage.size.width, imageHeight = arrowImage.size.height;
//    _normalWidth = imageWidth;
//    _imageView = [[TGADuiLeiImageView alloc] initWithFrame:CGRectMake((self.view.bounds.size.width-imageWidth)/2, (self.view.bounds.size.height-imageHeight)/2, imageWidth, imageHeight) image:image animateImage:arrowImage starBackground:starBackgroundImage star:[UIImage imageNamed:@"右边光@3x(1)"]];
//    [self.view addSubview:_imageView];
//    _imageView.userInteractionEnabled = YES;
//
//    UIImageView *imageView1 = [[UIImageView alloc] initWithImage:arrowImage];
//    imageView1.frame = CGRectMake((self.view.bounds.size.width-imageWidth)/2, (self.view.bounds.size.height-imageHeight)/2+100, imageWidth, imageHeight);
//    [self.view.layer addSublayer:imageView1.layer];
//
//    UIGraphicsBeginImageContext(CGSizeMake(imageWidth, imageHeight));
//    [arrowImage drawInRect:CGRectMake(0, 0, imageWidth, imageHeight)];
//    UIImage *drawImage = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//
//    CALayer *imageLayer = [CALayer layer];
//    imageLayer.frame = CGRectMake((self.view.bounds.size.width-imageWidth)/2, (self.view.bounds.size.height-imageHeight)/2+140, imageWidth, imageHeight);
//    imageLayer.contents = (id)drawImage.CGImage;
////    imageLayer.contentsCenter = CGRectMake(0, 0, 0.1, 0.1);
//    [self.view.layer addSublayer:imageLayer];
//
//    TGADuiLeiImageView *newDuilei = [[TGADuiLeiImageView alloc] initWithFrame:CGRectMake((self.view.bounds.size.width-imageWidth*2)/2, (self.view.bounds.size.height-imageHeight)/2-60, imageWidth*2, imageHeight) image:image animateImage:arrowImage starBackground:starBackgroundImage star:[UIImage imageNamed:@"右边光@3x(1)"]];
//    [self.view addSubview:newDuilei];
    
//    UIImageView *animateView = [[UIImageView alloc] initWithFrame:CGRectMake((self.view.bounds.size.width-imageWidth)/2, (self.view.bounds.size.height-imageHeight)/2, imageWidth, imageHeight)];
//    animateView.image = image;
//    CALayer *mask = [CALayer layer];
//    mask.contents = (id)image.CGImage;
//    mask.frame = animateView.bounds;
//    animateView.layer.mask = mask;
//    [self.view addSubview:animateView];
//
//    UIImageView *white = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"1122x"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 10) resizingMode:UIImageResizingModeStretch]];
//    white.frame = animateView.bounds;
////    white.contentMode = UIViewContentModeRight;
//    [animateView addSubview:white];
//
//    CALayer *contentLayer = [CALayer layer];
//    contentLayer.contents = (id)arrowImage.CGImage;
//    contentLayer.frame = animateView.bounds;
//    [animateView.layer addSublayer:contentLayer];
//
//    CALayer *animateLayer = [CALayer layer];
//    animateLayer.contents = (id)arrowImage.CGImage;
//    animateLayer.frame = CGRectMake(contentLayer.frame.origin.x-imageWidth, 0, imageWidth, imageHeight);
//    [animateView.layer addSublayer:animateLayer];
//
//    CABasicAnimation *contentAnimation = [CABasicAnimation animationWithKeyPath:@"position.x"];
//    contentAnimation.toValue = [NSNumber numberWithFloat:contentLayer.position.x+imageWidth];
//    contentAnimation.duration = 2.f;
//    contentAnimation.repeatCount = NSIntegerMax;
//    [contentLayer addAnimation:contentAnimation forKey:@"1"];
//
//    CABasicAnimation *animateAnimation = [CABasicAnimation animationWithKeyPath:@"position.x"];
//    animateAnimation.toValue = [NSNumber numberWithFloat:animateLayer.position.x+imageWidth];
//    animateAnimation.duration = 2.f;
//    animateAnimation.repeatCount = NSIntegerMax;
//    [animateLayer addAnimation:animateAnimation forKey:@"2"];
    
    
    
    TGASupportAnimateView *animateView = [[TGASupportAnimateView alloc] initWithFrame:CGRectMake(100, 100, 100, 9) viewMode:TGASupportAnimateViewLeftMode maxWidth:160 image:nil];
    _normalWidth=100;
    animateView.userInteractionEnabled = YES;
    [self.view addSubview:animateView];
    _duolei = animateView;
    
    _layer = [CALayer layer];
    _layer.contents = (id)[UIImage imageNamed:@"蓝色经验条@3x(1)"].CGImage;
    _layer.frame = CGRectMake(100, 200, 100, 9);
    [self.view.layer addSublayer:_layer];
    
    _layer1 = [CALayer layer];
    _layer1.contents = (id)[UIImage imageNamed:@"蓝色经验条@3x(1)"].CGImage;
    _layer1.frame = CGRectMake(100, 210, 100, 9);
    [self.view.layer addSublayer:_layer1];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    [_duolei removeFromSuperview];
    _ischanged = !_ischanged;
    _layer.contents = _ischanged?nil:(id)[UIImage imageNamed:@"蓝色经验条@3x(1)"].CGImage;
    _layer1.opacity = !_ischanged;
    
//    [_duolei removeFromSuperview];
}


- (IBAction)changeWidthAction:(UISlider *)sender {
    CGRect normal = _duolei.frame;
    normal.size.width = (sender.value+0.5)*_normalWidth;
    _duolei.frame = normal;
}
@end
