//
//  Test.swift
//  Test
//
//  Created by Zackory Cramer on 11/2/18.
//  Copyright © 2018 Zackori Cui. All rights reserved.
//

import XCTest

class Test: XCTestCase {
	
	var stack: SetStack<Int>!
	
    override func setUp() {
        super.setUp()
		stack = SetStack<Int>()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
	}
	
	func testFalse() {
		for i in 1...10 {
			XCTAssert(stack.stack(i))
			XCTAssertEqual(i, stack.size())
		}
		XCTAssertFalse(stack.remove(40))
		XCTAssert(stack.remove(1))
		XCTAssertFalse(stack.remove(1))
		
		XCTAssert(stack.stack(1))
		XCTAssertFalse(stack.stack(1))
	}
	
	func testRemoval3() {
		for i in 1...10 {
			XCTAssert(stack.stack(i))
			XCTAssertEqual(i, stack.size())
		}
		
		XCTAssert(stack.remove(2))
		XCTAssert(stack.remove(4))
		XCTAssert(stack.remove(6))
		XCTAssert(stack.remove(8))
		
		stack.clearAllRemovals()
		
		XCTAssertEqual(6, stack.size())
		XCTAssertEqual(10, stack.pop())
		
		XCTAssertEqual(5, stack.size())
		XCTAssertEqual(9, stack.pop())
		
		XCTAssertEqual(4, stack.size())
		XCTAssertEqual(7, stack.pop())
		
		XCTAssertEqual(3, stack.size())
		XCTAssertEqual(5, stack.pop())
		
		XCTAssertEqual(2, stack.size())
		XCTAssert(stack.remove(1))
		XCTAssertEqual(1, stack.size())
		
		XCTAssertEqual(3, stack.pop())
		XCTAssertEqual(0, stack.size())
	}
	
	func testRemoval2() {
		for i in 1...10 {
			XCTAssert(stack.stack(i))
			XCTAssertEqual(i, stack.size())
		}
		
		for i in stride(from: 10, to: 1, by: -1) {
			XCTAssertEqual(i, stack.pop())
			XCTAssertEqual(i - 1, stack.size())
		}
		XCTAssertEqual(1, stack.size())
		XCTAssertEqual(1, stack.pop())
		XCTAssertEqual(0, stack.size())
	}
	
	func testRemoval() {
		for i in 1...10 {
			XCTAssert(stack.stack(i))
			XCTAssertEqual(i, stack.size())
		}
		XCTAssert(stack.remove(5))
		XCTAssertEqual(9, stack.size())
		
		XCTAssertFalse(stack.remove(5))
		XCTAssertEqual(9, stack.size())
		
		XCTAssertTrue(stack.stack(5))
		XCTAssertEqual(10, stack.size())
		
		XCTAssertEqual(5, stack.pop())
		XCTAssertEqual(9, stack.size())
		
		for i in stride(from: 10, to: 5, by: -1) {
			XCTAssertEqual(i, stack.pop())
			XCTAssertEqual(i - 2, stack.size())
		}
		
		XCTAssertTrue(stack.remove(4))
		XCTAssertTrue(stack.remove(3))
		XCTAssertTrue(stack.remove(1))
		XCTAssertEqual(1, stack.size())
		XCTAssertEqual(2, stack.pop())
	}
    
    func testSimple() {
		for i in 1...10 {
			XCTAssert(stack.stack(i))
			XCTAssertEqual(i, stack.size())
		}
		for i in stride(from: 10, to: 1, by: -1) {
			XCTAssertEqual(i, stack.pop())
			XCTAssertEqual(i - 1, stack.size())
		}
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
