//
//  BaseResponse.swift
//  contacts-app
//
//  Created by IRFAN TRIHANDOKO on 15/06/19.
//  Copyright © 2019 IRFAN TRIHANDOKO. All rights reserved.
//

import Foundation
import Alamofire

public protocol BaseResponse : class {
    func displayError(message:String, object:Any)
}
