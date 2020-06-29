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
        
       
        func testPerformanceExample() {
            // This is an example of a performance test case.
            self.measure {
                let service : FactsService = FactsService()
                service.fetchJsonObjectWithoutAlomofire()
            }
        }
        
    }
