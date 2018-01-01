import XCTest
import Testing
import HTTP
import Sockets
@testable import Vapor
@testable import App

class CategoryControllerTests: TestCase {

  let controller = CategoryController()

  func testIndex() {
    do {
      let category = try Category(name: "Activity")
      try category.save()
      let request = Request.makeTest(method: .get)
      let response = try controller.index(request).makeResponse()
      let json = response.json
      XCTAssertNotNil(json?.array)
      XCTAssertEqual(json?.array?.count, 1)
    } catch {
      XCTFail()
    }
  }

}

// MARK: Manifest

extension CategoryControllerTests {
    /// This is a requirement for XCTest on Linux
    /// to function properly.
    /// See ./Tests/LinuxMain.swift for examples
    static let allTests = [
        ("testIndex", testIndex),
    ]
}
