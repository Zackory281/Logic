//
//  Predicate.swift
//  Logic
//
//  Created by Zackory Cramer on 11/1/18.
//  Copyright © 2018 Zackori Cui. All rights reserved.
//

import Foundation

class Predicate: Hashable {
	
	let _noun: Noun
	let _condition: Condition
	
	init(noun: Noun, condition: Condition) {
		_noun = noun
		_condition = condition
	}
	
	static func == (lhs: Predicate, rhs: Predicate) -> Bool {
		return lhs._condition == rhs._condition &&
		lhs._noun == rhs._noun
	}
	
	func hash(into hasher: inout Hasher) {
		hasher.combine(_noun)
		hasher.combine(_condition)
	}
}
