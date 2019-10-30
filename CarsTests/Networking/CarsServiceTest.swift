//
//  CarsTests.swift
//  CarsTests
//
//  Created by Arslan Faisal on 27/10/2019.
//  Copyright © 2019 Arslan Faisal. All rights reserved.
//

import XCTest
@testable import Cars

class CarsServiceTest: XCTestCase {

    var carService: CarsService!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        carService = CarsService(NetworkHandler())
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        carService = nil
    }

    func testCarsFetch() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let carsReceivedPromise = expectation(description: "Data is received Successfully")
        carService.fetchCars { (cars, error) in
            carsReceivedPromise.fulfill()
            XCTAssertNil(error, error ?? "Recieved some error")
            XCTAssertNotNil(cars, "cars API response is nil")
            if let count = cars?.count {
                XCTAssertGreaterThan(count, 0, "Genre list is empty")
            }
        }
        wait(for: [carsReceivedPromise], timeout: 3.0)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
            testCarsFetch()
        }
    }

}
