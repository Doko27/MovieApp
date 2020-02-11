//
//  DAOMovieDetailsProductionCompanies.swift
//
//  Created by IRFAN TRIHANDOKO on 04/12/19
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class DAOMovieDetailsProductionCompanies: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let originCountry = "origin_country"
    static let name = "name"
    static let id = "id"
    static let logoPath = "logo_path"
  }

  // MARK: Properties
  public var originCountry: String?
  public var name: String?
  public var id: Int?
  public var logoPath: String?

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
    originCountry = json[SerializationKeys.originCountry].string
    name = json[SerializationKeys.name].string
    id = json[SerializationKeys.id].int
    logoPath = json[SerializationKeys.logoPath].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = originCountry { dictionary[SerializationKeys.originCountry] = value }
    if let value = name { dictionary[SerializationKeys.name] = value }
    if let value = id { dictionary[SerializationKeys.id] = value }
    if let value = logoPath { dictionary[SerializationKeys.logoPath] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.originCountry = aDecoder.decodeObject(forKey: SerializationKeys.originCountry) as? String
    self.name = aDecoder.decodeObject(forKey: SerializationKeys.name) as? String
    self.id = aDecoder.decodeObject(forKey: SerializationKeys.id) as? Int
    self.logoPath = aDecoder.decodeObject(forKey: SerializationKeys.logoPath) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(originCountry, forKey: SerializationKeys.originCountry)
    aCoder.encode(name, forKey: SerializationKeys.name)
    aCoder.encode(id, forKey: SerializationKeys.id)
    aCoder.encode(logoPath, forKey: SerializationKeys.logoPath)
  }

}
