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

class Result: NSObject {
	
	private var _bool, _null: Bool
	private var _grade: Int8
	
	func getBool() -> Bool? {
		return _null ? nil : _bool
	}
	
	func getGrade() -> Int8 {
		return _grade
	}
	
	func getOppositeClone() -> Result {
		return Result(!_bool, _grade)
	}
	
	func matches(_ result: Result) -> Bool{
		return self._bool == result._bool && self._grade == result._grade && self._null == result._null
	}
	
	init(_ bool: Bool, _ grade: Int8) {
		_bool = bool
		_grade = grade
		_null = true
	}
}
//struct Result: Hashable, CustomStringConvertible {
//	var description: String {
//		return !empty ? "\(bool ? "true" : "false") g: \(grade)" : ""
//	}
//	var bool: Bool
//	var grade: Int8
//	var empty: Bool
//
//	init(bool: Bool, grade: Int8) {
//		self.bool = bool
//		self.grade = grade
//		empty = false
//	}
//
//	init() {
//		self.bool = false
//		self.grade = 0
//		empty = true
//	}
//
//	func hasSameResult(_ r2: Result) -> Bool {
//		return self.bool == r2.bool
//	}
//
//	func opposite(_ r: Result) -> Result {
//		var r = r
//		r.bool = !r.bool
//		return r
//	}
//}

extension Result {
	static func &(rhs: Result, lhs: Result) -> Result {
		return Result(rhs.getBool()! && lhs.getBool()!, min(rhs.getGrade(), lhs.getGrade()))
	}
}

class Premise: NSObject {
	let _query: Query
	private var _result: Result?
	private var _valid: Bool
	weak var _prev: Premise?
	var _next: [Premise]
	
	/* Invalidate the current premise and return the next chain of
     */
	func invalidate() -> Premise? {
		_valid = true
//		let premiseStack = Stack<Premise>()
//		premiseStack.stack(_next)
//		var n = premiseStack.pop()
//		while n != nil {
//			if n!._valid || n! == self {
//				n!._result = nil
//				n!._valid = false
//				premiseStack.stack(n!._next)
//			}
//			n = premiseStack.pop()
//		}
		var p = _prev
		while p != nil && p!._prev != self {
			p!._valid = false
			p = p!._prev
		}
		return p
	}
	
	func hasEvaluated() -> Bool {
		return _valid && _result != nil
	}
	
	func setResult(_ result: Result) -> Premise? {
		guard let _ = result.getBool() else {
			print("invalid set result, result is null.")
			return nil
		}
		if _valid {
			_result = result
			return invalidate()
		}
		_result = result
		_valid = true
		return nil
	}
	
	func getResult() -> Result? {
		return _result
	}
	
	init(_ query: Query) {
		_query = query
		_valid = false
		_next = []
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
	
	case And(q1: Premise, q2: Premise)
	case Or(q1: Premise, q2: Premise)
	case Not(q: Premise)
	case Is(q: Premise)
	case IsTrue(n: Noun)
//	case And(p1: Predicate, p2: Predicate)
//	case Or(p1: Predicate, p2: Predicate)
//	case Not(p: Predicate)
//	case Is(query: Predicate)
}
