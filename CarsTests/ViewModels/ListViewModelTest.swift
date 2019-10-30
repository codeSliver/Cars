//
//  ListViewModelTest.swift
//  CarsTests
//
//  Created by Arslan Faisal on 30/10/2019.
//  Copyright © 2019 Arslan Faisal. All rights reserved.
//

import XCTest
@testable import Cars

class ListViewModelTest: XCTestCase, MockCars {

    var listViewModel: ListViewModel!
    var testIndex = 2
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        listViewModel = ListViewModel([Car]())
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        listViewModel = nil
    }

    func testNumberOfCars() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let cars = carsFromJsonFile()
        XCTAssertNotNil(cars, "cars not found in json file")
        if let cars = cars {
            listViewModel.carsFetchedCallBack(cars)
            let viewModelCars = listViewModel.numberOfCars()
            XCTAssertEqual(viewModelCars, cars.count)
            
        }
    }
    func testMatchCarAtTestIndex() {
        let cars = carsFromJsonFile()
        XCTAssertNotNil(cars, "cars not found in json file")
        if let cars = cars {
            listViewModel.carsFetchedCallBack(cars)
            let viewModelCar = listViewModel.carAtIndex(index: testIndex)
            let car = cars[testIndex]
            XCTAssertEqual(viewModelCar?.id, car.id)
        }
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
