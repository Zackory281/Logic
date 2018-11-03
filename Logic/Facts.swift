//
//  Fact.swift
//  Logic
//
//  Created by Zackory Cramer on 11/1/18.
//  Copyright © 2018 Zackori Cui. All rights reserved.
//

import Foundation

class Facts: Hashable {
	
	private var _facts = Dictionary<Query, Result>()
	
	func addEvaluatedPredicate(_ predicate: Predicate, _ result: Result) {
		_facts[predicate.getQuery()] = result
	}
	
	func hasEvaluatedQuery(_ query: Query) -> Bool {
		return _facts[query] != nil
	}
	
	func resultForQuery(_ query: Query) -> Result? {
		return _facts[query]
	}
	
	func addEvaluatedQuery(_ query: Query, _ result: Result) {
		_facts[query] = result
	}
	
	func printFacts() {
		print("Facts   =====")
		for (q, r) in _facts {
			print("\(q) is \(r)")
		}
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
