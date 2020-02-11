//
//  NetworkMovie.swift
//  contacts-app
//
//  Created by IRFAN TRIHANDOKO on 15/06/19.
//  Copyright © 2019 IRFAN TRIHANDOKO. All rights reserved.
//

import Foundation

import Alamofire

enum NetworkMovie: URLRequestConvertible {
    
    static let APIKey = "1deaa9125142c48f15f2ddd535939ba3"
    static let baseURLString = BaseURL.GetUrl()
    case doGetMovie(type: String, page: Int)
    case doGetMovieDetails(id: Int)
    case doGetMovieCredits(id: Int)
    
    var method: HTTPMethod {
        return .get
    }
    
    var res: (path: String, param: [String: Any]) {
        switch self {
        case .doGetMovie(let type, let page):
            return ("movie/\(type)", ["api_key": NetworkMovie.APIKey, "language": "en-US", "page": page])
        case .doGetMovieDetails(let id):
            return ("movie/\(id)", ["api_key": NetworkMovie.APIKey])
        case .doGetMovieCredits(let id):
            return ("movie/\(id)/credits", ["api_key": NetworkMovie.APIKey])
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        var url: URL?
        var urlRequest: URLRequest?
        url = try NetworkMovie.baseURLString.asURL()
        urlRequest = URLRequest(url: (url?.appendingPathComponent(res.path))!)
        urlRequest?.httpMethod = method.rawValue
        if self.method == .get {
            urlRequest = try URLEncoding.default.encode(urlRequest!, with: res.param)
        } else {
            urlRequest = try JSONEncoding.default.encode(urlRequest!, with: res.param)
        }
        urlRequest?.addValue("", forHTTPHeaderField: "accesstoken")
        print("URL API => "+(urlRequest?.url?.absoluteString)!)
        print("Parameter => \(res.param)")
        return urlRequest!
    }
}

