//
//  Vocab.swift
//  Logic
//
//  Created by Zackory Cramer on 11/1/18.
//  Copyright © 2018 Zackori Cui. All rights reserved.
//

import Foundation

enum Noun: Int {
	case A = 0
	case B = 1
	case C = 2
	case D = 3
	case NULL = 4
	func next() -> Noun {
		return Noun.init(rawValue: (rawValue + 1) % Noun.NULL.rawValue)!
	}
}

struct Result: Hashable {
	var bool: Bool
	var grade: Int8
}

enum Query {
	indirect case And(op1: Query, op2: Query)
	indirect case Or(op1: Query, op2: Query)
	indirect case Not(op: Query)
	case Is(query: Predicate)
}
