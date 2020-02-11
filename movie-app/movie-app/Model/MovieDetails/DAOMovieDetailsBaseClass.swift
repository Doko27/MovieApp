//
//  DAOMovieDetailsBaseClass.swift
//
//  Created by IRFAN TRIHANDOKO on 04/12/19
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class DAOMovieDetailsBaseClass: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let budget = "budget"
    static let backdropPath = "backdrop_path"
    static let revenue = "revenue"
    static let voteCount = "vote_count"
    static let overview = "overview"
    static let voteAverage = "vote_average"
    static let video = "video"
    static let imdbId = "imdb_id"
    static let id = "id"
    static let title = "title"
    static let homepage = "homepage"
    static let productionCompanies = "production_companies"
    static let belongsToCollection = "belongs_to_collection"
    static let posterPath = "poster_path"
    static let adult = "adult"
    static let genres = "genres"
    static let spokenLanguages = "spoken_languages"
    static let status = "status"
    static let runtime = "runtime"
    static let originalTitle = "original_title"
    static let releaseDate = "release_date"
    static let originalLanguage = "original_language"
    static let popularity = "popularity"
    static let tagline = "tagline"
    static let productionCountries = "production_countries"
  }

  // MARK: Properties
  public var budget: Int?
  public var backdropPath: String?
  public var revenue: Int?
  public var voteCount: Int?
  public var overview: String?
  public var voteAverage: Float?
  public var video: Bool? = false
  public var imdbId: String?
  public var id: Int?
  public var title: String?
  public var homepage: String?
  public var productionCompanies: [DAOMovieDetailsProductionCompanies]?
  public var belongsToCollection: DAOMovieDetailsBelongsToCollection?
  public var posterPath: String?
  public var adult: Bool? = false
  public var genres: [DAOMovieDetailsGenres]?
  public var spokenLanguages: [DAOMovieDetailsSpokenLanguages]?
  public var status: String?
  public var runtime: Int?
  public var originalTitle: String?
  public var releaseDate: String?
  public var originalLanguage: String?
  public var popularity: Float?
  public var tagline: String?
  public var productionCountries: [DAOMovieDetailsProductionCountries]?

  // MARK: SwiftyJSON Initializers
  /// Initiates the instance based on the object.
  ///
  /// - parameter object: The object of either Dictionary or Array kind that was passed.
  /// - returns: An initialized instance of the class.
  public convenience init(object: Any) {
    self.init(json: JSON(object))
  }

  /// Initiates the instance based on the JSON that was passed.
  ///
  /// - parameter json: JSON object from SwiftyJSON.
  public required init(json: JSON) {
    budget = json[SerializationKeys.budget].int
    backdropPath = json[SerializationKeys.backdropPath].string
    revenue = json[SerializationKeys.revenue].int
    voteCount = json[SerializationKeys.voteCount].int
    overview = json[SerializationKeys.overview].string
    voteAverage = json[SerializationKeys.voteAverage].float
    video = json[SerializationKeys.video].boolValue
    imdbId = json[SerializationKeys.imdbId].string
    id = json[SerializationKeys.id].int
    title = json[SerializationKeys.title].string
    homepage = json[SerializationKeys.homepage].string
    if let items = json[SerializationKeys.productionCompanies].array { productionCompanies = items.map { DAOMovieDetailsProductionCompanies(json: $0) } }
    belongsToCollection = DAOMovieDetailsBelongsToCollection(json: json[SerializationKeys.belongsToCollection])
    posterPath = json[SerializationKeys.posterPath].string
    adult = json[SerializationKeys.adult].boolValue
    if let items = json[SerializationKeys.genres].array { genres = items.map { DAOMovieDetailsGenres(json: $0) } }
    if let items = json[SerializationKeys.spokenLanguages].array { spokenLanguages = items.map { DAOMovieDetailsSpokenLanguages(json: $0) } }
    status = json[SerializationKeys.status].string
    runtime = json[SerializationKeys.runtime].int
    originalTitle = json[SerializationKeys.originalTitle].string
    releaseDate = json[SerializationKeys.releaseDate].string
    originalLanguage = json[SerializationKeys.originalLanguage].string
    popularity = json[SerializationKeys.popularity].float
    tagline = json[SerializationKeys.tagline].string
    if let items = json[SerializationKeys.productionCountries].array { productionCountries = items.map { DAOMovieDetailsProductionCountries(json: $0) } }
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = budget { dictionary[SerializationKeys.budget] = value }
    if let value = backdropPath { dictionary[SerializationKeys.backdropPath] = value }
    if let value = revenue { dictionary[SerializationKeys.revenue] = value }
    if let value = voteCount { dictionary[SerializationKeys.voteCount] = value }
    if let value = overview { dictionary[SerializationKeys.overview] = value }
    if let value = voteAverage { dictionary[SerializationKeys.voteAverage] = value }
    dictionary[SerializationKeys.video] = video
    if let value = imdbId { dictionary[SerializationKeys.imdbId] = value }
    if let value = id { dictionary[SerializationKeys.id] = value }
    if let value = title { dictionary[SerializationKeys.title] = value }
    if let value = homepage { dictionary[SerializationKeys.homepage] = value }
    if let value = productionCompanies { dictionary[SerializationKeys.productionCompanies] = value.map { $0.dictionaryRepresentation() } }
    if let value = belongsToCollection { dictionary[SerializationKeys.belongsToCollection] = value.dictionaryRepresentation() }
    if let value = posterPath { dictionary[SerializationKeys.posterPath] = value }
    dictionary[SerializationKeys.adult] = adult
    if let value = genres { dictionary[SerializationKeys.genres] = value.map { $0.dictionaryRepresentation() } }
    if let value = spokenLanguages { dictionary[SerializationKeys.spokenLanguages] = value.map { $0.dictionaryRepresentation() } }
    if let value = status { dictionary[SerializationKeys.status] = value }
    if let value = runtime { dictionary[SerializationKeys.runtime] = value }
    if let value = originalTitle { dictionary[SerializationKeys.originalTitle] = value }
    if let value = releaseDate { dictionary[SerializationKeys.releaseDate] = value }
    if let value = originalLanguage { dictionary[SerializationKeys.originalLanguage] = value }
    if let value = popularity { dictionary[SerializationKeys.popularity] = value }
    if let value = tagline { dictionary[SerializationKeys.tagline] = value }
    if let value = productionCountries { dictionary[SerializationKeys.productionCountries] = value.map { $0.dictionaryRepresentation() } }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.budget = aDecoder.decodeObject(forKey: SerializationKeys.budget) as? Int
    self.backdropPath = aDecoder.decodeObject(forKey: SerializationKeys.backdropPath) as? String
    self.revenue = aDecoder.decodeObject(forKey: SerializationKeys.revenue) as? Int
    self.voteCount = aDecoder.decodeObject(forKey: SerializationKeys.voteCount) as? Int
    self.overview = aDecoder.decodeObject(forKey: SerializationKeys.overview) as? String
    self.voteAverage = aDecoder.decodeObject(forKey: SerializationKeys.voteAverage) as? Float
    self.video = aDecoder.decodeBool(forKey: SerializationKeys.video)
    self.imdbId = aDecoder.decodeObject(forKey: SerializationKeys.imdbId) as? String
    self.id = aDecoder.decodeObject(forKey: SerializationKeys.id) as? Int
    self.title = aDecoder.decodeObject(forKey: SerializationKeys.title) as? String
    self.homepage = aDecoder.decodeObject(forKey: SerializationKeys.homepage) as? String
    self.productionCompanies = aDecoder.decodeObject(forKey: SerializationKeys.productionCompanies) as? [DAOMovieDetailsProductionCompanies]
    self.belongsToCollection = aDecoder.decodeObject(forKey: SerializationKeys.belongsToCollection) as? DAOMovieDetailsBelongsToCollection
    self.posterPath = aDecoder.decodeObject(forKey: SerializationKeys.posterPath) as? String
    self.adult = aDecoder.decodeBool(forKey: SerializationKeys.adult)
    self.genres = aDecoder.decodeObject(forKey: SerializationKeys.genres) as? [DAOMovieDetailsGenres]
    self.spokenLanguages = aDecoder.decodeObject(forKey: SerializationKeys.spokenLanguages) as? [DAOMovieDetailsSpokenLanguages]
    self.status = aDecoder.decodeObject(forKey: SerializationKeys.status) as? String
    self.runtime = aDecoder.decodeObject(forKey: SerializationKeys.runtime) as? Int
    self.originalTitle = aDecoder.decodeObject(forKey: SerializationKeys.originalTitle) as? String
    self.releaseDate = aDecoder.decodeObject(forKey: SerializationKeys.releaseDate) as? String
    self.originalLanguage = aDecoder.decodeObject(forKey: SerializationKeys.originalLanguage) as? String
    self.popularity = aDecoder.decodeObject(forKey: SerializationKeys.popularity) as? Float
    self.tagline = aDecoder.decodeObject(forKey: SerializationKeys.tagline) as? String
    self.productionCountries = aDecoder.decodeObject(forKey: SerializationKeys.productionCountries) as? [DAOMovieDetailsProductionCountries]
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(budget, forKey: SerializationKeys.budget)
    aCoder.encode(backdropPath, forKey: SerializationKeys.backdropPath)
    aCoder.encode(revenue, forKey: SerializationKeys.revenue)
    aCoder.encode(voteCount, forKey: SerializationKeys.voteCount)
    aCoder.encode(overview, forKey: SerializationKeys.overview)
    aCoder.encode(voteAverage, forKey: SerializationKeys.voteAverage)
    aCoder.encode(video, forKey: SerializationKeys.video)
    aCoder.encode(imdbId, forKey: SerializationKeys.imdbId)
    aCoder.encode(id, forKey: SerializationKeys.id)
    aCoder.encode(title, forKey: SerializationKeys.title)
    aCoder.encode(homepage, forKey: SerializationKeys.homepage)
    aCoder.encode(productionCompanies, forKey: SerializationKeys.productionCompanies)
    aCoder.encode(belongsToCollection, forKey: SerializationKeys.belongsToCollection)
    aCoder.encode(posterPath, forKey: SerializationKeys.posterPath)
    aCoder.encode(adult, forKey: SerializationKeys.adult)
    aCoder.encode(genres, forKey: SerializationKeys.genres)
    aCoder.encode(spokenLanguages, forKey: SerializationKeys.spokenLanguages)
    aCoder.encode(status, forKey: SerializationKeys.status)
    aCoder.encode(runtime, forKey: SerializationKeys.runtime)
    aCoder.encode(originalTitle, forKey: SerializationKeys.originalTitle)
    aCoder.encode(releaseDate, forKey: SerializationKeys.releaseDate)
    aCoder.encode(originalLanguage, forKey: SerializationKeys.originalLanguage)
    aCoder.encode(popularity, forKey: SerializationKeys.popularity)
    aCoder.encode(tagline, forKey: SerializationKeys.tagline)
    aCoder.encode(productionCountries, forKey: SerializationKeys.productionCountries)
  }

}
