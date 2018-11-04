//
//  DelegateTest.swift
//  Test
//
//  Created by Zackory Cramer on 11/3/18.
//  Copyright © 2018 Zackori Cui. All rights reserved.
//

import Foundation
import XCTest

class DelegateTest {
	
	func test() {
		print("hi")
		let d = DummyModel()
		let logic = LogicSystem(d)
		logic.addPremise(Premise(CustomQuery.HasObjectAt(0, 0)))
		logic.evaluateAll()
		logic.printFacts()
	}
}
