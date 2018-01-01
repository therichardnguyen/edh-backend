import Vapor

extension Droplet {
    func setupRoutes() throws {
        get("info") { req in
            return req.description
        }

        get("description") { req in return req.description }

        try resource("categories", CategoryController.self)
    }
}
