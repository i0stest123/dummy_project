//
//  ViewControllerUtils.swift
//
//
//  Created by Waseem Wangde on 2/5/18.
//  Copyright © 2020 Inovant Solutions Pvt. Ltd. All rights reserved.
//

import Foundation
import UIKit
import NVActivityIndicatorView
import FLAnimatedImage
import Gifu

class ViewControllerUtils {
    
    var container: UIView = UIView()
    var indicaterView: UIView = UIView()
    var activityIndicator = NVActivityIndicatorView.init(frame: CGRect(x:0.0,y:0.0, width:80,height: 80), type: .ballPulse, color: PrimaryTextColor, padding: 0)
    var loadingView: GIFImageView! = GIFImageView()
    
    
    var currentGIFName: String = "bandar_Loader" {
        didSet {
            self.animate()
        }
    }
    
    func animate() {
        loadingView.animate(withGIFNamed: currentGIFName, animationBlock:  {
            
        })
    }
    
    func showActivityIndicator(uiView: UIView) {
        createView(uiView: uiView , isFullScreen: false);
    }
    func showFullScreenActivityIndicator(uiView: UIView) {
        createView(uiView: uiView , isFullScreen: true);
    }
    
    func createView(uiView: UIView, isFullScreen:Bool) {
        
     
        container.frame = CGRect(x:0, y: isFullScreen ? 0 : (ScreenHeight>=812.0) ? 88:64, width:DeviceWidth, height: isFullScreen ? ScreenHeight : ScreenHeight - ((ScreenHeight>=812.0) ? 88:64))
        container.backgroundColor = UIColor.white
        
        loadingView.frame = CGRect(x:0, y:0, width:100*DeviceMultiplier, height:100*DeviceMultiplier)
        loadingView.center = uiView.center
        loadingView.backgroundColor = .clear
        loadingView.clipsToBounds = false
        loadingView.contentMode = .scaleAspectFit
        loadingView.layer.cornerRadius = 50*DeviceMultiplier
       
        self.animate()

        var frame2: CGRect = loadingView.frame;
        frame2.origin.y = frame2.origin.y-70;
        loadingView.frame = frame2;
        
     
        container.addSubview(loadingView)
        uiView.addSubview(container)
        container.alpha = 0
        UIView.animate(withDuration: 0.2, delay: 0.0) {
            self.container.alpha = 1
        }
        
        if !UIApplication.shared.isIgnoringInteractionEvents{
            UIApplication.shared.beginIgnoringInteractionEvents()
        }
    }


    func hideActivityIndicator() {
        
        loadingView.prepareForReuse()

        UIView.animate(withDuration: 0.2, delay: 0.0) {
            self.loadingView.removeFromSuperview()
            self.container.removeFromSuperview()
        }

        if UIApplication.shared.isIgnoringInteractionEvents{
            UIApplication.shared.endIgnoringInteractionEvents()
        }

    }

    
}
