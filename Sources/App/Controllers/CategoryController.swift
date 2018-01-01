import Vapor
import HTTP

final class CategoryController: ResourceRepresentable {

  func index(_ req: Request) throws -> ResponseRepresentable {
    return try Category.all().makeJSON()
  }

  func makeResource() -> Resource<Category> {
    return Resource(index: index)
  }
}

extension CategoryController: EmptyInitializable { }
