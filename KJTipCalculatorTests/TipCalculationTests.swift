//
//  TipCalculationTests.swift
//  KJTipCalculator
//
//  Created by Kristopher Johnson on 6/21/14.
//  Copyright (c) 2014 Kristopher Johnson. All rights reserved.
//

import XCTest

class TipCalculationTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testTipCalculation15() {
        let calc = TipCalculation(subtotal: 100, tipPercentage: 15, numberInParty: 1)
        XCTAssertEqual(15.0, calc.tip)
        XCTAssertEqual(115.0, calc.total)
        XCTAssertEqual(115.0, calc.perPerson)
    }
    
    func testTipCalculation20() {
        let calc = TipCalculation(subtotal: 10, tipPercentage: 20, numberInParty: 1)
        XCTAssertEqual(2.0, calc.tip)
        XCTAssertEqual(12.0, calc.total)
        XCTAssertEqual(12.0, calc.perPerson)
    }
    
    func testTipCalculationSplit() {
        let calc = TipCalculation(subtotal: 100, tipPercentage: 18, numberInParty: 2)
        XCTAssertEqual(18.0, calc.tip)
        XCTAssertEqual(118.0, calc.total)
        XCTAssertEqual(59.0, calc.perPerson)
    }
    
}
