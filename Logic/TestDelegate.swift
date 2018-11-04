//
//  TestDelegate.swift
//  Logic
//
//  Created by Zackory Cramer on 11/3/18.
//  Copyright © 2018 Zackori Cui. All rights reserved.
//

import Foundation

class DummyModel: NSObject, AssertionDelegate {
	
	var map = Array(repeating: Array(repeating: 0, count: 3), count: 3)
	
	override init() {
		map[0][0] = 1
	}
	
	func isEmptySquare(_ x: Int, _ y: Int) -> Bool {
		return map[y][x] == 0
	}
	
	func hasObjectAt(_ x: Int, _ y: Int) -> Bool {
		return map[y][x] == 1
	}
	
}
