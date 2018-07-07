//
//  LaunchAd.h
//  LaunchAd
//
//  Created by Superman on 2018/7/6.
//  Copyright © 2018年 Superman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+JWWebCache.h"

typedef void (^LaunchAdClickBlock)();

@interface LaunchAd : UIView
/**
 *  是否隐藏跳过按钮
 */
@property (nonatomic ,assign) BOOL hideSkip;
/**
 *  广告图
 */
@property(nonatomic,strong) UIImageView *adImgView;
/**
 *  广告frame
 */
@property (nonatomic, assign) CGRect adFrame;
/**
 *  加载完回调
 */
@property (nonatomic, copy) void(^LaunchAdClickBlock)(UIImage *image, NSURL *url);

/**
 *  广告点击事件回调
 */
@property(nonatomic,copy)LaunchAdClickBlock clickBlock;

/**
 *  初始化启动页广告
 *
 *  @param frame        frane
 *  @param strUrl       URL
 *  @param adDuration   停留时间
 *  @param adClickBlock 点击广告回调
 *  @param result       加载完成回调
 *
 *  @return self
 */
+ (instancetype)initImageWithURL:(CGRect)frame strUrl:(NSString *)strUrl adDuration:(NSInteger)adDuration options:(JWWebImageOptions)options result:(JWWebImageCompletionBlock)result;

/**
 *  清理缓冲
 */
+ (void)clearDiskCache;

/**
 *  内部初始化 - 无需调用
 *
 *  @param frame      frame
 *  @param adDuration 停留时间
 *
 *  @return self
 */
- (instancetype)initWithFrame:(CGRect)frame adDuration:(NSInteger)adDuration;



@end
