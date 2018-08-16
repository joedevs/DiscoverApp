//
//  Animator.swift
//  DiscoveryApp
//
//  Created by John Kulimushi on 16/08/2018.
//  Copyright © 2018 John Kulimushi. All rights reserved.
//

import UIKit


class Animator: NSObject,UIViewControllerAnimatedTransitioning {
    
    var isPresenting:Bool?
    var initialFrame:CGRect?
    var finalFrame:CGRect?
    let duration:TimeInterval = 1
    let options = UIViewKeyframeAnimationOptions.calculationModeCubic
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using context: UIViewControllerContextTransitioning) {
        let containerView = context.containerView
        
        //Retrieving to and from ViewController from the context
        let toViewController = context.viewController(forKey: .to)
        let fromViewController = context.viewController(forKey: .from)
        
        guard let isPresenting = self.isPresenting else {
            return
        }
        
        //Defining details and home viewController
        guard let detailsController = isPresenting
            ? toViewController as? DetailsController
            : fromViewController  as? DetailsController else { return }
        
        guard let homeController = isPresenting
            ? fromViewController as? HomeController
            : toViewController as? HomeController else { return }
        
        if isPresenting{
            prepareViews(in: detailsController)
        }else{
            prepareViews(in: homeController)
        }
        
        containerView.backgroundColor = .clear
        
        containerView.addSubview((toViewController?.view)!)
        containerView.bringSubview(toFront: detailsController.view)
        
        animateViews(in: homeController, and: detailsController, ctx: context)
    }
    
    private func animateViews(in homeController:HomeController,and detailsController:DetailsController,ctx: UIViewControllerContextTransitioning){
        
        //Making sure that isPresenting field is set
        guard let initialFrame = self.initialFrame,
            let finalFrame = self.finalFrame ,
            let isPresenting = self.isPresenting else {
                return
        }
        
        UIView.animateKeyframes(withDuration: duration, delay: 0.0, options: options, animations: {[weak self] in
            
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.33, animations: {
                //Animatable Properties
                //https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/CoreAnimation_guide/AnimatableProperties/AnimatableProperties.html
                if isPresenting{
                    self?.configureDetailsImageView(detailsController.imageView, withFrame: finalFrame, andCornerRadius: 0)
                }
                else{
                    detailsController.fullDescription.transform  = CGAffineTransform(translationX: 0, y: 100)
                    detailsController.fullDescription.alpha = 0
                    detailsController.cancelButton.transform = CGAffineTransform(translationX: 0, y: -100)
                }
                
            })
            
            UIView.addKeyframe(withRelativeStartTime: 0.33, relativeDuration: 0.33, animations: {
                detailsController.townName.alpha = isPresenting ? 1 : 0
                detailsController.townName.transform  = isPresenting ? .identity : CGAffineTransform(translationX: 0, y: 100)
            })
            //
            UIView.addKeyframe(withRelativeStartTime: 0.66, relativeDuration: 0.33, animations: {
                if isPresenting{
                    detailsController.fullDescription.alpha = 1
                    detailsController.fullDescription.transform  = .identity
                    detailsController.cancelButton.transform = .identity
                }else{
                    self?.configureDetailsImageView(detailsController.imageView, withFrame: initialFrame, andCornerRadius: 10)
                }
            })
            //
            UIView.animate(withDuration: 0.5, delay: 0.9, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.0, options: .curveEaseIn, animations: {[weak self] in
                if !isPresenting{
                    self?.resetViewPosition(in: homeController)
                    self?.toogleViewsAlpha(1, in: homeController)
                }
                }, completion: nil)
            
        }) { success in
            ctx.completeTransition(!ctx.transitionWasCancelled)
        }
    }
    
    
    func configureDetailsImageView(_ imageView:UIImageView,withFrame frame:CGRect,andCornerRadius radius:CGFloat){
        imageView.bounds = frame
        imageView.center = CGPoint(x: frame.midX, y: frame.midY)
        imageView.layer.cornerRadius = radius
    }
    
    //Resetting the animated view in the homeViewController to their respective position
    private func resetViewPosition(in homeController:HomeController){
        homeController.container.transform = .identity
        homeController.searchView.transform = .identity
        homeController.titleView.transform = .identity
        homeController.tabbarView.transform = .identity
        homeController.cellBeforeSelectedCell?.destImageView.transform = .identity
        homeController.cellAfterSelectedCell?.destImageView.transform = .identity
    }
    
    //Preparing Views to be animated in details View Controller
    private func prepareViews(in detailsController:DetailsController){
        
        guard let initialFrame = initialFrame else { return  }
        
        detailsController.imageView.bounds = initialFrame
        detailsController.imageView.center =  CGPoint(x: initialFrame.midX, y: initialFrame.midY)
        detailsController.imageView.layer.cornerRadius = 10
        detailsController.townName.alpha = 0
        detailsController.fullDescription.alpha =  0
        detailsController.townName.transform = CGAffineTransform(translationX: 0, y: 200)
        detailsController.fullDescription.transform = CGAffineTransform(translationX: 0, y: 200)
        detailsController.cancelButton.transform = CGAffineTransform(translationX: 0, y: -100)
    }
    
    //Preparing Views to be animated in home View Controller
    private func prepareViews(in homeController:HomeController){
        homeController.container.transform = CGAffineTransform(translationX: -100, y: 0)
        homeController.searchView.transform = CGAffineTransform(translationX: 0, y: -100)
        homeController.titleView.transform = CGAffineTransform(translationX: 0, y: -100)
        homeController.tabbarView.transform = CGAffineTransform(translationX: 0, y: 50)
        homeController.cellBeforeSelectedCell?.destImageView.transform = CGAffineTransform(translationX: -60, y: 0)
        homeController.cellAfterSelectedCell?.destImageView.transform = CGAffineTransform(translationX:  60, y: 0)
        toogleViewsAlpha(0, in: homeController)
    }
    
    
    //Changing view alpha from 1 to 0 or 0 to 1
    private func toogleViewsAlpha(_ alpha:CGFloat,in homeController:HomeController){
        homeController.container.alpha = alpha
        homeController.searchView.alpha = alpha
        homeController.titleView.alpha = alpha
        homeController.tabbarView.alpha = alpha
        homeController.cellBeforeSelectedCell?.alpha = alpha
        homeController.cellAfterSelectedCell?.alpha = alpha
    }
    
}





