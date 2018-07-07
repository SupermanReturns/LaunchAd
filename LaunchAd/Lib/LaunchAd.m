//
//  LaunchAd.m
//  LaunchAd
//
//  Created by Superman on 2018/7/6.
//  Copyright © 2018年 Superman. All rights reserved.
//

#import "LaunchAd.h"

#define DefaultDuration 3;//默认停留时间

#ifdef DEBUG
#define DebugLog(...) NSLog(__VA_ARGS__)
#else
#define DebugLog(...)
#endif
@interface LaunchAd()
@property(nonatomic,strong)UIImageView *launchImgView;
@property(nonatomic,strong)UIButton *skipButton;
@property(nonatomic,copy) dispatch_source_t timer;
@property (nonatomic, assign) NSInteger adDuration;

@end


@implementation LaunchAd
- (instancetype)initWithFrame:(CGRect)frame adDuration:(NSInteger)adDuration{
    if (self = [super initWithFrame:frame]) {
        _adFrame = frame;
        _adDuration = adDuration;
        self.frame= [UIScreen mainScreen].bounds;
        [self addSubview:self.launchImgView];
        [self addSubview:self.adImgView];
        [self addSubview:self.skipButton];
        [self animateStart];
        [self animateEnd];
        [self addInWindow];
    }
    return self;
}
-(void)animateStart{
    CGFloat duration =DefaultDuration;
    if (_adDuration) duration =_adDuration;
    duration =duration/4.0;
    if (duration>1.0) duration=1.0;
    [UIView animateWithDuration:duration animations:^{
        self.adImgView.alpha=1;
    }completion:^(BOOL finished) {
    }];
}
-(void)animateEnd{
    CGFloat duration =DefaultDuration;
    if (_adDuration) duration = _adDuration;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration *NSEC_PER_SEC)),dispatch_get_main_queue(), ^{
        [self remove];
    });
}

-(UIImageView *)launchImgView{
    if (!_launchImgView) {
        _launchImgView = [[UIImageView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        _launchImgView.image = [self launchImage];
    }
    return _launchImgView;
}
-(UIImage *)launchImage{
    CGSize viewSize = [UIScreen mainScreen].bounds.size;
    NSString *viewOrientation = @"Portrait";
    NSString *launchImageName = nil;
    NSArray *imagesDict=[[[NSBundle mainBundle]infoDictionary] valueForKey:@"UILaunchImages"];
    
    for (NSDictionary *dict in imagesDict) {
        CGSize imageSize = CGSizeFromString(dict[@"UILaunchImageSize"]);
        
        if (CGSizeEqualToSize(imageSize, viewSize) && [viewOrientation isEqualToString:dict[@"UILaunchImageOrientation"]]) {
            launchImageName = dict[@"UILaunchImageName"];
            UIImage *image = [UIImage imageNamed:launchImageName];
            return image;
        }
    }
    return nil;
}
-(UIImageView *)adImgView{
    if (!_adImgView) {
        _adImgView= [[UIImageView alloc]initWithFrame:_adFrame];
        _adImgView.userInteractionEnabled=YES;
        _adImgView.alpha=0.2;
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
        [_adImgView addGestureRecognizer:tap];
    }
    return _adImgView;
}
-(void)tapAction:(UITapGestureRecognizer *)tap{
    if(self.clickBlock){
        self.clickBlock();
    }
}
-(UIButton *)skipButton{
    if (!_skipButton) {
        _skipButton =[UIButton buttonWithType:UIButtonTypeCustom];
        _skipButton.frame= CGRectMake([UIScreen mainScreen].bounds.size.width-70, 30, 60, 30);
        _skipButton.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
        _skipButton.layer.cornerRadius=15;
        _skipButton.layer.masksToBounds = YES;
        NSInteger duration =DefaultDuration;
        if (_adDuration) {
            duration = _adDuration;
        }
        [_skipButton setTitle:[NSString stringWithFormat:@"%ld 跳过",duration] forState:UIControlStateNormal];
        _skipButton.titleLabel.font = [UIFont systemFontOfSize:13.5];
        [_skipButton addTarget:self action:@selector(skipAction) forControlEvents:UIControlEventTouchUpInside];
        [self dispath_tiemr];
    }
    return _skipButton;
}
-(void)dispath_tiemr{
    NSTimeInterval period =1.0;
    dispatch_queue_t queue =dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), period*NSEC_PER_SEC, 0);
    
    __block NSInteger duration =DefaultDuration;
    if (_adDuration) duration =_adDuration;
    
    dispatch_source_set_event_handler(_timer, ^{
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (duration>0) duration--;
            [_skipButton setTitle:[NSString stringWithFormat:@"%ld 跳过",duration] forState:UIControlStateNormal];
        });
    });
    dispatch_resume(_timer);
    
}
-(void)addInWindow{
    [[NSNotificationCenter defaultCenter]addObserverForName:UIApplicationDidFinishLaunchingNotification object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [[[UIApplication sharedApplication].delegate window] addSubview:self];
        });
    }];
}
-(void)skipAction{
    [self remove];
}
-(void)remove{
    [UIView animateWithDuration:0.8 animations:^{
        [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
        self.transform = CGAffineTransformMakeScale(1.5, 1.5);
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
-(void)setAdFrame:(CGRect)adFrame{
    _adFrame =adFrame;
    _adImgView.frame = adFrame;
}
-(void)setHideSkip:(BOOL)hideSkip{
    _hideSkip = hideSkip;
    _skipButton.hidden = hideSkip;
}
+ (instancetype)initImageWithURL:(CGRect)frame strUrl:(NSString *)strUrl adDuration:(NSInteger)adDuration options:(JWWebImageOptions)options result:(JWWebImageCompletionBlock)result{
    
    LaunchAd *launchAD =[[LaunchAd alloc]initWithFrame:frame adDuration:adDuration];
    [launchAD.adImgView jw_setImageWithURL:[NSURL URLWithString:strUrl] placeholderImage:nil completed:result];
    return launchAD;
}
#pragma mark - 清理缓冲
+ (void)clearDiskCache{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSFileManager *fileManager =[NSFileManager defaultManager];
        NSString *path =[JWWebImageDownloader cacheImagePath];
        [fileManager removeItemAtPath:path error:nil];
        
        [JWWebImageDownloader checkDirectory:path];
    });
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end



























