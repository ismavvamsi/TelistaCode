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
        
        func testFactsCellElements() {

            let cell : FactsTableViewCell = FactsTableViewCell()
            //to check if all cell elemts are available or not
            XCTAssert(cell.imageFact != nil);
            XCTAssert(cell.labelDescription != nil);
            XCTAssert(cell.labelTitle != nil);
        }
        

        
    }
