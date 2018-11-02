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

enum Result {
	case Boolean(bool: Bool, grade: Int)
	case Number(num: Int16, grade: Int)
//	func not() -> Result {
//		switch self {
//		case let .True(g):
//			return .False(grade: g)
//		case let .False(g):
//			return .False(grade: g)
//		}
//	}
}

enum Condition: String {
	case IsTrue = "Is True"
	case IsFalse = "Is False"
}
