//
//  Fact.swift
//  Logic
//
//  Created by Zackory Cramer on 11/1/18.
//  Copyright © 2018 Zackori Cui. All rights reserved.
//

import Foundation

class Fact: Hashable {
	
	private let _predicate: Predicate
	private let _result: Result
	
	init(predicate: Predicate, result: Result) {
		_predicate = predicate
		_result = result
	}
	
	func getPredicate() -> Predicate {
		return _predicate
	}
	
	func getResult() -> Result {
		return _result
	}
	
	func hasSamePredicate(predicate: Predicate) -> Bool {
		return _predicate == predicate
	}
	
	static func == (lhs: Fact, rhs: Fact) -> Bool {
		return lhs._predicate == rhs._predicate &&
		lhs._result == rhs._result
	}
	
	func hash(into hasher: inout Hasher) {
		hasher.combine(_predicate)
		hasher.combine(_result)
	}
}
