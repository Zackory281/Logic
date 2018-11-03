//
//  Vocab.swift
//  Logic
//
//  Created by Zackory Cramer on 11/1/18.
//  Copyright © 2018 Zackori Cui. All rights reserved.
//

import Foundation

enum Noun: Int, CustomStringConvertible {
	var description: String { return String(UnicodeScalar(0x1F34E + self.rawValue)!)}
	case A = 0
	case B = 1
	case C = 2
	case D = 3
	case NULL = 4
	func next() -> Noun {
		return Noun.init(rawValue: (rawValue + 1) % Noun.NULL.rawValue)!
	}
}

struct Result: Hashable, CustomStringConvertible {
	var description: String {
		return "\(bool ? "true" : "false") g: \(grade)"
	}
	var bool: Bool
	var grade: Int8
	func hasSameResult(_ r2: Result) -> Bool{
		return self.bool == r2.bool
	}
}

extension Result {
	static func &(rhs: Result, lhs: Result) -> Result {
		return Result(bool: rhs.bool && lhs.bool, grade: min(rhs.grade, lhs.grade))
	}
}

enum Query: Equatable, Hashable, CustomStringConvertible {
	
	var description: String {
		switch self {
		case let .And(q1: q1, q2: q2):
			return "(\(q1) and \(q2))"
		case let .Or(q1: q1, q2):
			return "(\(q1) or \(q2))"
		case let .Not(q1):
			return "(not \(q1)"
		case let .Is(q1):
			return "(is \(q1))"
		case let .IsTrue(n):
			return "(is \(n))"
		}
	}
	
	indirect case And(q1: Query, q2: Query)
	indirect case Or(q1: Query, q2: Query)
	indirect case Not(q: Query)
	indirect case Is(q: Query)
	case IsTrue(n: Noun)
//	case And(p1: Predicate, p2: Predicate)
//	case Or(p1: Predicate, p2: Predicate)
//	case Not(p: Predicate)
//	case Is(query: Predicate)
}
