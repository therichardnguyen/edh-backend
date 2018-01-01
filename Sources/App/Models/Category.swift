import Vapor
import FluentProvider
import HTTP

final class Category: Model {

  let storage = Storage()

  var name: String

  struct Keys {
    static let id = "id"
    static let name = "name"
  }

  init(name: String) {
    self.name = name
  }

  init(row: Row) throws {
    name = try row.get(Category.Keys.name)
  }

  func makeRow() throws -> Row {
    var row = Row()
    try row.set(Category.Keys.name, name)
    return row
  }

}

// MARK: Fluent Preparation

extension Category: Preparation {
  /// Prepares a table/collection in the database
  static func prepare(_ database: Database) throws {
    try database.create(self) { builder in
      builder.id()
      builder.string(Category.Keys.name)
    }
  }

  /// Undoes what was done in `prepare`
  static func revert(_ database: Database) throws {
    try database.delete(self)
  }

}

// MARK: JSON

extension Category: JSONConvertible {
  convenience init(json: JSON) throws {
    self.init(
      name: try json.get(Category.Keys.name)
      )
  }

  func makeJSON() throws -> JSON {
    var json = JSON()
    try json.set(Category.Keys.id, id)
    try json.set(Category.Keys.name, name)
    return json
  }
}

// MARK: HTTP

extension Category: ResponseRepresentable { }

// MARK: Update

extension Category: Updateable {

  public static var updateableKeys: [UpdateableKey<Category>] {
    return [
    // If the request contains a String at key "content"
    // the setter callback will be called.
    UpdateableKey(Category.Keys.name, String.self) { category, name in
      category.name = name
    }
    ]
  }
}

