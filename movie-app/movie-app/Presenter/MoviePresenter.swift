//
//  File.swift
//  movie-app
//
//  Created by IRFAN TRIHANDOKO on 03/12/19.
//  Copyright © 2019 IRFAN TRIHANDOKO. All rights reserved.
//

import Foundation

public protocol MovieRequest: BaseRequest {
    func doGetMovies(type: String, page: Int)
    func doGetMovieDetails(id: Int)
    func doGetMovieCredits(id: Int)
}


public protocol MovieResponse: BaseResponse {
    func displayMovies(result: PopularModel)
    func displayMovieDetails(result: MovieDetailsModel)
    func displayMovieCredits(result: [MovieCreditsModel])
}

extension MovieResponse {
    func displayMovies(result: PopularModel){}
    func displayMovieDetails(result: MovieDetailsModel){}
    func displayMovieCredits(result: [MovieCreditsModel]){}
}

public struct MoviePresenter: MovieRequest {
    weak var output: MovieResponse?

    public func doGetMovies(type: String, page: Int) {
        MovieWorker.getMovie(type: type, page: page, onSuccess: { (result) in
            var data: PopularModel = PopularModel(totalPage: result.totalPages ?? 0, list: [])
            for dt in result.results ?? [] {
                data.list?.append(PopularItemModel(id: dt.id ?? 0, backdropPath: dt.backdropPath ?? "", posterPath: dt.posterPath ?? "", averageRating: Double(dt.voteAverage ?? 0.0), title: dt.title ?? "", overview: dt.overview ?? ""))
            }
            self.output?.displayMovies(result: data)
        }) { (error) in
            self.output?.displayError(message: error, object: "")
        }
    }
    
    public func doGetMovieDetails(id: Int) {
        MovieWorker.getMovieDetails(id: id, onSuccess: { (result) in
            let language = result.spokenLanguages?.first?.name ?? ""
            var data: MovieDetailsModel = MovieDetailsModel(title: result.title ?? "", posterPath: result.posterPath ?? "", backdropPath: result.backdropPath ?? "", runtime: result.runtime ?? 0, releaseDate: result.releaseDate ?? "", languages: language, genres: [], rating: Double(result.voteAverage ?? 0.0), score: Double(result.voteCount ?? 0), overview: result.overview ?? "")
            for gr in result.genres ?? [] {
                data.genres?.append(gr.name ?? "")
            }
            self.output?.displayMovieDetails(result: data)
        }) { (error) in
            self.output?.displayError(message: error, object: "")
        }
    }
    
    public func doGetMovieCredits(id: Int) {
        MovieWorker.getMovieCredist(id: id, onSuccess: { (result) in
            var data: [MovieCreditsModel] = []
            for dt in result.cast ?? [] {
                data.append(MovieCreditsModel(name: dt.name ?? "", imagePath: dt.profilePath ?? "", role: dt.character ?? ""))
            }
            self.output?.displayMovieCredits(result: data)
        }) { (error) in
            self.output?.displayError(message: error, object: "")
        }
    }
}
