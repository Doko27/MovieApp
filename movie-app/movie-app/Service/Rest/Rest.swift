//
//  Rest.swift
//  contacts-app
//
//  Created by IRFAN TRIHANDOKO on 15/06/19.
//  Copyright © 2019 IRFAN TRIHANDOKO. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

public class Rest
{
    
    private static var Manager: Alamofire.SessionManager = {
        // Create the server trust policies
        let serverTrustPolicies: [String: ServerTrustPolicy] = [
            "103.99.84.22": .disableEvaluation
        ]
        
        // Create custom manager
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = Alamofire.SessionManager.defaultHTTPHeaders
        let manager = Alamofire.SessionManager(
            configuration: URLSessionConfiguration.default,
            serverTrustPolicyManager: ServerTrustPolicyManager(policies: serverTrustPolicies)
        )
        
        return manager
    }()
    
    public static func runRequest(urlRequest: URLRequest, jsonValidation : ((JSON) -> (RestError?))? = nil, callback : @escaping (RestError?, JSON?) -> ()) -> DataRequest
    {
        
        let delegate: Alamofire.SessionDelegate = Rest.Manager.delegate
        delegate.sessionDidReceiveChallenge = { session, challenge in
            var disposition: URLSession.AuthChallengeDisposition = .performDefaultHandling
            var credential: URLCredential?
            if challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust {
                disposition = URLSession.AuthChallengeDisposition.useCredential
                credential = URLCredential(trust: challenge.protectionSpace.serverTrust!)
            } else {
                if challenge.previousFailureCount > 0 {
                    disposition = .cancelAuthenticationChallenge
                } else {
                    credential = Rest.Manager.session.configuration.urlCredentialStorage?.defaultCredential(for: challenge.protectionSpace)
                    if credential != nil {
                        disposition = .useCredential
                    }
                }
            }
            return (disposition, credential)
        }
        
        let req_ = Rest.Manager.request(urlRequest).responseJSON { (response) in
            var json : JSON?
            var err : RestError?
            switch response.result {
            case .success(let value) :
                json = JSON(value)
            case .failure(let error) :
                if let nserror = error as? NSError {
                    if nserror.code == -1001
                    {
                        err = .timeout
                    } else if nserror.code == 401 {
                        err = .unauthorized
                    } else {
                        err = .serverFailure(code: nserror.code, message: nserror.localizedDescription)
                    }
                }
            }
            
            if let validator = jsonValidation, let jsonData = json, err == nil {
                if let error = validator(jsonData) {
                    err = error
                }
            }
            
            callback(err, json)
        }
        return req_
    }
}

