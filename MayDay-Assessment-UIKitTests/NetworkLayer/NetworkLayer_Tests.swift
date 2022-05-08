//
//  NetworkLayer_Tests.swift
//  MayDay-Assesment-UIKitTests
//
//  Created by Yousef Abourady on 2022-05-07.
//

import Foundation
import XCTest
@testable import MayDay_Assessment_UIKit

class NetworkLayer_Tests: XCTestCase {
    
    func testNetworkService() {
        let request = NetworkService.call(router: UserEndpoints.loadUsers(limit: 20)) { data, statusCode, error in }
        XCTAssertNotNil(request)
    }

}
