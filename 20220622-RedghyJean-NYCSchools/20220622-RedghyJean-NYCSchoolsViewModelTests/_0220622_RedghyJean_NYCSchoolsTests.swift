//
//  _0220622_RedghyJean_NYCSchoolsTests.swift
//  20220622-RedghyJean-NYCSchoolsTests
//
//  Created by Redghy on 6/23/22.
//

import XCTest
@testable import _0220622_RedghyJean_NYCSchools

class _0220622_RedghyJean_NYCSchoolsTests: XCTestCase {

    class ViewModelTests: XCTestCase {
        
        private var network: ViewModelControllerProtocal?

        override func setUp() {
            super.setUp()
        // network = ViewModel(networkManager: MockNetworkManager()) 
            network?.createData(urlString: "test")
        }
        
        override func tearDown() {
            network = nil
            super.tearDown()
        }
        
        func testViewModelName() {
            XCTAssertEqual(network?.getName(0), "Clinton School")
        }
        
        func testViewModelID() {
            XCTAssertEqual(network?.getID(0), "02M260")
        }
        
        func testViewModelMathScore() {
            XCTAssertEqual(network?.getMathScore(), "404")
        }
        
        func testViewModelReadingScore() {
            XCTAssertEqual(network?.getReadingScore(), "355")
        }
        
        func testViewModelWritingScore() {
            XCTAssertEqual(network?.getWritingScore(), "363")
        }
    }


}
