//
//  MovieWorker.swift
//  movie-app
//
//  Created by IRFAN TRIHANDOKO on 03/12/19.
//  Copyright © 2019 IRFAN TRIHANDOKO. All rights reserved.
//

import Alamofire

public struct MovieWorker {
    
    static func getMovie(type: String, page: Int, onSuccess: @escaping (_ result: DAOMovieListBaseClass)-> Void, onFailed: @escaping onError) {
        BaseNetwork.request(request: NetworkMovie.doGetMovie(type: type, page: page), onSuccess: { (rawjson) in
            let response = DAOMovieListBaseClass(json: rawjson)
            onSuccess(response)
        }) { (error) in
            onFailed(error)
        }
    }
    
    static func getMovieDetails(id: Int, onSuccess: @escaping (_ result: DAOMovieDetailsBaseClass)-> Void, onFailed: @escaping onError) {
        BaseNetwork.request(request: NetworkMovie.doGetMovieDetails(id: id), onSuccess: { (rawjson) in
            let response = DAOMovieDetailsBaseClass(json: rawjson)
            onSuccess(response)
        }) { (error) in
            onFailed(error)
        }
    }
    
    static func getMovieCredist(id: Int, onSuccess: @escaping (_ result: DAOCreditsBaseClass)-> Void, onFailed: @escaping onError) {
        BaseNetwork.request(request: NetworkMovie.doGetMovieCredits(id: id), onSuccess: { (rawjson) in
            let response = DAOCreditsBaseClass(json: rawjson)
            onSuccess(response)
        }) { (error) in
            onFailed(error)
        }
    }
}
