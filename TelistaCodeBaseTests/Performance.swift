//
//  Performance.swift
//  TelistaCodeBaseTests
//
//  Created by Kameswararao on 26/06/20.
//  Copyright © 2020 VamsiKrishna. All rights reserved.
//

import XCTest

@testable import TelistaCodeBase

class Performance: XCTestCase {
            
        override func setUp() {
            super.setUp()
            continueAfterFailure = false
        }
        
// This is an example of a performance test case.
        func testPerformanceExample() {
            self.measure {
                let service : ListService = ListService()
                service.fetchJsonObjectWithoutAlomofire()
            }
        }
        
    }
