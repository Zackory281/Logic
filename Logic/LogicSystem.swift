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
//	private var _solvedPreds: Set<Predicate>
//	private var _queryToPredMap: Dictionary<Premise, Predicate>
//	private var _predicates: SetStack<Predicate>
	private var _premises: SetStack<Premise>
	
//	func addFact(_ query: Query, _ result: Result) {
//		_facts.addEvaluatedQuery(query, result)
//	}
//
	func addPremise(_ premise: Premise) {
		let _ = _premises.stack(premise)
	}
//	func addPredicate(_ predicate: Predicate) {
//		guard _predicates.stack(predicate) else {
//			print("Inserting an already stacked predicate: ", predicate)
//			return
//		}
//		_queryToPredMap[predicate.getQuery()] = predicate
//		if predicate.isSolved() {
//			_facts.addEvaluatedQuery(predicate.getQuery(), predicate.getResult()!)
//		} else {
//			stackRequestedQuery(predicate.getQuery())
//		}
//	}
	
	var _poppedPremise: Premise?
	var _shouldEvalute: Bool
	
	func evaluateAll() {
		//while let _poppedPredicate = _predicates.popLast()
		_shouldEvalute = true
		//while _shouldEvalute, let predicate = _predicates.pop() {
			//stackRequestedQuery(predicate.getQuery())
		while _shouldEvalute, let premise = _premises.pop() {
			printFacts()
			printQueries()
			_poppedPremise = premise
			if _facts.hasEvaluatedPremise(premise) {
				print("already evaluated")
				continue
			}
			switch premise.getQuery() {
			case let .And(q1: q1, q2: q2):
				evaluateAnd(q1, q2)
				continue
			case let .Is(q: q):
				evaluateIs(q)
				continue
			case let .Not(q: q):
				evaluateNot(q)
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
		if _shouldEvalute {
			predicate.setResult(_facts.resultForQuery(predicate.getQuery())!)
			_solvedPreds.insert(predicate)
		}
		
	}
	
	func printFacts() {
		_facts.printFacts();
	}
	
	func printQueries() {
		print("Queries =====")
		//_queries.printStack()
	}
	
	func printPredicates() {
		print("Predicates =====")
//		for p in _solvedPreds {
//			print(p.description)
//		}
	}
	
	init() {
		_facts = Facts()
//		_solvedPreds = Set<Predicate>()
//		_queryToPredMap = Dictionary<Query, Predicate>()
//		_predicates = SetStack<Predicate>()
//		_queries = SetStack<Query>()
		_premises = SetStack<Premise>()
		_shouldEvalute = false
	}
	
	/**
	 * Stack the popped Query on top of the stack.
	 * Only call this when you made sure the query
	 * to add is unevaluated.
	 */
	private func stackDerivedQuery(_ quety: Query, discardPopped: Bool = false) {
		if !discardPopped, let popped = _poppedQuery {
			if !_queries.stack(popped) {
				print("mesteryous existing: ", popped)
			}
		}
		if !_queries.stack(query) {
			declareSelfEvaluate(on: query)
			return
		}
	}
	
	/**
	 * Stack the user requested query from predicate to be process.
	 */
	private func stackRequestedQuery(_ query: Query) {
		let _ = _queries.stack(query)
	}
	
	/**
	* Stack the user requested predicate to be process.
	*/
//	private func stackRequestedPredicate(_ pred: Predicate) {
//		guard pred.getResult() == nil else {
//			print("Predicate: ", pred, " already evaluated.")
//			return
//		}
//		if _predicates.stack(pred) {
//			_queryToPredMap[pred.getQuery()] = pred
//			stackRequestedQuery(pred.getQuery())
//		}
//	}
	
	/**
	 * Add the (Query, Result) pair to the facts Dictionary. Update the predicates possibly.
	 */
	private func setEvaluationForQuery(_ query: Query, _ result: Result) {
		if _facts.hasEvaluatedQuery(query) && _facts.resultForQuery(query) != result {
			declareContradtion(on: query, with: result)
		}
		_facts.addEvaluatedQuery(query, result)
	}
	
	/**
	 * Recognize the contradtion.
	 */
	private func declareContradtion(on query: Query, with result: Result) {
		print("Detected contradting query: ", query, ", with result: ", result)
		_shouldEvalute = false
	}
	
	/**
	* Recognize the self evaluation.
	*/
	private func declareSelfEvaluate(on query: Query) {
		print("Detected self evaluating query: ", query)
		_shouldEvalute = false
		print("Tracing down stack for query attached to predicates with tipping result")
		for p in _queryToPredMap.values {
			if let tip = p.getTippingResult() {
				setEvaluationForQuery(p.getQuery(), tip)
				_shouldEvalute = true
			}
		}
//		if (
//		var traceQuery: Query? = query
//		repeat {
//
//		} while (traceQuery = _queries.pop(), 1).0 != nil
	}
}

extension LogicSystem {
	private func evaluateAnd(_ q1: Query, _ q2: Query) {
		if !_facts.hasEvaluatedQuery(q1) {
			stackDerivedQuery(q1)
			return
		}
		if !_facts.hasEvaluatedQuery(q2) {
			stackDerivedQuery(q2)
			return
		}
		_facts.addEvaluatedQuery(_poppedQuery!, _facts.resultForQuery(q1)! & _facts.resultForQuery(q2)!)
	}
	
	private func evaluateIs(_ q: Query) {
		if let res = _facts.resultForQuery(q) {
			_facts.addEvaluatedQuery(_poppedQuery!, res)
			return
		}
		if let expansion = QueryExander.getExandedQuery(_poppedQuery!) {
			stackDerivedQuery(expansion)
			return
		} else {
			_shouldEvalute = false
			print("unexpandable \(_poppedQuery!)")
		}
	}
	
	private func evaluateNot(_ q: Query) {
		if let res = _facts.resultForQuery(q) {
			_facts.addEvaluatedQuery(_poppedQuery!, res.opposite(res))
			return
		}
		stackDerivedQuery(q)
	}
	
	private func evaluateIsTrue() {
		if let expansion = QueryExander.getExandedQuery(_poppedQuery!) {
			if let res = _facts.resultForQuery(expansion) {
				_facts.addEvaluatedQuery(_poppedQuery!, res)
				return
			}
			stackDerivedQuery(expansion)
			return
		} else {
			_shouldEvalute = false
			print("unexpandable \(_poppedQuery!)")
			
		}
	}
}
