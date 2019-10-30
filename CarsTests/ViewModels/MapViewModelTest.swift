//
//  MapViewModelTest.swift
//  CarsTests
//
//  Created by Arslan Faisal on 30/10/2019.
//  Copyright © 2019 Arslan Faisal. All rights reserved.
//

import XCTest
@testable import Cars
class MapViewModelTest: XCTestCase, MockCars {

    var mapViewModel: MapViewModel!
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        mapViewModel = MapViewModel([Car]())
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        mapViewModel = nil
    }

    func testAnnotationCount() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let cars = carsFromJsonFile()
        XCTAssertNotNil(cars, "cars not found in json file")
        if let cars = cars {
            mapViewModel.carsFetchedCallBack(cars)
            let annotations = mapViewModel.mapAnnotations()
            XCTAssertEqual(annotations.count, cars.count)
        }
        
    }
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
            carsFromJsonFile()
        }
    }

}
