//
//  UIHelper+Extension.swift
//  movie-app
//
//  Created by IRFAN TRIHANDOKO on 04/12/19.
//  Copyright © 2019 IRFAN TRIHANDOKO. All rights reserved.
//

import UIKit

extension UIButton {
    
    func setupBorderButton() {
        self.layer.cornerRadius = 10
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.darkGray.cgColor
    }
    
}

extension UIView {
    
    func setupBorderView() {
        self.layer.cornerRadius = 20
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.darkGray.cgColor
    }
    
}
