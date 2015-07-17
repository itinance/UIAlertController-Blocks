//
//  UIAlertController+Blocks.h
//  UIAlertControllerBlocks
//
//  Created by Ryan Maxwell on 11/09/14.
//
//  The MIT License (MIT)
//
//  Copyright (c) 2014 Ryan Maxwell
//  "Only-Once" and throttleTime extension 2015 by Hagen Hübel
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy of
//  this software and associated documentation files (the "Software"), to deal in
//  the Software without restriction, including without limitation the rights to
//  use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
//  the Software, and to permit persons to whom the Software is furnished to do so,
//  subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
//  FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
//  COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
//  IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
//  CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

#import <UIKit/UIKit.h>

typedef void (^UIAlertControllerPopoverPresentationControllerBlock) (UIPopoverPresentationController * __nonnull popover);
typedef void (^UIAlertControllerCompletionBlock) (UIAlertController * __nonnull controller, UIAlertAction * __nonnull action, NSInteger buttonIndex);

@interface UIAlertController (Blocks)


+ (nullable instancetype)showInViewController:(nonnull UIViewController *)viewController
                                   withTitle:(nullable NSString *)title
                                     message:(nullable NSString *)message
                                    onlyOnce:(bool) onlyOnce
                                throttleTime:(NSTimeInterval) throttle
                              preferredStyle:(UIAlertControllerStyle)preferredStyle
                           cancelButtonTitle:(nullable NSString *)cancelButtonTitle
                      destructiveButtonTitle:(nullable NSString *)destructiveButtonTitle
                           otherButtonTitles:(nullable NSArray *)otherButtonTitles
          popoverPresentationControllerBlock:(nullable UIAlertControllerPopoverPresentationControllerBlock)popoverPresentationControllerBlock
                                    tapBlock:(nullable UIAlertControllerCompletionBlock)tapBlock;

+ (nullable instancetype)showInViewController:(nonnull UIViewController *)viewController
                                   withTitle:(nullable NSString *)title
                                     message:(nullable NSString *)message
                                    onlyOnce:(bool) onlyOnce
                              preferredStyle:(UIAlertControllerStyle)preferredStyle
                           cancelButtonTitle:(nullable NSString *)cancelButtonTitle
                      destructiveButtonTitle:(nullable NSString *)destructiveButtonTitle
                           otherButtonTitles:(nullable NSArray *)otherButtonTitles
          popoverPresentationControllerBlock:(nullable UIAlertControllerPopoverPresentationControllerBlock)popoverPresentationControllerBlock
                                    tapBlock:(nullable UIAlertControllerCompletionBlock)tapBlock;

+ (nullable instancetype)showAlertInViewController:(nonnull UIViewController *)viewController
                                         withTitle:(nullable NSString *)title
                                           message:(nullable NSString *)message
                                          onlyOnce:(bool) onlyOnce
                                      throttleTime:(NSTimeInterval) throttle
                                 cancelButtonTitle:(nullable NSString *)cancelButtonTitle
                            destructiveButtonTitle:(nullable NSString *)destructiveButtonTitle
                                 otherButtonTitles:(nullable NSArray *)otherButtonTitles
                                          tapBlock:(nullable UIAlertControllerCompletionBlock)tapBlock;

+ (nullable instancetype)showAlertInViewController:(nonnull UIViewController *)viewController
                                        withTitle:(nullable NSString *)title
                                          message:(nullable NSString *)message
                                         onlyOnce:(bool) onlyOnce
                                cancelButtonTitle:(nullable NSString *)cancelButtonTitle
                           destructiveButtonTitle:(nullable NSString *)destructiveButtonTitle
                                otherButtonTitles:(nullable NSArray *)otherButtonTitles
                                         tapBlock:(nullable UIAlertControllerCompletionBlock)tapBlock;

+ (nullable instancetype)showActionSheetInViewController:(nonnull UIViewController *)viewController
                                              withTitle:(nullable NSString *)title
                                                message:(nullable NSString *)message
                                               onlyOnce:(bool) onlyOnce
                                      cancelButtonTitle:(nullable NSString *)cancelButtonTitle
                                 destructiveButtonTitle:(nullable NSString *)destructiveButtonTitle
                                      otherButtonTitles:(nullable NSArray *)otherButtonTitles
                     popoverPresentationControllerBlock:(nullable UIAlertControllerPopoverPresentationControllerBlock)popoverPresentationControllerBlock
                                               tapBlock:(nullable UIAlertControllerCompletionBlock)tapBlock;

@property (readonly, nonatomic) BOOL visible;
@property (readonly, nonatomic) NSInteger cancelButtonIndex;
@property (readonly, nonatomic) NSInteger firstOtherButtonIndex;
@property (readonly, nonatomic) NSInteger destructiveButtonIndex;

@end
