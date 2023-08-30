//
//  DHCommon.h
//  dh_native_photo
//
//  Created by dh on 2023/8/30.
//

//#ifndef DHCommon_h
//#define DHCommon_h

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

/** 通过name及Bundle获取图片*/
#define SmartBundleImageNamed(imageName,bundleName) [UIImage imageNamed:imageName inBundle:[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:bundleName ofType:@"bundle"]] compatibleWithTraitCollection:nil]

#define SmartImageNamed(imageName) [UIImage imageNamed:imageName inBundle:[NSBundle bundleWithPath:[[NSBundle bundleForClass:[self class]] pathForResource:@"DHNativePhoto" ofType:@"bundle"]] compatibleWithTraitCollection:nil]


#define ZWTStatusBarHeight ({\
CGFloat statusBarH = 20;\
if(@available(iOS 13.0, *)){\
    statusBarH = [UIApplication sharedApplication].windows.firstObject.windowScene.statusBarManager.statusBarFrame.size.height;\
}else{\
    statusBarH = [[UIApplication sharedApplication] statusBarFrame].size.height;\
}\
statusBarH;\
})


//#endif /* DHCommon_h */
