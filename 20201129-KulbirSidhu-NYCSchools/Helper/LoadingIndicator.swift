//
//  LoadingIndicator.swift
//  20201129-KulbirSidhu-NYCSchools
//
//  Created by Ramandeep Singh on 11/29/20.
//  Copyright © 2020 Kulbir. All rights reserved.
//

import UIKit

class LoadingIndicator {
    static var currentOverlay : UIView?
    static func show() {
        show(UIApplication.shared.windows.filter {$0.isKeyWindow}.first ?? UIWindow())
    }
    
    static func show(_ loadingText: String) {
        show(UIApplication.shared.windows.filter {$0.isKeyWindow}.first ?? UIWindow() , loadingText: loadingText)
    }
    
    static func show(_ overlayTarget : UIView) {
        show(overlayTarget, loadingText: nil)
    }
    
    static func show(_ overlayTarget : UIView, loadingText: String?) {
        hide()
        let overlay = UIView(frame: overlayTarget.frame)
        overlay.center = overlayTarget.center
        overlay.alpha = 0
        overlay.backgroundColor = UIColor.black
        overlayTarget.addSubview(overlay)
        overlayTarget.bringSubviewToFront(overlay)
        let indicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
        indicator.color = .white
        indicator.center = overlay.center
        indicator.startAnimating()
        overlay.addSubview(indicator)
        
        if let textString = loadingText {
            let label = UILabel()
            label.text = textString
            label.textColor = UIColor.white
            label.sizeToFit()
            label.center = CGPoint(x: indicator.center.x, y: indicator.center.y + 30)
            overlay.addSubview(label)
        }
        UIView.animate(withDuration: 0.5, animations: {
            overlay.alpha = overlay.alpha > 0 ? 0 : 0.5
        } )
        currentOverlay = overlay
    }
    
    static func hide() {
        if currentOverlay != nil {
            DispatchQueue.main.async {
                currentOverlay?.removeFromSuperview()
                currentOverlay =  nil
            }
            
        }
    }
}
