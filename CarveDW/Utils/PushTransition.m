//
//  PushTransition.m
//  CarveDW
//
//  Created by 张储祺 on 2019/6/3.
//  Copyright © 2019 icegrave0391. All rights reserved.
//

#import "PushTransition.h"

@implementation PushTransition 

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return 0.8f ;
}

//- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
//    UIViewController * fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey] ;
//    UIViewController * toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey] ;
//    CGRect finalFrameForVC = [transitionContext finalFrameForViewController:toVC] ;
//    CGRect bounds = [[UIScreen mainScreen] bounds] ;
//    toVC.view.frame = CGRectOffset(finalFrameForVC, 0, bounds.size.height) ;
//    [[transitionContext containerView] addSubview:toVC.view] ;
//    
//    [UIView animateWithDuration:[self transitionDuration:transitionContext]
//                          delay:0
//                        options:nil
//                     animations:<#^(void)animations#>
//                     completion:<#^(BOOL finished)completion#>]
//    
//}


@end
