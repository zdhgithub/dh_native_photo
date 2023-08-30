//
//  DDPhotoViewController.h
//  Loan
//

#import <UIKit/UIKit.h>


typedef void(^ImageBlock)(UIImage *image);

@interface DDPhotoViewController : UIViewController

@property (nonatomic, copy) ImageBlock imageblock;

/// 拍照
@property (nonatomic, strong, readonly) UIButton *PhotoButton;
/// 取消
@property (nonatomic, strong, readonly) UIButton *cancleButton;
/// 橘色边框
@property (nonatomic, strong, readonly) UIImageView *kuangImgView;
/// 提示字
@property (nonatomic, strong, readonly) UILabel *tishiLabel;
//确定选择当前照片
@property (nonatomic, strong, readonly) UIButton *selectButton;
//重新拍照
@property (nonatomic, strong, readonly) UIButton *reCamButton;
@end
