//
//  MGJPFIntroGuideView.m
//  Animation
//
//  Created by Senmiao on 16/6/16.
//  Copyright © 2016年 juangua. All rights reserved.
//

#import "MGJPFIntroGuideView.h"
#import <QuartzCore/QuartzCore.h>
#import <sys/xattr.h>
#import <CommonCrypto/CommonDigest.h>
#import <MGJRouter/MGJRouter.h>
static const CGFloat kAnimationDuration = 0.3f;
static const CGFloat kCutoutRadius = 2.0f;
static const CGFloat kMaxLblWidth = 230.0f;
static const CGFloat kLblSpacing = 35.0f;
static const BOOL kEnableContinueLabel = NO;
static const BOOL kEnableSkipButton = NO;
static NSString *const kDateKeyPrefix = @"MGJPF.Wallet.Covermask.Date_";


//根据frame获得偏移坐标
CG_INLINE CGPoint CGPointGetShiftPoint(CGRect frame){
    CGPoint p; p.x = frame.origin.x + (MAX(CGRectGetWidth(frame), CGRectGetHeight(frame)) - (CGRectGetHeight(frame)))/2;p.y = frame.origin.y + ( (MAX(CGRectGetWidth(frame), CGRectGetHeight(frame)) - CGRectGetWidth(frame)))/2;return p;
}
//根据缩放系数和偏移坐标进行变化
CG_INLINE CGPoint CGPointMakeScaleAndShift(CGPoint originPoint, CGFloat scale, CGPoint shiftPoint){
    CGPoint p; p.x = originPoint.x * scale + shiftPoint.x; p.y = originPoint.y * scale + shiftPoint.y; return p;
}
CG_INLINE BOOL MGJPF_IS_EMPTY(id thing) {
    return thing == nil ||
    ([thing isEqual:[NSNull null]]) ||
    ([thing respondsToSelector:@selector(length)] && [(NSData *)thing length] == 0) ||
    ([thing respondsToSelector:@selector(count)]  && [(NSArray *)thing count] == 0);
}

#pragma Foundation Class Category

#pragma NSDate Category

@implementation NSString (MGJPFFoundation)

- (NSString *)mgj_md5HashString
{
    // Create pointer to the string as UTF8
    const char* ptr = [self UTF8String];
    unsigned char md5Buffer[CC_MD5_DIGEST_LENGTH];
    
    // Create 16 byte MD5 hash value, store in buffer
    CC_MD5(ptr, (int)strlen(ptr), md5Buffer);
    
    // Convert MD5 value in the buffer to NSString of hex values
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [output appendFormat:@"%02x",md5Buffer[i]];
    }
    
    return output;
}

@end

#pragma NSDate Category

@implementation NSDate (MGJPFIntroguideDate)

+ (id)getDateWithYear:(NSInteger)year withMonth:(NSInteger)month withDay:(NSInteger)day {
    //通过NSCALENDAR类来创建日期
    NSDateComponents *comp = [[NSDateComponents alloc] init];
    [comp setDay:day];
    [comp setMonth:month];
    [comp setYear:year];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *date = [calendar dateFromComponents:comp];
    
    return date;
}

- (NSInteger)numberOfNaturalDaysElapsed {
    NSDate *fromDate = nil, *toDate = nil;
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    [calendar rangeOfUnit:NSDayCalendarUnit startDate:&fromDate interval:NULL forDate:self];
    [calendar rangeOfUnit:NSDayCalendarUnit startDate:&toDate interval:NULL forDate:[NSDate date]];
    
    NSDateComponents *components = [calendar components:NSDayCalendarUnit
                                               fromDate:fromDate
                                                 toDate:toDate
                                                options:0];
    return [components day];
}

- (NSInteger)daysToDate:(NSDate *)date; {
    NSDate *fromDate = nil, *toDate = nil;
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    [calendar rangeOfUnit:NSDayCalendarUnit startDate:&fromDate interval:NULL forDate:self];
    [calendar rangeOfUnit:NSDayCalendarUnit startDate:&toDate interval:NULL forDate:date];
    
    NSDateComponents *components = [calendar components:NSDayCalendarUnit fromDate:fromDate
                                                 toDate:toDate options:0];
    return [components day];
}

+ (NSTimeInterval)timeStamp{
    return [[NSDate date] timeIntervalSince1970];
}

@end

#pragma UIBezierPath Category

@implementation UIBezierPath (MGJPFFoundation)
//得到⭐️曲线
+ (instancetype)bezierPathWithStarInRect:(CGRect)frame {
    CGFloat edgeLength = MIN(CGRectGetWidth(frame), CGRectGetHeight(frame));
    CGFloat scale = edgeLength/100;
    CGPoint shiftPoint = CGPointGetShiftPoint(frame);
    UIBezierPath *starPath = [UIBezierPath bezierPath];
    [starPath moveToPoint: CGPointMakeScaleAndShift(CGPointMake(50, 0),scale,shiftPoint)];
    [starPath addLineToPoint: CGPointMakeScaleAndShift(CGPointMake(67.64, 25.72),scale,shiftPoint)];
    [starPath addLineToPoint: CGPointMakeScaleAndShift(CGPointMake(97.55, 34.55),scale,shiftPoint)];
    [starPath addLineToPoint: CGPointMakeScaleAndShift(CGPointMake(78.54, 59.27),scale,shiftPoint)];
    [starPath addLineToPoint: CGPointMakeScaleAndShift(CGPointMake(79.39, 90.45),scale,shiftPoint)];
    [starPath addLineToPoint: CGPointMakeScaleAndShift(CGPointMake(50, 80.01),scale,shiftPoint)];
    [starPath addLineToPoint: CGPointMakeScaleAndShift(CGPointMake(20.61, 90.45),scale,shiftPoint)];
    [starPath addLineToPoint: CGPointMakeScaleAndShift(CGPointMake(21.46, 59.27),scale,shiftPoint)];
    [starPath addLineToPoint: CGPointMakeScaleAndShift(CGPointMake(2.45, 34.55),scale,shiftPoint)];
    [starPath addLineToPoint: CGPointMakeScaleAndShift(CGPointMake(32.36, 25.72),scale,shiftPoint)];
    [starPath closePath];
    return starPath;
}

@end

@implementation UIView (MGJPFIntroGuide)

- (CGFloat)width {
    return CGRectGetWidth(self.frame);
}

- (CGFloat)height {
    return CGRectGetHeight(self.frame);
}

- (CGSize)size {
    return self.frame.size;
}

@end

#pragma Help class

@interface MGJPFIntroGuideImageCache : NSObject
+ (void)cacheImageWithURL:(NSString *)imageURL;
+ (UIImage *)imageFromCache:(NSString *)imageURL;
@end

@implementation MGJPFIntroGuideImageCache
//将图片存入缓存
+ (void)cacheImage:(UIImage *)image withURL:(NSString *)imageURL {
    [self _createCacheDirectoryIfNeeded];
    NSData *imageData = UIImagePNGRepresentation(image);
    NSString *filepath = [self _imageCachedFilepathWithURL:imageURL];
    [imageData writeToFile:filepath atomically:YES];
}
//下载图片并存入缓存
+ (void)cacheImageWithURL:(NSString *)imageURL {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:imageURL]];
        NSHTTPURLResponse *response = nil;
        NSError *error = nil;
        NSData *resResult = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
        if (resResult != nil && [response statusCode] == 200) {
            [self _createCacheDirectoryIfNeeded];
            [resResult writeToFile:[self _imageCachedFilepathWithURL:imageURL] atomically:YES];
        }
    });
}
//取缓存（非下载）
+ (UIImage *)imageFromCache:(NSString *)imageURL {
    NSString *filepath = [self _imageCachedFilepathWithURL:imageURL];
    if (!MGJPF_IS_EMPTY(filepath) && ![[NSFileManager defaultManager] fileExistsAtPath:filepath]) {
        return nil;
    }
    NSData *imageData = [NSData dataWithContentsOfFile:filepath];
    UIImage *image = [UIImage imageWithData:imageData scale:2];
    return image;
}

#pragma mark - Private Method

+ (void)_createCacheDirectoryIfNeeded {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *path = [NSString stringWithFormat:@"%@/Documents/Pay/Cache/", NSHomeDirectory()];
    if (!MGJPF_IS_EMPTY(path) && ![fileManager fileExistsAtPath:path isDirectory:NULL]) {
        [fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    }
}

+ (NSString *)_imageCachedFilepathWithURL:(NSString *)url {
    NSString *urlMd5 = [url mgj_md5HashString];
    NSString *path = [NSString stringWithFormat:@"%@/Documents/Pay/Cache/%@", NSHomeDirectory(), urlMd5];
    return path;
}

@end

#pragma Main class

@interface MGJPFIntroGuideView ()
/**  需要引导的view集合 */
@property (nonatomic, copy) NSArray <UIView *> *masksItems;
/**  需要表述的文字 */
@property (nonatomic, copy) NSArray <NSString *> *descptionItems;
/**  需要展示的字典集合 */
@property (nonatomic, copy) NSArray <NSDictionary *> *coachMarks;
/**
 *  需要展示的引导图片字典集合,其中字典key为imgae和point,分别表示要展示的引导图片和图片位置
 */
@property (nonatomic, strong) NSMutableArray <NSDictionary *> *guideImageItems;
/**  遮盖层 */
@property (nonatomic, strong) CAShapeLayer *mask;
/**  图片地址 */
@property (nonatomic, copy) NSString *imageURL;
/**  图片点击地址 */
@property (nonatomic, copy) NSString *redirectURL;
/**  展示图片位置 */
@property (nonatomic, assign) CGPoint singleShowPoint;

/**  是否展示 */
@property (nonatomic, assign, getter=isNeedShow) BOOL needShow;
@end


@implementation MGJPFIntroGuideView {
    NSUInteger markIndex;
    NSDictionary *shapeMap;
}

#pragma mark - init Methods

- (instancetype)initWithFrame:(CGRect)frame coachMarks:(NSArray *)marks {
    self = [super initWithFrame:frame];
    if (self) {
        self.coachMarks = marks;
        [self setup];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame loadCoachMarks:(NSArray<__kindof UIView *>  *)markItems andDescriptionItems:( NSArray<__kindof NSString *> *)descriptionItems {
    self = [self initWithFrame:frame];
    if (self) {
        self.masksItems = markItems;
        self.descptionItems = descriptionItems;
        [self setup];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame loadCoachMarks:( NSArray <__kindof UIView *> *)markItems andGuideImageItems:(NSArray<__kindof NSDictionary *>  * __nullable)guideImageItems {
    self = [self initWithFrame:frame];
    if (self) {
        self.masksItems = markItems;
        [self.guideImageItems addObjectsFromArray:guideImageItems];
    }
    return self;
}

- (void)setup {
    // Default
    self.autoCalculateGuidePoint = YES;
    self.animationDuration = kAnimationDuration;
    self.cutoutRadius = kCutoutRadius;
    self.maxLblWidth = kMaxLblWidth;
    self.lblSpacing = kLblSpacing;
    self.enableContinueLabel = kEnableContinueLabel;
    self.enableSkipButton = kEnableSkipButton;
    shapeMap = @{@"circle":@(MGJPFIntroGuideShape_Circle),
                 @"square":@(MGJPFIntroGuideShape_Square),
                 @"star":@(MGJPFIntroGuideShape_Star)};
    // 设置遮盖层
    [self.layer addSublayer:self.mask];
    // 设置显示文字
    [self addSubview:self.lblCaption];
    // 设置显示图片
    [self addSubview:self.guideImageView];
    
    // Hide until unvoked
    self.hidden = YES;
}
#pragma mark - public Method

- (void)loadMarks: (NSArray <__kindof UIView *> *)markItems {
    self.masksItems = markItems;
}

- (void)loadGuideImageItem:(NSArray <__kindof NSDictionary *> *)guideImageItems {
    [self.guideImageItems addObjectsFromArray:guideImageItems];
}

- (void)loadDescriptionItems:(NSArray<__kindof NSString *>  *)descriptionItems {
    self.descptionItems = descriptionItems;
}

- (void)loadGuideImageUrl:(NSString *)imageURL withPoint:(CGPoint)imagePoint redirectURL:(NSString *)redirectURL withFrequency:(NSInteger)days {
    self.imageURL = imageURL;
    self.redirectURL = redirectURL;
    
    if (![MGJPFIntroGuideImageCache imageFromCache:imageURL]) {
        [MGJPFIntroGuideImageCache cacheImageWithURL:imageURL];
    }
    self.singleShowPoint = imagePoint;
    
    [self addActionForView:self.guideImageView];
    self.showFrequency = days;
}
#pragma mark - Navigation

- (void)start {
    NSAssert(self.superview, @"MGJPFIntroGuideView should have a superView");
    // Fade in self
    self.alpha = 1.0f;
    self.hidden = NO;
    __weak __typeof (self) weakSelf = self;
    [UIView animateWithDuration:self.animationDuration
                     animations:^{
                         __weak __typeof (weakSelf) strongSelf = weakSelf;
                         strongSelf.alpha = 1.0f;
                     }
                     completion:^(BOOL finished) {
                         __weak __typeof (weakSelf) strongSelf = weakSelf;
                         [self _checkNumberOfDaysElapsed:self.showFrequency excuteBlock:^{
                             do {
                                 if (![MGJPFIntroGuideImageCache imageFromCache:strongSelf.imageURL]) {
                                     if (strongSelf.imageURL) {
                                         [strongSelf saveNoDate];
                                         [strongSelf cleanup];
                                         break;
                                     }
                                 }
                                 UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:strongSelf action:@selector(userDidTap:)];
                                 [strongSelf addGestureRecognizer:tapGestureRecognizer];
                                 [strongSelf generateGuideImageIfNeeded];
                                 [strongSelf goToCoachMarkIndexed:0];
                             }while(0);
                             
                         } failureblock:^{
                             __weak __typeof (weakSelf) strongSelf = weakSelf;
                             [strongSelf cleanup];
                         }];
                     }];
}

#pragma mark - Cutout modify
- (void)animateGuideImgae:(UIImage *)guideImage withPoint:(CGPoint)point {
    self.guideImageView.image = guideImage;
    [self.guideImageView sizeToFit];
    if (self.autoCalculateGuidePoint) {
        CGFloat scale = [UIScreen mainScreen].bounds.size.width / 375;
        CGFloat X = point.x;
        X = (X/scale + self.guideImageView.frame.size.width)*scale - self.guideImageView.frame.size.width;
        point = CGPointMake(X, point.y);
    }
    self.guideImageView.frame = (CGRect) {point,self.guideImageView.frame.size};
}
- (void)animateCutoutToRect:(CGRect)rect withShape:(MGJPFIntroGuideShape)shape {
    // Define shape
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRect:self.bounds];
    UIBezierPath *cutoutPath;
    switch (shape) {
        case MGJPFIntroGuideShape_Square: {
            cutoutPath = [UIBezierPath bezierPathWithRect:rect];
            break;
        }
        case MGJPFIntroGuideShape_Circle: {
            cutoutPath = [UIBezierPath bezierPathWithOvalInRect:rect];
            break;
        }
        case MGJPFIntroGuideShape_Star: {
            cutoutPath = [UIBezierPath bezierPathWithStarInRect:rect];
            break;
        }
        case MGJPFIntroGuideShape_Other: {
            cutoutPath = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:self.cutoutRadius];
            break;
        }
    }
    
    [maskPath appendPath:cutoutPath];
    
    // Animate it
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"path"];
    anim.delegate = self;
    anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    anim.duration = self.animationDuration;
    anim.removedOnCompletion = NO;
    anim.fillMode = kCAFillModeForwards;
    anim.fromValue = (__bridge id)(self.mask.path);
    anim.toValue = (__bridge id)(maskPath.CGPath);
    [self.mask addAnimation:anim forKey:@"path"];
    self.mask.path = maskPath.CGPath;
}
- (void)animateCaptionLabelWith:(NSString *)description withRect:(CGRect)markRect {
    self.lblCaption.alpha = 0.0f;
    self.lblCaption.frame = (CGRect) {{0.0f, 0.0f}, {self.maxLblWidth, 0.0f}};
    self.lblCaption.text = description;
    [self.lblCaption sizeToFit];
    CGFloat y = markRect.origin.y + markRect.size.height + self.lblSpacing;
    CGFloat bottomY = y + self.lblCaption.frame.size.height + self.lblSpacing;
    if (bottomY > self.bounds.size.height) {
        y = markRect.origin.y - self.lblSpacing - self.lblCaption.frame.size.height;
    }
    CGFloat x = floorf((self.bounds.size.width - self.lblCaption.frame.size.width) / 2.0f);
    
    // Animate the caption label
    self.lblCaption.frame = (CGRect) {{x, y}, self.lblCaption.frame.size};
    
    [UIView animateWithDuration:0.3f animations:^{
        self.lblCaption.alpha = 1.0f;
    }];
}
#pragma mark - private Method
//进行展示的主要函数
- (void)goToCoachMarkIndexed:(NSUInteger)index {
    // Out of bounds
    if (index >= self.coachMarks.count && index >= self.masksItems.count) {
        [self cleanup];
        return;
    }
    markIndex = index;
    
    // Coach mark definition
    NSDictionary *markDef  = nil;
    NSString *markCaption = nil;
    CGRect markRect  = CGRectZero;
    MGJPFIntroGuideShape shape = self.guideShape;
    if (self.coachMarks.count) {
        markDef = [self.coachMarks objectAtIndex:index];
        markCaption = [markDef objectForKey:@"caption"];
        markRect = [[markDef objectForKey:@"rect"] CGRectValue];
        if ([[markDef allKeys] containsObject:@"shape"]) {
            NSString *currentShape = [markDef objectForKey:@"shape"];
            if ([[shapeMap allKeys] containsObject:currentShape]) {
                shape = shapeMap[currentShape];
            }
        }
    }else if (self.masksItems.count) {
        if (index < self.descptionItems.count) {
            markCaption = self.descptionItems[index];
        }
        markRect = ({
            UIView *view = self.masksItems[index];
            CGRect frame = [view.superview convertRect:view.frame toView:self.superview];
            CGRectInset(frame,self.insetSpacing,self.insetSpacing);
        });
    } else {
        return;
    }
    if ([self.delegate respondsToSelector:@selector(coachMarksView:willNavigateToIndex:)]) {
        [self.delegate coachMarksView:self willNavigateToIndex:markIndex];
    }
    UIImage *guideImage = nil;
    CGPoint point = CGPointZero;
    if (index < self.guideImageItems.count) {
        guideImage = self.guideImageItems[index][@"image"];
        point = [self.guideImageItems[index][@"point"] CGPointValue];
    }
    [self animateGuideImgae:guideImage withPoint:point];
    // 运行标签动画
    [self animateCaptionLabelWith:markCaption withRect:markRect];
    // 运行展示动画
    [self animateCutoutToRect:markRect withShape:shape];
    if (self.enableContinueLabel) {
        //当第一次展现时出现
        if (markIndex == 0) {
            [self addSubview:self.lblContinue];
        } else if (markIndex > 0 && self.lblContinue != nil) {
            [self.lblContinue removeFromSuperview];
        }
    }
    if (self.enableSkipButton) {
        [self addSubview:self.btnSkipCoach];
    }
}
//根据展示频率检查是否需要展示引导层
- (void)_checkNumberOfDaysElapsed:(NSInteger)days excuteBlock:(void (^)(void))block failureblock:(void (^)(void))failureblock{
    NSDate *date = [self dateFromUserDefaults];
    if (!date) {
        do {
            if ([self isNeedShow] && days) {
                [self saveTodayToUserDefaults];
                !block?:block();
                break;
            }
            !failureblock?:failureblock();
        }while(NO);
    } else {
        NSInteger es = [date numberOfNaturalDaysElapsed];
        if (es >= days) {
            !block?:block();
            [self saveTodayToUserDefaults];
        } else {
            !failureblock?:failureblock();
        }
    }
}

- (NSDate *)dateFromUserDefaults {
    NSDate *date = nil;
    if (!MGJPF_IS_EMPTY(self.imageURL)) {
        NSString *key = [kDateKeyPrefix stringByAppendingString:self.imageURL];
        date = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    } else if ([self isNeedShow]) {
        NSString *key = kDateKeyPrefix;
        date = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    }
    return date;
}

- (void)saveTodayToUserDefaults {
    if (!MGJPF_IS_EMPTY(self.imageURL)) {
        NSString *key = [kDateKeyPrefix stringByAppendingString:self.imageURL];
        [[NSUserDefaults standardUserDefaults] setObject:[NSDate date] forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
    } else if ([self isNeedShow]) {
        NSString *key = kDateKeyPrefix;
        [[NSUserDefaults standardUserDefaults] setObject:[NSDate date] forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}
- (void)saveNoDate {
    if (!MGJPF_IS_EMPTY(self.imageURL)) {
        NSString *key = [kDateKeyPrefix stringByAppendingString:self.imageURL];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}
//是否添加引导展示图片
- (void)generateGuideImageIfNeeded {
    UIImage *image = [MGJPFIntroGuideImageCache imageFromCache:self.imageURL];
    if (image) {
        [self.guideImageItems addObject:@{@"image":image,@"point":[NSValue valueWithCGPoint:self.singleShowPoint]}];
    }
}
//给view添加方法
- (void)addActionForView:(UIView *)view {
    view.userInteractionEnabled = YES;
    [view addGestureRecognizer:({
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTouchGuideImage)];
        tap;
    })];
}

#pragma mark - event Response
//用户点击背景
- (void)userDidTap:(UITapGestureRecognizer *)recognizer {
    // Go to the next coach mark
    [self goToCoachMarkIndexed:(markIndex+1)];
}
//跳过
- (void)skipCoach {
    [self goToCoachMarkIndexed:self.coachMarks.count];
}
//展示引导
- (void)didTouchGuideImage {
    if (!MGJPF_IS_EMPTY(self.redirectURL)) {
        BOOL open = [MGJRouter canOpenURL:self.redirectURL];
        if (open) {
            [MGJRouter openURL:self.redirectURL];
        } else {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.redirectURL]];
        }
    }
    [self cleanup];
}
#pragma mark - Cleanup

- (void)cleanup {
    // Delegate (coachMarksViewWillCleanup:)
    if ([self.delegate respondsToSelector:@selector(coachMarksViewWillCleanup:)]) {
        [self.delegate coachMarksViewWillCleanup:self];
    }
    __weak __typeof (self) weakSelf = self;;
    // 消失
    [UIView animateWithDuration:self.animationDuration
                     animations:^{
                         __weak __typeof (weakSelf) strongSelf = weakSelf;
                         strongSelf.alpha = 0.0f;
                     }
                     completion:^(BOOL finished) {
                         __weak __typeof (weakSelf) strongSelf = weakSelf;
                         // Remove self
                         [strongSelf removeFromSuperview];
                         // Delegate (coachMarksViewDidCleanup:)
                         if ([strongSelf.delegate respondsToSelector:@selector(coachMarksViewDidCleanup:)]) {
                             [strongSelf.delegate coachMarksViewDidCleanup:strongSelf];
                         }
                     }];
}

#pragma mark - Animation delegate

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    // Delegate (coachMarksView:didNavigateTo:atIndex:)
    if ([self.delegate respondsToSelector:@selector(coachMarksView:didNavigateToIndex:)]) {
        [self.delegate coachMarksView:self didNavigateToIndex:markIndex];
    }
}
#pragma mark - Accessor
- (UILabel *)lblCaption {
    if (!_lblCaption) {
        _lblCaption = [[UILabel alloc] initWithFrame:(CGRect) {{0.0f, 0.0f}, {self.maxLblWidth, 0.0f}}];
        self.lblCaption.backgroundColor = [UIColor clearColor];
        self.lblCaption.textColor = [UIColor whiteColor];
        self.lblCaption.font = [UIFont systemFontOfSize:20.0f];
        self.lblCaption.lineBreakMode = NSLineBreakByWordWrapping;
        self.lblCaption.numberOfLines = 0;
        self.lblCaption.textAlignment = NSTextAlignmentCenter;
        self.lblCaption.alpha = 0.0f;
    }
    return _lblCaption;
}

- (CAShapeLayer *)mask {
    if (!_mask) {
        _mask = [CAShapeLayer layer];
        [_mask setFillRule:kCAFillRuleEvenOdd];
        [_mask setFillColor:[[UIColor colorWithHue:0.0f saturation:0.0f brightness:0.0f alpha:0.8f] CGColor]];
    }
    return _mask;
}

- (void)setMaskColor:(UIColor *)maskColor {
    _maskColor = maskColor;
    [self.mask setFillColor:[maskColor CGColor]];
}

- (UIButton *)btnSkipCoach {
    if (!_btnSkipCoach) {
        CGFloat lblContinueWidth = self.enableSkipButton ? (70.0/100.0) * self.bounds.size.width : self.bounds.size.width;
        CGFloat btnSkipWidth = self.bounds.size.width - lblContinueWidth;
        _btnSkipCoach = [[UIButton alloc] initWithFrame:(CGRect) {{lblContinueWidth, self.bounds.size.height - 30.0f}, {btnSkipWidth, 30.0f}}];
        [_btnSkipCoach addTarget:self action:@selector(skipCoach) forControlEvents:UIControlEventTouchUpInside];
        [_btnSkipCoach setTitle:@"跳过" forState:UIControlStateNormal];
        _btnSkipCoach.titleLabel.font = [UIFont boldSystemFontOfSize:13.0f];
        _btnSkipCoach.tintColor = [UIColor whiteColor];
    }
    return _btnSkipCoach;
}

- (UILabel *)lblContinue {
    if (!_lblContinue) {
        CGFloat lblContinueWidth = self.enableSkipButton ? (70.0/100.0) * self.bounds.size.width : self.bounds.size.width;
        _lblContinue = [[UILabel alloc] initWithFrame:(CGRect) {{0, self.bounds.size.height - 30.0f}, {lblContinueWidth, 30.0f}}];
        _lblContinue.font = [UIFont boldSystemFontOfSize:13.0f];
        _lblContinue.textAlignment = NSTextAlignmentCenter;
        _lblContinue.text = @"点击继续";
        _lblContinue.backgroundColor = [UIColor whiteColor];
    }
    return _lblContinue;
}

- (UIImageView *)guideImageView {
    if (!_guideImageView) {
        _guideImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    }
    return _guideImageView;
}

- (NSMutableArray *)guideImageItems {
    if (!_guideImageItems) {
        _guideImageItems = [NSMutableArray array];
    }
    return _guideImageItems;
}

- (BOOL)isNeedShow {
    return !MGJPF_IS_EMPTY(self.guideImageItems)||!MGJPF_IS_EMPTY(self.descptionItems)||!MGJPF_IS_EMPTY(self.masksItems);
}

@end