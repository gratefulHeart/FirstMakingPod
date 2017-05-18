

#import "HBAlertController.h"
#define IOS7  ([[[UIDevice currentDevice]systemVersion] floatValue] < 8.0)
typedef void (^ButtonClick)(NSUInteger index);

@interface HBAlertController()<UIAlertViewDelegate>
{

    
    
}
@property(nonatomic,copy)ButtonClick selectIndex;

@end
@implementation HBAlertController

static HBAlertController * alertController = nil;

+(instancetype)shareAlert {

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        alertController = [[HBAlertController alloc]init];
    });
    return alertController;
}
+(void)alertControllerShowInViewController:(id)viewController
                                     title:(NSString *)title
                                   message:(NSString *)message
                                     color:(UIColor *)color
                                     range:(NSRange )range
                                actionName:(NSArray *)nameArr
                                 nameColor:(NSArray *)colorArr
                                   handler:(void (^)(NSUInteger index))clickIndex
{
    
    if (IOS7) {
        
        [self showAlertWithTitle:title message:message actionName:nameArr handler:clickIndex];
        
    }
    else{
    
        UIColor *baseColor = [UIColor blackColor];
        UIColor *hlightColor = [UIColor blackColor];
        if (color!=nil) {
            hlightColor = color;
        }
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
        NSMutableAttributedString *messageAttributeStr = [[NSMutableAttributedString alloc] initWithString:message];
        [messageAttributeStr addAttribute:NSForegroundColorAttributeName value: baseColor range:NSMakeRange(0, message.length)];
        [messageAttributeStr addAttribute:NSForegroundColorAttributeName value: hlightColor range:range];
        [messageAttributeStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"STHeitiSC-Light" size:14] range:NSMakeRange(0, message.length)];
        [alert setValue:messageAttributeStr forKey:@"attributedMessage"];
        
        if (nameArr!=nil && colorArr!=nil && [nameArr count]==[colorArr count]) {
            
            for (int i =0 ; i<[nameArr count]; i++) {
                NSString *btnTitle = [NSString stringWithFormat:@"%@",[nameArr objectAtIndex:i]];
                UIColor *btnTitleColor = [colorArr objectAtIndex:i];
                UIAlertAction *action = [UIAlertAction actionWithTitle:btnTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    
                    if (clickIndex) {
                        clickIndex(i);
                    }
                }];
                
                if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.3) {
                    [action setValue:btnTitleColor forKey:@"titleTextColor"];
                }
                [alert addAction:action];
            }
        }
        else
        {
            if (nameArr!=nil) {
                for (int i =0 ; i<[nameArr count]; i++) {
                    NSString *btnTitle = [NSString stringWithFormat:@"%@",[nameArr objectAtIndex:i]];
                    UIAlertAction *action = [UIAlertAction actionWithTitle:btnTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        if (clickIndex) {
                            clickIndex(i);
                        }
                    }];
                    [alert addAction:action];
                }
            }
            else
            {
                UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    if (clickIndex) {
                        clickIndex(0);
                    }
                }];
                [alert addAction:action];
            }
        }
        [viewController presentViewController:alert animated:YES completion:nil];
        
    }
    
    
}

+ (void)showAlertWithTitle:(NSString *)title message:(NSString *)message  actionName:(NSArray *)nameArr  handler:(void (^)(NSUInteger index))clickIndex{

    UIAlertView *alertView = nil;
    HBAlertController *al = [HBAlertController shareAlert];
    
    if (nameArr==nil || [nameArr count]<=0) {
        alertView = [[UIAlertView alloc]initWithTitle:title message:message delegate:self cancelButtonTitle:@"我知道了" otherButtonTitles:nil, nil];
    }
    else if ([nameArr count]==1){
        alertView = [[UIAlertView alloc]initWithTitle:title message:message delegate:self cancelButtonTitle:nameArr[0] otherButtonTitles:nil, nil];
    }
    else{
        alertView = [[UIAlertView alloc]initWithTitle:title message:message delegate:self cancelButtonTitle:nameArr[0] otherButtonTitles:nameArr[1], nil];
    }
    alertView.delegate = al;
    
    al.selectIndex = clickIndex;
    
    [alertView show];
}
+(void)alertControllerShowInViewController:(id)viewController  title:(NSString *)title message:(NSString *)message actionName:(NSArray *)nameArr  handler:(void (^)(NSUInteger index))clickIndex{

    if (IOS7) {
        [self  showAlertWithTitle:title message:message actionName:nameArr handler:clickIndex];
    }
    else{
    
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
        for (int i =0 ; i<[nameArr count]; i++) {
            NSString *btnTitle = [NSString stringWithFormat:@"%@",[nameArr objectAtIndex:i]];
            UIAlertActionStyle style = UIAlertActionStyleCancel;
            if (i>0) {
                style = UIAlertActionStyleDefault;
            }
            UIAlertAction *action = [UIAlertAction actionWithTitle:btnTitle style:style handler:^(UIAlertAction * _Nonnull action) {
                if (clickIndex) {
                    clickIndex(i);
                }
            }];
            [alert addAction:action];
        }
        
        [viewController presentViewController:alert animated:YES completion:nil];
        
    }
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {

    HBAlertController *al = [HBAlertController shareAlert];
    if (al.selectIndex) {
        al.selectIndex(buttonIndex);
    }
}
@end
