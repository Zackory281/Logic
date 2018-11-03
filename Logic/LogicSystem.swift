//
//  LogicSystem.swift
//  Logic
//
//  Created by Zackory Cramer on 11/1/18.
//  Copyright © 2018 Zackori Cui. All rights reserved.
//

import Foundation

class LogicSystem {
	
	private let _facts: Facts
	private var _predicates: [Predicate]
	private var _queries: SetStack<Query>
	
	init() {
		_predicates = []
		_facts = Facts()
		_queries = SetStack<Query>()
		_shouldEvalute = false
	}
	
	func addFact(_ query: Query, _ result: Result) {
		_facts.addEvaluatedQuery(query, result)
	}
	
	func addQuery(_ query: Query) {
		let _ = _queries.stack(query)
	}
	
	func addPredicate(_ predicate: Predicate) {
		_predicates.append(predicate)
	}
	
	var _poppedQuery: Query?
	var _shouldEvalute: Bool
	func evaluateAll() {
		//while let _poppedPredicate = _predicates.popLast()
		_shouldEvalute = true
		while _shouldEvalute, let query = _queries.pop() {
			_poppedQuery = query
			if _facts.hasEvaluatedQuery(query) {
				print("already evaluated")
				continue
			}
			switch query {
			case let .And(q1: q1, q2: q2):
				evaluateAnd(q1, q2)
				continue
			case let .Is(q: q):
				evaluateIs(q)
				continue
			case .IsTrue:
				evaluateIsTrue()
				continue
			default:
				_shouldEvalute = false
				print("unexpected Query")
				break
			}
		}
	}
	
	/**
	* Stack the popped Query on top of the stack.
	* Only call this when you made sure the query
	* to add is unevaluated.
	*/
	private func stackOnQueries(_ query: Query, discardPopped: Bool = false) {
		if !discardPopped, let popped = _poppedQuery {
			if !_queries.stack(popped) {
				print("mesteryous existing: ", popped)
			}
		}
		if !_queries.stack(query) {
			print("Self defining query \(query)")
			_shouldEvalute = false
			return
		}
	}
	
	func printFacts() {
		_facts.printFacts();
	}
	
	func printQueries() {
		//_queries.printQueries()
	}
	
}

extension LogicSystem {
	func evaluateAnd(_ q1: Query, _ q2: Query) {
		if !_facts.hasEvaluatedQuery(q1) {
			stackOnQueries(q1)
			return
		}
		if !_facts.hasEvaluatedQuery(q2) {
			stackOnQueries(q2)
			return
		}
		_facts.addEvaluatedQuery(_poppedQuery!, _facts.resultForQuery(q1)! & _facts.resultForQuery(q2)!)
	}
	
	func evaluateIs(_ q: Query) {
		if let res = _facts.resultForQuery(q) {
			_facts.addEvaluatedQuery(_poppedQuery!, res)
			return
		}
		if let expansion = QueryExander.getExandedQuery(_poppedQuery!) {
			stackOnQueries(expansion)
			return
		} else {
			_shouldEvalute = false
			print("unexpandable \(_poppedQuery!)")
		}
	}
	
	func evaluateIsTrue() {
		if let expansion = QueryExander.getExandedQuery(_poppedQuery!) {
			if let res = _facts.resultForQuery(expansion) {
				_facts.addEvaluatedQuery(_poppedQuery!, res)
				return
			}
			stackOnQueries(expansion)
			return
		} else {
			_shouldEvalute = false
			print("unexpandable \(_poppedQuery!)")
			
		}
	}
}
