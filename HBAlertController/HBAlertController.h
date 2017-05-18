

#import <UIKit/UIKit.h>

@interface HBAlertController : UIAlertController


/**
 *  弹出框
 *
 *  @param viewController controller
 *  @param title          标题
 *  @param message        内容
 *  @param color          高亮颜色值
 *  @param range          高亮范围
 *  @param nameArr        按钮标题数组
 *  @param colorArr       按钮标题颜色
 *  @param clickIndex     点击回调
 */
+(void)alertControllerShowInViewController:(id)viewController  title:(NSString *)title message:(NSString *)message color:(UIColor *)color range:(NSRange )range  actionName:(NSArray *)nameArr nameColor:(NSArray *)colorArr handler:(void (^)(NSUInteger index))clickIndex;

/**
 弹出框

 @param viewController controller
 @param title 标题
 @param message 内容
 @param nameArr 名字
 @param clickIndex 点击
 */
+(void)alertControllerShowInViewController:(id)viewController  title:(NSString *)title message:(NSString *)message actionName:(NSArray *)nameArr  handler:(void (^)(NSUInteger index))clickIndex;

@end
