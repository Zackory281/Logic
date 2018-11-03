//
//  Predicate.swift
//  Logic
//
//  Created by Zackory Cramer on 11/1/18.
//  Copyright © 2018 Zackori Cui. All rights reserved.
//

import Foundation

class Predicate: Hashable {
	
	let _query: Query
	let _tippingResult: Result?
	
	func getQuery() -> Query {
		return _query
	}
	
	func getTippingResult() -> Result? {
		return _tippingResult
	}
	
	init(query: Query, tippingResult: Result? = nil) {
		_query = query
		_tippingResult = tippingResult
	}
	
	static func ==(lhs: Predicate, rhs: Predicate) -> Bool {
		return lhs._query == rhs._query
	}
	
	func hash(into hasher: inout Hasher) {
		hasher.combine(_query)
	}
}
