//
//  FactsTableViewCellTest.swift
//  TelistaCodeBaseTests
//
//  Created by Kameswararao on 26/06/20.
//  Copyright © 2020 VamsiKrishna. All rights reserved.
//

import XCTest

@testable import TelistaCodeBase

class FactsTableViewCellTest: XCTestCase {
        
        override func setUp() {
            super.setUp()
            // Put setup code here. This method is called before the invocation of each test method in the class.
        }
        
        override func tearDown() {
            // Put teardown code here. This method is called after the invocation of each test method in the class.
            super.tearDown()
        }
        
        func testFactsCellElements() {

            let cell : FactsTableViewCell = FactsTableViewCell()
            //to check if all cell elemts are available or not
            XCTAssert(cell.imageFact != nil);
            XCTAssert(cell.labelDescription != nil);
            XCTAssert(cell.labelTitle != nil);
        }
        

        
    }
