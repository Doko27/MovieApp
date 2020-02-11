//
//  MovieModel.swift
//  movie-app
//
//  Created by IRFAN TRIHANDOKO on 04/12/19.
//  Copyright © 2019 IRFAN TRIHANDOKO. All rights reserved.
//

import Foundation

public struct PopularModel {
    
    public var totalPage: Int?
    public var list: [PopularItemModel]?
    
}

public struct PopularItemModel {
    
    public var id: Int?
    public var backdropPath: String?
    public var posterPath: String?
    public var averageRating: Double?
    public var title: String?
    public var overview: String?
    
}
