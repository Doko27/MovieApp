//
//  BaseViewController.swift
//  contacts-app
//
//  Created by IRFAN TRIHANDOKO on 15/06/19.
//  Copyright © 2019 IRFAN TRIHANDOKO. All rights reserved.
//

import UIKit

open class BaseViewController: UIViewController {
    
    @IBOutlet weak var errorMessageLbl: UILabel!
    @IBOutlet weak var loadingView: UIActivityIndicatorView!
    
    open func showErrorMessage(label: UILabel?, message: String?){
        label?.text = message ?? ""
        label?.isHidden = (message?.isEmpty ?? false)
    }
    
    open func showLoading(state: Bool?){
        loadingView.isHidden = !(state ?? false)
    }
}

// MARK: - Config UITest
extension BaseViewController {
    
    func configUITest(views: [UIView], idList: [String]) {
        for i in 0..<views.count {
            views[i].accessibilityIdentifier = idList[i]
        }
    }
}
