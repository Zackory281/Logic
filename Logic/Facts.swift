//
//  Fact.swift
//  Logic
//
//  Created by Zackory Cramer on 11/1/18.
//  Copyright © 2018 Zackori Cui. All rights reserved.
//

import Foundation

class Facts: Hashable {
	
	private var _facts = Dictionary<Predicate, Result>()
	
	func addEvaluatedPredicate(_ predicate: Predicate, _ result: Result) {
		_facts[predicate] = result
	}
	
	func hasEvaluatedPredicate(predicate: Predicate) -> Bool {
		return _facts[predicate] != nil
	}
	
	func resultForPredicate(_ predicate: Predicate) -> Result? {
		return _facts[predicate]
	}
	
	func hash(into hasher: inout Hasher) {
		hasher.combine(_facts)
	}
	
	init() {
		
	}
	
	static func == (lhs: Facts, rhs: Facts) -> Bool {
		return lhs._facts == rhs._facts
	}
}
