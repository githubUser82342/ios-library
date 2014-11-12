/*
 Copyright 2009-2014 Urban Airship Inc. All rights reserved.

 Redistribution and use in source and binary forms, with or without
 modification, are permitted provided that the following conditions are met:

 1. Redistributions of source code must retain the above copyright notice, this
 list of conditions and the following disclaimer.

 2. Redistributions in binaryform must reproduce the above copyright notice,
 this list of conditions and the following disclaimer in the documentation
 and/or other materials provided withthe distribution.

 THIS SOFTWARE IS PROVIDED BY THE URBAN AIRSHIP INC ``AS IS'' AND ANY EXPRESS OR
 IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
 MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO
 EVENT SHALL URBAN AIRSHIP INC OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT,
 INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
 BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
 DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
 LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
 OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
 ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#import "UAActivityViewController.h"

@implementation UAActivityViewController

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    if (self.dismissalBlock) {
        self.dismissalBlock();
    }
}

- (CGRect)sourceRect {
    float deviceVersion = [[UIDevice currentDevice].systemVersion floatValue];
    CGRect screenBounds = [UIScreen mainScreen].bounds;

    // iOS 7.x iPad
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad && deviceVersion >= 7.0 && deviceVersion < 8.0) {

        CGFloat width = CGRectGetWidth(screenBounds);
        CGFloat height = CGRectGetHeight(screenBounds);
        UIInterfaceOrientation interfaceOrientation = [UIApplication sharedApplication].statusBarOrientation;

        if (UIInterfaceOrientationIsPortrait(interfaceOrientation)) {
            screenBounds.size = CGSizeMake(width, height);
        } else {
            screenBounds.size = CGSizeMake(height, width);
        }

        // Return a smaller rectangle by 25% on each axis, producing a 50% smaller rectangle inset.
        return CGRectInset(screenBounds, width/4.0, height/4.0);
    }

    // Return a smaller rectangle by 25% on each axis, producing a 50% smaller rectangle inset.
    return CGRectInset(screenBounds, CGRectGetWidth(screenBounds)/4.0, CGRectGetHeight(screenBounds)/4.0);
}

// Called whenever a rotation is about to occur for iOS 8.0+ iPad
- (void)popoverPresentationController:(UIPopoverPresentationController *)popoverPresentationController
          willRepositionPopoverToRect:(inout CGRect *)rect
                               inView:(inout UIView *__autoreleasing *)view {
    // Override the passed rect with our desired dimensions
    *rect = [self sourceRect];
}

// Called whenever a rotation is about to occur for iOS 7.x iPad
- (void)popoverController:(UIPopoverController *)popoverController
willRepositionPopoverToRect:(inout CGRect *)rect
                   inView:(inout UIView *__autoreleasing *)view {
    // Override the passed rect with our desired dimensions
    *rect = [self sourceRect];
}

@end
