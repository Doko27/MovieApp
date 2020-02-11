//
//  My_MovieUITestCase.swift
//  My MovieUITests
//
//  Created by IRFAN TRIHANDOKO on 04/12/19.
//  Copyright © 2019 IRFAN TRIHANDOKO. All rights reserved.
//

import XCTest

extension My_MovieUITests {
    
    
    func getDetail() {
        tap()
        scroll(time: 2)
        swipeCollection(time: 1, isTopDown: false)
        scroll(time: 1)
        tapButton(id: "Back")
    }
    
    func getPopular() {
        tapButton(id: "More Popular")
        scroll(time: 2)
        typeSearchList(id: "searchField", input: "Avenger")
        getDetail()
    }
    
    func testFull() {
        launch()
        swipeLeftBy(time: 7)
        swipeRightBy(time: 3)
        getDetail()
        getPopular()
    }
    
}
