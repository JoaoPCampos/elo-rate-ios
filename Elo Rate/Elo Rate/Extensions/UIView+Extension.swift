//
//  UIView+Extension.swift
//  Elo Rate
//
//  Created by João Campos on 14/05/2019.
//  Copyright © 2019 João Campos. All rights reserved.
//

import LayoutKit

extension UIView {
    
    func add(_ views: UIView...) {
        
        views.forEach {
            
            self.addSubview($0)
        }
    }
}

// MARK: - Animations
extension UIView {

    func hide() {

        self.isHidden = true
    }
    
    @discardableResult
    func popIn(fromScale: CGFloat = 0.5,
               duration: TimeInterval = 0.5,
               delay: TimeInterval = 0,
               completion: ((Bool) -> Void)? = nil) -> UIView {

        self.alpha = 0
        self.isHidden = false
        self.transform = CGAffineTransform(scaleX: fromScale, y: fromScale)

        let animations = {

            self.transform = .identity
            self.alpha = 1
        }

        UIView.animate(withDuration: duration,
                       delay: delay,
                       usingSpringWithDamping: 0.55,
                       initialSpringVelocity: 3,
                       options: .curveEaseOut,
                       animations: animations,
                       completion: completion)

        return self
    }
    
    @discardableResult
    func popOut(toScale: CGFloat = 0.5,
                duration: TimeInterval = 0.3,
                delay: TimeInterval = 0,
                completion: ((Bool) -> Void)? = nil) -> UIView {

        let endTransform = CGAffineTransform(scaleX: toScale, y: toScale)
        let prepareTransform = CGAffineTransform(scaleX: 1.1, y: 1.1)

        let animations = {

            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.2) {

                self.transform = prepareTransform
            }

            UIView.addKeyframe(withRelativeStartTime: 0.2, relativeDuration: 0.3) {

                self.transform = prepareTransform
            }

            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5) {

                self.alpha = 0
                self.transform = endTransform
            }
        }

        UIView.animateKeyframes(withDuration: duration,
                                delay: delay,
                                options: .calculationModeCubic,
                                animations: animations,
                                completion: completion)

        return self
    }
    
    @discardableResult
    func hop(toward edge: LayoutKitAttribute? = nil,
             amount: CGFloat = 0.4,
             duration: TimeInterval = 0.6,
             delay: TimeInterval = 0,
             completion: ((Bool) -> Void)? = nil) -> UIView {
        
        var dx: CGFloat = 0, dy: CGFloat = 0, ds: CGFloat = 0
        
        if edge == .none {
            
            ds = amount / 2
        
        } else if edge == .leading || edge == .trailing {
            
            dx = (edge == .leading ? -1 : 1) * self.bounds.size.width * amount;
            dy = 0
        
        } else {
            
            dx = 0
            dy = (edge == .top ? -1 : 1) * self.bounds.size.height * amount;
        }

        let animations = {

            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.28) {

                let t = CGAffineTransform(translationX: dx, y: dy)
                self.transform = t.scaledBy(x: 1 + ds, y: 1 + ds)
            }

            UIView.addKeyframe(withRelativeStartTime: 0.28, relativeDuration: 0.28) {

                self.transform = .identity
            }

            UIView.addKeyframe(withRelativeStartTime: 0.56, relativeDuration: 0.28) {

                let t = CGAffineTransform(translationX: dx * 0.5, y: dy * 0.5)
                self.transform = t.scaledBy(x: 1 + ds * 0.5, y: 1 + ds * 0.5)
            }

            UIView.addKeyframe(withRelativeStartTime: 0.84, relativeDuration: 0.16) {

                self.transform = .identity
            }
        }
        
        UIView.animateKeyframes(withDuration: duration,
                                delay: delay,
                                options: .calculationModeLinear,
                                animations: animations,
                                completion: completion)
        
        return self
    }
    
    @discardableResult
    func shake(toward edge: LayoutKitAttribute? = nil,
               amount: CGFloat = 0.15,
               duration: TimeInterval = 0.6,
               delay: TimeInterval = 0,
               completion: ((Bool) -> Void)? = nil) -> UIView {
        
        let steps = 8
        let timeStep = 1.0 / Double(steps)
        var dx: CGFloat, dy: CGFloat
        
        if edge == .leading || edge == .trailing {
            
            dx = (edge == .leading ? -1 : 1) * self.bounds.size.width * amount;
            dy = 0
            
        } else {
            
            dx = 0
            dy = (edge == .top ? -1 : 1) * self.bounds.size.height * amount;
        }

        let animations = {

            var start = 0.0

            for i in 0..<(steps - 1) {

                UIView.addKeyframe(withRelativeStartTime: start, relativeDuration: timeStep) {

                    self.transform = CGAffineTransform(translationX: dx, y: dy)
                }

                if (edge == .none && i % 2 == 0) {

                    swap(&dx, &dy)  // Change direction
                    dy *= -1
                }

                dx *= -0.85
                dy *= -0.85

                start += timeStep
            }

            UIView.addKeyframe(withRelativeStartTime: start, relativeDuration: timeStep) {

                self.transform = .identity
            }
        }
        
        UIView.animateKeyframes(withDuration: duration,
                                delay: delay,
                                options: .calculationModeCubic,
                                animations: animations,
                                completion: completion)
        
        return self
    }
}

private extension UIView {
    
    private func offsetFor(edge: LayoutKitAttribute?) -> CGPoint {
        
        guard let edge = edge else { return .zero }
        
        if let parentSize = self.superview?.frame.size {
            
            switch edge {
            
            case .top:
                return CGPoint(x: 0, y: -frame.maxY)
            
            case .bottom:
                return CGPoint(x: 0, y: parentSize.height - frame.minY)
            
            case .leading:
                return CGPoint(x: -frame.maxX, y: 0)
            
            case .trailing:
                return CGPoint(x: parentSize.width - frame.minX, y: 0)
            }
        }
        
        return .zero
    }
}
