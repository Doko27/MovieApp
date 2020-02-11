//
//  DAOCreditsCrew.swift
//
//  Created by IRFAN TRIHANDOKO on 04/12/19
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class DAOCreditsCrew: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let name = "name"
    static let department = "department"
    static let id = "id"
    static let job = "job"
    static let gender = "gender"
    static let creditId = "credit_id"
  }

  // MARK: Properties
  public var name: String?
  public var department: String?
  public var id: Int?
  public var job: String?
  public var gender: Int?
  public var creditId: String?

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
    name = json[SerializationKeys.name].string
    department = json[SerializationKeys.department].string
    id = json[SerializationKeys.id].int
    job = json[SerializationKeys.job].string
    gender = json[SerializationKeys.gender].int
    creditId = json[SerializationKeys.creditId].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = name { dictionary[SerializationKeys.name] = value }
    if let value = department { dictionary[SerializationKeys.department] = value }
    if let value = id { dictionary[SerializationKeys.id] = value }
    if let value = job { dictionary[SerializationKeys.job] = value }
    if let value = gender { dictionary[SerializationKeys.gender] = value }
    if let value = creditId { dictionary[SerializationKeys.creditId] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.name = aDecoder.decodeObject(forKey: SerializationKeys.name) as? String
    self.department = aDecoder.decodeObject(forKey: SerializationKeys.department) as? String
    self.id = aDecoder.decodeObject(forKey: SerializationKeys.id) as? Int
    self.job = aDecoder.decodeObject(forKey: SerializationKeys.job) as? String
    self.gender = aDecoder.decodeObject(forKey: SerializationKeys.gender) as? Int
    self.creditId = aDecoder.decodeObject(forKey: SerializationKeys.creditId) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(name, forKey: SerializationKeys.name)
    aCoder.encode(department, forKey: SerializationKeys.department)
    aCoder.encode(id, forKey: SerializationKeys.id)
    aCoder.encode(job, forKey: SerializationKeys.job)
    aCoder.encode(gender, forKey: SerializationKeys.gender)
    aCoder.encode(creditId, forKey: SerializationKeys.creditId)
  }

}
