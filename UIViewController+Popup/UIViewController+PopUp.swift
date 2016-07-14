// The MIT License (MIT)
//
// Copyright (c) 2015-2016 litt1e-p ( https://github.com/litt1e-p )
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

import Foundation
import UIKit
import ObjectiveC
import VisualEffectView

public enum UIViewControllerPopUpEffectTye: String
{
    case ZoomIn, ZoomOut, FlipUp, FlipDown
}

private let kLPPUPopUpViewTag                            = 9012702
private let kLPPUPopUpBluredViewTag                      = 9012703
private let kLPPUPopUpOverlayViewTag                     = 9012701
private let kLPPURotationAngle: CGFloat                  = 70.0
private let kLPPUAnimationDuration: NSTimeInterval       = 0.4
private var kLPPUAssociatedPopupEffectKey: UInt8         = 0
private var kLPPUAssociatedPopupViewControllerKey: UInt8 = 0

public extension UIViewController
{
    public func presentPopUpViewController(viewController: UIViewController) {
        presentPopUpViewController(viewController, completion: nil)
    }
    
    public func presentPopUpViewController(viewController: UIViewController, completion: (()->Void)?) {
        enPopupViewController = viewController
        presentPopUpView(viewController.view, completion: completion)
    }
    
    public func dismissPopUpViewController() {
        dismissPopUpViewController(nil)
    }
    
    public func dismissPopUpViewController(completion: (()->Void)?) {
        let sourceView  = topView()
        let popupView   = sourceView.viewWithTag(kLPPUPopUpViewTag)
        let overlayView = sourceView.viewWithTag(kLPPUPopUpOverlayViewTag)
        let blurView    = sourceView.viewWithTag(kLPPUPopUpBluredViewTag) as! VisualEffectView
        performDismissAnimation(sourceView, blurView: blurView, popupView: popupView!, overlayView: overlayView!, completion: completion)
    }
    
    private func presentPopUpView(popUpView: UIView, completion: (()->Void)?) {
        let sourceView = topView()
        guard !sourceView.subviews.contains(popUpView) else {return}

        let overlayView                = UIView(frame: sourceView.bounds)
        overlayView.autoresizingMask   = [.FlexibleWidth, .FlexibleHeight]
        overlayView.tag                = kLPPUPopUpOverlayViewTag
        overlayView.backgroundColor    = .clearColor()

        let bluredView                 = VisualEffectView(frame: sourceView.bounds)
        bluredView.blurRadius          = 4
        bluredView.colorTint           = .blackColor()
        bluredView.autoresizingMask    = [.FlexibleWidth, .FlexibleHeight]
        bluredView.tag                 = kLPPUPopUpBluredViewTag
        sourceView.addSubview(bluredView)

        let dismissButton              = UIButton(type: .Custom)
        dismissButton.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        dismissButton.backgroundColor  = UIColor.blackColor().colorWithAlphaComponent(0.3)
        dismissButton.frame            = sourceView.bounds
        dismissButton.addTarget(self, action: #selector(self.dismissBtnEvent), forControlEvents: .TouchUpInside)
        overlayView.addSubview(dismissButton)

        popUpView.layer.cornerRadius   = 3.5
        popUpView.layer.masksToBounds  = true
        popUpView.layer.zPosition      = 99
        popUpView.tag                  = kLPPUPopUpViewTag
        popUpView.center               = overlayView.center
        popUpView.setNeedsLayout()
        popUpView.setNeedsDisplay()
        overlayView.addSubview(popUpView)
        sourceView.addSubview(overlayView)

        performAppearAnimation(bluredView, popupView: popUpView, completion: completion)
    }
    
    @objc private func dismissBtnEvent() {
        dismissPopUpViewController()
    }
    
    private func transform3d() -> CATransform3D {
        switch popUpEffectType! {
        case .FlipUp:
            var transform = CATransform3DIdentity
            transform     = CATransform3DTranslate(transform, 0.0, 200.0, 0.0)
            transform.m34 = 1.0 / 800.0
            transform     = CATransform3DRotate(transform, kLPPURotationAngle * CGFloat(M_PI) / 180.0, 1.0, 0.0, 0.0)
            let scale     = CATransform3DMakeScale(0.7, 0.7, 0.7)
            return CATransform3DConcat(transform, scale)

        case .FlipDown:
            var transform = CATransform3DIdentity
            transform     = CATransform3DTranslate(transform, 0.0, -200.0, 0.0)
            transform.m34 = 1.0 / 800.0
            transform     = CATransform3DRotate(transform, 180 + kLPPURotationAngle * CGFloat(M_PI) / 180.0, 1.0, 0.0, 0.0)
            let scale     = CATransform3DMakeScale(0.7, 0.7, 0.7)
            return CATransform3DConcat(transform, scale)
            
        case .ZoomIn:
            return CATransform3DMakeScale(0.01, 0.01, 1.00)
            
        case .ZoomOut:
            return CATransform3DMakeScale(1.50, 1.50, 1.50)
            
        }
        
    }
    
    private func performAppearAnimation(blurView: VisualEffectView, popupView: UIView, completion: (()->Void)?) {
        popupView.layer.transform = transform3d()
        let transform             = CATransform3DIdentity
        UIView.animateWithDuration(kLPPUAnimationDuration, animations: { [weak self] in
            self!.enPopupViewController?.viewWillAppear(false)
            popupView.layer.transform = transform
        }) { [weak self] (finished: Bool) in
            self!.enPopupViewController?.viewDidAppear(false)
            if let _ = completion {
                completion!()
            }
        }
    }
    
    private func performDismissAnimation(sourceView: UIView, blurView: VisualEffectView, popupView: UIView, overlayView: UIView, completion: (()->Void)?) {
        let transform = transform3d()
        UIView.animateWithDuration(kLPPUAnimationDuration, animations: { [weak self] in
            self!.enPopupViewController?.viewWillDisappear(false)
            popupView.layer.transform = transform
        }) { [weak self] (finished: Bool) in
            popupView.removeFromSuperview()
            blurView.removeFromSuperview()
            overlayView.removeFromSuperview()
            self!.enPopupViewController?.viewDidDisappear(false)
            self!.enPopupViewController = nil
            if let _ = completion {
                completion!()
            }
        }
    }
    
    private func topView() -> UIView {
        var recentViewController = self
        while (recentViewController.parentViewController != nil) {
            recentViewController = recentViewController.parentViewController!
        }
        return recentViewController.view
    }
    
    public var enPopupViewController: UIViewController? {
        get {
            return objc_getAssociatedObject(self, &kLPPUAssociatedPopupViewControllerKey) as? UIViewController
        }
        
        set(newPopupViewController) {
            objc_setAssociatedObject(self, &kLPPUAssociatedPopupViewControllerKey, newPopupViewController, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    public var popUpEffectType: UIViewControllerPopUpEffectTye? {
        get {
            if let effect = objc_getAssociatedObject(self, &kLPPUAssociatedPopupEffectKey) as? String {
                return UIViewControllerPopUpEffectTye(rawValue: effect)
            } else {
                return .ZoomIn
            }
        }
        
        set(newEffect) {
            objc_setAssociatedObject(self, &kLPPUAssociatedPopupEffectKey, newEffect!.rawValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
    }
}