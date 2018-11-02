//
//  LogicSystem.swift
//  Logic
//
//  Created by Zackory Cramer on 11/1/18.
//  Copyright © 2018 Zackori Cui. All rights reserved.
//

import Foundation

class LogicSystem {
	
	private var _facts: Dictionary<Predicate, Result>
	private var _queries: [Predicate]
	
	init(queries: [Predicate], facts: [Predicate : Result]) {
		_queries = queries
		_facts = facts
	}
	
	func evaluateAll() {
		
	}
	
}
