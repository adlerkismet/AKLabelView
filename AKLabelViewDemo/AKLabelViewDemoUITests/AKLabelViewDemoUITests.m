//
//  AKLabelViewDemoUITests.m
//  AKLabelViewDemoUITests
//
//  Created by kismet adler on 2018/7/8.
//  Copyright © 2018年 kismet adler. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface AKLabelViewDemoUITests : XCTestCase

@end

@implementation AKLabelViewDemoUITests

- (void)setUp {
    [super setUp];
    
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    // In UI tests it is usually best to stop immediately when a failure occurs.
    self.continueAfterFailure = NO;
    // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
    [[[XCUIApplication alloc] init] launch];
    
    // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // Use recording to get started writing UI tests.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

@end
