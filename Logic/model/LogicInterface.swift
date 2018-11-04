//
//  LogicInterface.swift
//  Logic
//
//  Created by Zackory Cramer on 11/3/18.
//  Copyright © 2018 Zackori Cui. All rights reserved.
//

import Foundation

enum CustomQuery: Hashable {
	case IsEmptySquare(Int, Int)
	case WillMove(Int, Int)
	case HasObjectAt(Int, Int)
	
	var description: String {
		switch self {
		case let .IsEmptySquare(x, y):
			return "Is Empty Square at \(x), \(y)"
		case let .WillMove(x, y):
			return "Will Move at \(x), \(y)"
		case let .HasObjectAt(x, y):
			return "Has Object at \(x), \(y)"
		}
	}
}

class AssertionCurry {
	weak var _delegate: AssertionDelegate?
	func evaluateOnAssertionDelegate(_ query: CustomQuery) -> Result? {
		guard let delegate = _delegate else { return nil }
		switch query {
		case let .IsEmptySquare(x, y):
			return Result(delegate.isEmptySquare(x, y), 1)
		case let .HasObjectAt(x, y):
			return Result(delegate.hasObjectAt(x, y), 5)
		default:
			return nil
		}
	}
	init(_ delegate: AssertionDelegate?) {
		_delegate = delegate
	}
}

extension QueryExander {
	static func getDerivedCustomPremises(_ query: CustomQuery) -> Premise? {
		switch query {
		case let .WillMove(x, y):
			return Premise(.IsEmptySquare(x + 1, y))
		default:
			return nil
		}
	}
}

protocol AssertionDelegate: NSObjectProtocol {
	func isEmptySquare(_ x: Int, _ y: Int) -> Bool
	func hasObjectAt(_ x: Int, _ y: Int) -> Bool
}
