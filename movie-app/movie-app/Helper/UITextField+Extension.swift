//
//  UITextField+Extension.swift
//  movie-app
//
//  Created by IRFAN TRIHANDOKO on 04/12/19.
//  Copyright © 2019 IRFAN TRIHANDOKO. All rights reserved.
//

import UIKit

public extension UITextField {
    
    func configFieldPadding(left: CGFloat, right: CGFloat) {
        let paddingLeftView = UIView(frame: CGRect(x: 0, y: 0, width: left, height: self.frame.height))
        let paddingRightView = UIView(frame: CGRect(x: 0, y: 0, width: right, height: self.frame.height))
        self.leftView = paddingLeftView
        self.leftViewMode = .always
        self.rightView = paddingRightView
        self.rightViewMode = .always
    }
}

