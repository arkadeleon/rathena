//
//  rAthenaLoginTests.swift
//  rAthenaTests
//
//  Created by Leon Li on 2023/2/13.
//

import XCTest
@testable import rAthenaResource
@testable import rAthenaLogin

class rAthenaLoginTests: XCTestCase {
    let resourceManager = RAResourceManager.shared
    let loginServer = RALoginServer.shared

    override func setUp() async throws {
        try resourceManager.copyResourceFilesToLibraryDirectory()
        await loginServer.start()
    }

    func testLoginServer() {
        XCTAssertEqual(loginServer.name, "Login Server")
    }

    static var allTests = [
        ("testLoginServer", testLoginServer),
    ]
}
