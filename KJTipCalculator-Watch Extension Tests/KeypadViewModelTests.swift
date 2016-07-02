//
//  KeypadViewModelTests.swift
//  KJTipCalculator
//
//  Copyright © 2016 Kristopher Johnson. All rights reserved.
//

import XCTest

/// Tests of the KeypadViewModel class.
class KeypadViewModelTests: XCTestCase {

    var keypadViewModel: KeypadViewModel!

    override func setUp() {
        super.setUp()
        keypadViewModel = KeypadViewModel()
    }

    func testInitialState() {
        XCTAssertEqual(keypadViewModel.displayText, "0")
    }
}
