//
//  UIImageView+Extension.swift
//  contacts-app
//
//  Created by IRFAN TRIHANDOKO on 15/06/19.
//  Copyright © 2019 IRFAN TRIHANDOKO. All rights reserved.
//

import UIKit

extension UIImageView {
    
    // MARK: - Start or Stop a loading view in an ImageView
    public func setLoad(isLoad: Bool, style: UIActivityIndicatorView.Style) {
        if isLoad {
            if subviews.count == 0 {
                let progress = UIActivityIndicatorView(style: style)
                progress.startAnimating()
                progress.color = UIColor.riseOrange
                self.backgroundColor = UIColor.white
                self.addSubview(progress)
                
                let xConstraint = NSLayoutConstraint(item: progress, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0)
                
                let yConstraint = NSLayoutConstraint(item: progress, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0)
                progress.translatesAutoresizingMaskIntoConstraints = false
                self.addConstraint(xConstraint)
                self.addConstraint(yConstraint)
            }
            
        } else {
            self.backgroundColor = UIColor.clear
            self.subviews.forEach{ $0.removeFromSuperview() }
        }
    }
}
