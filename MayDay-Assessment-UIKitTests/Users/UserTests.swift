//
//  UserTests.swift
//  MayDay-Assesment-UIKitTests
//
//  Created by Yousef Abourady on 2022-05-07.
//

import XCTest
@testable import MayDay_Assessment_UIKit

class UserTests: XCTestCase {

    func testDecodingUser() throws{
        let usersJsonFile = Bundle.main.path(forResource: "UsersJSONTest", ofType: "json")
        
        let data = try Data(contentsOf: URL(fileURLWithPath: usersJsonFile!), options: .mappedIfSafe)
        
        let users: Result<User> = try data.decode()
        XCTAssertNotNil(users)
        XCTAssertEqual(users.results.count, 3)
        
    }
    
    // TODO: Implement more tests for users

}
