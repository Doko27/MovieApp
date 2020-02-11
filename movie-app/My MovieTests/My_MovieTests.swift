//
//  My_MovieTests.swift
//  My MovieTests
//
//  Created by IRFAN TRIHANDOKO on 04/12/19.
//  Copyright © 2019 IRFAN TRIHANDOKO. All rights reserved.
//

import XCTest
@testable import My_Movie

class My_MovieTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformance() {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
            MovieWorker.getMovie(type: "now_playing", page: 1, onSuccess: { (result) in }) { (error) in }
        }
    }

}
