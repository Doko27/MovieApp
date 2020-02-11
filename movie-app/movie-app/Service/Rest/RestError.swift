//
//  RestError.swift
//  contacts-app
//
//  Created by IRFAN TRIHANDOKO on 15/06/19.
//  Copyright © 2019 IRFAN TRIHANDOKO. All rights reserved.
//

import Foundation

public enum RestError : Equatable
{
    case unknown
    case timeout
    case serverFailure(code : Int, message : String)
    case unauthorized
    
    func order() -> Int
    {
        switch self
        {
        case .unknown :
            return 1
        case .timeout :
            return 2
        case .serverFailure(let code, _) :
            return code
        case .unauthorized :
            return 3
        }
    }
}

public func ==(left: RestError, right: RestError) -> Bool
{
    return left.order() == right.order()
}
