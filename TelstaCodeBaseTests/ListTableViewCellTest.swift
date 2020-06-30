//
//  FactsTableViewCellTest.swift
//  TelistaCodeBaseTests
//
//  Created by Kameswararao on 26/06/20.
//  Copyright © 2020 VamsiKrishna. All rights reserved.
//

import XCTest

@testable import TelstaCodeBase

class ListTableViewCellTest: XCTestCase {
        let cell: DataTableViewCell = DataTableViewCell()

        func testFactsCellElements() {

            //to check if all cell elemts are available or not
            XCTAssert(cell.imageFact != nil)
            XCTAssert(cell.labelDescription != nil)
            XCTAssert(cell.labelTitle != nil)
        }
    
    func testViewControllerIsComposedOfLabel() {
          XCTAssertNotNil(self.cell.labelDescription, "Cell under test is not composed of a UILabel")
      }
}
