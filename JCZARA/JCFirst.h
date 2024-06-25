//
//  JCFirst.h
//  JCZARA
//
//  Created by wjc on 2024/6/20.
//

#import <UIKit/UIKit.h>
#import "changeNameDelegate.h"
NS_ASSUME_NONNULL_BEGIN

@interface JCFirst : UIViewController

@property (nonatomic, strong) UIButton *modifyButton;
@property (nonatomic, strong) id<changeDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
