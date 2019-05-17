//
//  TGASupportAnimateView.h
//  TGALiveSDK
//
//  Created by vspn_iMac2 on 2019/5/16.
//  Copyright © 2019 Tencent. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, TGASupportAnimateViewMode) {
    TGASupportAnimateViewLeftMode = 1,
    TGASupportAnimateViewRightMode
};


@interface TGASupportAnimateView : UIView
@property (nonatomic, assign) TGASupportAnimateViewMode viewMode;
- (instancetype)initWithFrame:(CGRect)frame viewMode:(TGASupportAnimateViewMode)viewMode maxWidth:(CGFloat)maxWidth image:(UIImage *)image;
@end

