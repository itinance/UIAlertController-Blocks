//
//  UIAlertController+Blocks.m
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

#import "UIAlertController+Blocks.h"

static NSInteger const UIAlertControllerBlocksCancelButtonIndex = 0;
static NSInteger const UIAlertControllerBlocksDestructiveButtonIndex = 1;
static NSInteger const UIAlertControllerBlocksFirstOtherButtonIndex = 2;

@implementation UIAlertController (Blocks)

static bool isAlreadyVisible = false;
static NSDate* lastAlertClosed;

#define __UIALERT_CLEAR_VISIBLE_FLAG @synchronized([self class]) { isAlreadyVisible = false; lastAlertClosed = [NSDate date]; }

+ (nullable instancetype)showInViewController:(UIViewController *)viewController
                           withTitle:(NSString *)title
                             message:(NSString *)message
                            onlyOnce:(bool) onlyOnce
                        throttleTime:(NSTimeInterval) throttle
                      preferredStyle:(UIAlertControllerStyle)preferredStyle
                   cancelButtonTitle:(NSString *)cancelButtonTitle
              destructiveButtonTitle:(NSString *)destructiveButtonTitle
                   otherButtonTitles:(NSArray *)otherButtonTitles
  popoverPresentationControllerBlock:(void(^)(UIPopoverPresentationController *popover))popoverPresentationControllerBlock
                            tapBlock:(UIAlertControllerCompletionBlock)tapBlock
{
    
    @synchronized([self class]) {
        if(onlyOnce) {

            bool dontAlert = false;
            
            if(isAlreadyVisible) {
                dontAlert = true;
            }
            else {
                if(lastAlertClosed != nil) {
                    NSDate* now = [NSDate date];
                    NSTimeInterval interval = [now timeIntervalSinceDate:lastAlertClosed];
                    if(interval < throttle) {
                        dontAlert = true;
                        lastAlertClosed = [NSDate date];
                    }
                }
            }
            
            if(dontAlert) {
                NSLog(@"UIAlertController already visible. Will avoid to create another instance.");
                return nil;
            }
            
        }
    }
    
    
    UIAlertController *strongController = [self alertControllerWithTitle:title
                                                                 message:message
                                                          preferredStyle:preferredStyle];
    
    isAlreadyVisible = true;
    
    __weak UIAlertController *controller = strongController;
    
    if (cancelButtonTitle) {
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelButtonTitle
                                                               style:UIAlertActionStyleCancel
                                                             handler:^(UIAlertAction *action){
                                                                 __UIALERT_CLEAR_VISIBLE_FLAG;
                                                                 if (tapBlock) {
                                                                     tapBlock(controller, action, UIAlertControllerBlocksCancelButtonIndex);
                                                                 }
                                                             }];
        [controller addAction:cancelAction];
    }
    
    if (destructiveButtonTitle) {
        UIAlertAction *destructiveAction = [UIAlertAction actionWithTitle:destructiveButtonTitle
                                                                    style:UIAlertActionStyleDestructive
                                                                  handler:^(UIAlertAction *action){
                                                                      __UIALERT_CLEAR_VISIBLE_FLAG;
                                                                      if (tapBlock) {
                                                                          tapBlock(controller, action, UIAlertControllerBlocksDestructiveButtonIndex);
                                                                      }
                                                                  }];
        [controller addAction:destructiveAction];
    }
    
    for (NSUInteger i = 0; i < otherButtonTitles.count; i++) {
        NSString *otherButtonTitle = otherButtonTitles[i];
        
        UIAlertAction *otherAction = [UIAlertAction actionWithTitle:otherButtonTitle
                                                              style:UIAlertActionStyleDefault
                                                            handler:^(UIAlertAction *action){
                                                                __UIALERT_CLEAR_VISIBLE_FLAG;
                                                                if (tapBlock) {
                                                                    tapBlock(controller, action, UIAlertControllerBlocksFirstOtherButtonIndex + i);
                                                                }
                                                            }];
        [controller addAction:otherAction];
    }
    
    if (popoverPresentationControllerBlock) {
        popoverPresentationControllerBlock(controller.popoverPresentationController);
    }
    
    [viewController presentViewController:controller animated:YES completion:nil];
    
    return controller;
}

+ (nullable instancetype)showInViewController:(UIViewController *)viewController
                           withTitle:(NSString *)title
                             message:(NSString *)message
                            onlyOnce:(bool) onlyOnce
                      preferredStyle:(UIAlertControllerStyle)preferredStyle
                   cancelButtonTitle:(NSString *)cancelButtonTitle
              destructiveButtonTitle:(NSString *)destructiveButtonTitle
                   otherButtonTitles:(NSArray *)otherButtonTitles
  popoverPresentationControllerBlock:(void(^)(UIPopoverPresentationController *popover))popoverPresentationControllerBlock
                            tapBlock:(UIAlertControllerCompletionBlock)tapBlock
{
    return [self showInViewController:viewController
                            withTitle:title
                              message:message
                             onlyOnce: onlyOnce
                         throttleTime: 0
                       preferredStyle:UIAlertControllerStyleAlert
                    cancelButtonTitle:cancelButtonTitle
               destructiveButtonTitle:destructiveButtonTitle
                    otherButtonTitles:otherButtonTitles
   popoverPresentationControllerBlock:nil
                             tapBlock:tapBlock];
}

+ (nullable instancetype)showAlertInViewController:(UIViewController *)viewController
                                         withTitle:(NSString *)title
                                           message:(NSString *)message
                                          onlyOnce:(bool) onlyOnce
                                      throttleTime:(NSTimeInterval) throttle
                                 cancelButtonTitle:(NSString *)cancelButtonTitle
                            destructiveButtonTitle:(NSString *)destructiveButtonTitle
                                 otherButtonTitles:(NSArray *)otherButtonTitles
                                          tapBlock:(UIAlertControllerCompletionBlock)tapBlock
{
    return [self showInViewController:viewController
                            withTitle:title
                              message:message
                             onlyOnce: onlyOnce
                         throttleTime: throttle
                       preferredStyle:UIAlertControllerStyleAlert
                    cancelButtonTitle:cancelButtonTitle
               destructiveButtonTitle:destructiveButtonTitle
                    otherButtonTitles:otherButtonTitles
   popoverPresentationControllerBlock:nil
                             tapBlock:tapBlock];
}

+ (nullable instancetype)showAlertInViewController:(UIViewController *)viewController
                                withTitle:(NSString *)title
                                  message:(NSString *)message
                                 onlyOnce:(bool) onlyOnce
                        cancelButtonTitle:(NSString *)cancelButtonTitle
                   destructiveButtonTitle:(NSString *)destructiveButtonTitle
                        otherButtonTitles:(NSArray *)otherButtonTitles
                                 tapBlock:(UIAlertControllerCompletionBlock)tapBlock
{
    return [self showInViewController:viewController
                            withTitle:title
                              message:message
                             onlyOnce: onlyOnce
                       preferredStyle:UIAlertControllerStyleAlert
                    cancelButtonTitle:cancelButtonTitle
               destructiveButtonTitle:destructiveButtonTitle
                    otherButtonTitles:otherButtonTitles
            popoverPresentationControllerBlock:nil
                             tapBlock:tapBlock];
}

+ (nullable instancetype)showActionSheetInViewController:(UIViewController *)viewController
                                      withTitle:(NSString *)title
                                        message:(NSString *)message
                                       onlyOnce:(bool) onlyOnce
                              cancelButtonTitle:(NSString *)cancelButtonTitle
                         destructiveButtonTitle:(NSString *)destructiveButtonTitle
                              otherButtonTitles:(NSArray *)otherButtonTitles
                                       tapBlock:(UIAlertControllerCompletionBlock)tapBlock
{
    return [self showActionSheetInViewController:viewController
                                       withTitle:title
                                         message:message
                                        onlyOnce:onlyOnce
                               cancelButtonTitle:cancelButtonTitle
                          destructiveButtonTitle:destructiveButtonTitle
                               otherButtonTitles:otherButtonTitles
              popoverPresentationControllerBlock:nil
                                        tapBlock:tapBlock];
}

+ (nullable instancetype)showActionSheetInViewController:(UIViewController *)viewController
                                      withTitle:(NSString *)title
                                        message:(NSString *)message
                                       onlyOnce:(bool) onlyOnce
                              cancelButtonTitle:(NSString *)cancelButtonTitle
                         destructiveButtonTitle:(NSString *)destructiveButtonTitle
                              otherButtonTitles:(NSArray *)otherButtonTitles
             popoverPresentationControllerBlock:(void(^)(UIPopoverPresentationController *popover))popoverPresentationControllerBlock
                                       tapBlock:(UIAlertControllerCompletionBlock)tapBlock
{
    return [self showInViewController:viewController
                            withTitle:title
                              message:message
                             onlyOnce:onlyOnce
                       preferredStyle:UIAlertControllerStyleActionSheet
                    cancelButtonTitle:cancelButtonTitle
               destructiveButtonTitle:destructiveButtonTitle
                    otherButtonTitles:otherButtonTitles
            popoverPresentationControllerBlock:popoverPresentationControllerBlock
                             tapBlock:tapBlock];
}

#pragma mark -

- (BOOL)visible
{
    return self.view.superview != nil;
}

- (NSInteger)cancelButtonIndex
{
    return UIAlertControllerBlocksCancelButtonIndex;
}

- (NSInteger)firstOtherButtonIndex
{
    return UIAlertControllerBlocksFirstOtherButtonIndex;
}

- (NSInteger)destructiveButtonIndex
{
    return UIAlertControllerBlocksDestructiveButtonIndex;
}

@end
