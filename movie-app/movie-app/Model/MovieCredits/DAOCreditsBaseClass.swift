//
//  DAOCreditsBaseClass.swift
//
//  Created by IRFAN TRIHANDOKO on 04/12/19
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class DAOCreditsBaseClass: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let id = "id"
    static let cast = "cast"
    static let crew = "crew"
  }

  // MARK: Properties
  public var id: Int?
  public var cast: [DAOCreditsCast]?
  public var crew: [DAOCreditsCrew]?

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
    id = json[SerializationKeys.id].int
    if let items = json[SerializationKeys.cast].array { cast = items.map { DAOCreditsCast(json: $0) } }
    if let items = json[SerializationKeys.crew].array { crew = items.map { DAOCreditsCrew(json: $0) } }
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = id { dictionary[SerializationKeys.id] = value }
    if let value = cast { dictionary[SerializationKeys.cast] = value.map { $0.dictionaryRepresentation() } }
    if let value = crew { dictionary[SerializationKeys.crew] = value.map { $0.dictionaryRepresentation() } }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.id = aDecoder.decodeObject(forKey: SerializationKeys.id) as? Int
    self.cast = aDecoder.decodeObject(forKey: SerializationKeys.cast) as? [DAOCreditsCast]
    self.crew = aDecoder.decodeObject(forKey: SerializationKeys.crew) as? [DAOCreditsCrew]
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(id, forKey: SerializationKeys.id)
    aCoder.encode(cast, forKey: SerializationKeys.cast)
    aCoder.encode(crew, forKey: SerializationKeys.crew)
  }

}
