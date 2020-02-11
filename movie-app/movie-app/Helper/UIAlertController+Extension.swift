//
//  UIAlertController+Extension.swift
//  contacts-app
//
//  Created by IRFAN TRIHANDOKO on 15/06/19.
//  Copyright © 2019 IRFAN TRIHANDOKO. All rights reserved.
//

import UIKit

public typealias alertAction = (UIAlertAction) -> Void

extension UIAlertController {
    public static func dialog(style: UIAlertController.Style, title: String?, message: String?, actions: [UIAlertAction], view: UIView)-> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: style)
        for action in actions {
            alert.addAction(action)
        }
        if let popoverController = alert.popoverPresentationController, style == .actionSheet {
            popoverController.sourceView = view
            popoverController.sourceRect = CGRect(x: view.bounds.midX, y: view.bounds.midY, width: 0, height: 0)
            popoverController.permittedArrowDirections = []
        }
        return alert
    }
    
    public static func dialog(style: UIAlertController.Style, title: String?, message: String?, titleBtn1: String, titleBtn2: String?, styleBtn1: UIAlertAction.Style, styleBtn2: UIAlertAction.Style, handlerBtn1: alertAction?, handlerBtn2: alertAction?)-> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: style)
        alert.addAction(UIAlertAction(title: titleBtn1, style: styleBtn1, handler: handlerBtn1))
        if let btn2 = titleBtn2, btn2 != "" {
            alert.addAction(UIAlertAction(title: btn2, style: styleBtn2, handler: handlerBtn2))
        }
        return alert
    }
    
    public static func showSimpleDialog(vc: UIViewController, title: String, message: String, button: String) {
        let alert = UIAlertController.dialog(style: .alert, title: title, message: message, titleBtn1: button, titleBtn2: nil, styleBtn1: .default, styleBtn2: .default, handlerBtn1: nil, handlerBtn2: nil)
        vc.present(alert, animated: true, completion: nil)
    }
}

