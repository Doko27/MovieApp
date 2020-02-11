//
//  My_MovieUITests.swift
//  My MovieUITests
//
//  Created by IRFAN TRIHANDOKO on 04/12/19.
//  Copyright © 2019 IRFAN TRIHANDOKO. All rights reserved.
//

import XCTest

class My_MovieUITests: XCTestCase {
    
    
    var app: XCUIApplication!

    override func setUp() {
        // Since UI tests are more expensive to run, it's usually a good idea to exit if a failure was encountered
        continueAfterFailure = false
        
        app = XCUIApplication()
        
        // We send a command line argument to our app, to enable it to reset its state
        app.launchArguments.append("--uitesting")
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testLaunchPerformance() {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
    
    func waiting(time: Int) {
        for _ in 0..<time {
            let wait = app.waitForExistence(timeout: 60.0)
            debugPrint(wait)
        }
    }
    
    func launch() {
        app.launch()
    }
    
    func scroll(time: Int) {
        for i in 0..<time {
            if i%2 == 0 {
                app.swipeDown()
            } else {
                app.swipeUp()
            }
        }
    }
    
    func swipeCollection(time: Int, isTopDown: Bool) {
        for _ in 0..<time {
            if isTopDown == true {
                app.collectionViews.firstMatch.swipeUp()
                app.collectionViews.firstMatch.swipeDown()
            } else {
                app.collectionViews.firstMatch.swipeLeft()
                app.collectionViews.firstMatch.swipeRight()
            }
        }
    }
    
    func swipeLeftBy(time: Int) {
        for _ in 0..<time {
            app.swipeLeft()
        }
    }
    
    func swipeRightBy(time: Int) {
        for _ in 0..<time {
            app.swipeRight()
        }
    }
    
    func tap() {
        app.tap()
    }
    
    func tapButton(id: String) {
        app.buttons[id].tap()
    }
    
    func dismissAlert(title: String, button: String) {
        app.alerts[title].buttons[button].tap()
    }
    
    func returnKeyButton() {
        app.buttons["return"].tap()
    }
    
    func typeSearchList(id: String, input: String) {
        app.textFields[id].tap()
        app.textFields[id].typeText(input)
        app.textFields[id].clearAndEnterText(text: input)
        returnKeyButton()
    }
    
    func typeTextField(id: String, text: String) {
        app.textFields[id].tap()
        app.textFields[id].typeText(text)
        returnKeyButton()
    }
    
    func typeTextView(id: String, text: String) {
        app.textViews[id].tap()
        app.textViews[id].typeText(text)
        returnKeyButton()
    }
    
    func adjustingASlider(value: CGFloat) {
        app.sliders.element.adjust(toNormalizedSliderPosition: value)
    }
}
