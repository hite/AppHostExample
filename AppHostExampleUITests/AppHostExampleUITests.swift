//
//  AppHostExampleUITests.swift
//  AppHostExampleUITests
//
//  Created by liang on 2019/4/23.
//  Copyright © 2019 liang. All rights reserved.
//

import XCTest

class AppHostExampleUITests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    func testJSBridge(){
        let app = XCUIApplication()
        
        // TODO 通过某些步骤到达 testcase 页面，开始执行。
        // 注意 testcase 页面的“关闭自动化测试的 checkbox 需要去掉勾选”
        let check = app.navigationBars.buttons["测试下一步接口"];
        check.tap()
        sleep(4);
        var next = app.alerts.element.exists
        
        var testCount = 1;
        while next {
            let isTrue = app.alerts.staticTexts["true"].exists;
            let isFalse = app.alerts.staticTexts["false"].exists;
            if (isTrue || isFalse){
                app.alerts.buttons.element.tap();
                check.tap()
                next = app.alerts.element.exists
            } else {
                let isFinish = app.alerts.staticTexts["finish"].exists
                if (isFinish){
                    app.alerts.buttons.element.tap();
                    next = false
                } else {
                    let isSwipeDown = app.alerts.staticTexts["swipeDown"].exists;
                    if (isSwipeDown) {
                        app.alerts.buttons.element.tap();
                        app.swipeDown()
                        app.swipeDown()
                        
                        sleep(4)
                        next = app.alerts.element.exists
                    } else {
                        // unknown
                        next = false
                    }
                }
            }
            
            testCount += 1
            if(testCount > 3){
                app.swipeUp()
            }
        }
        
        sleep(18);
    }
}
