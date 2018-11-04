//
//  Evaluator.swift
//  Logic
//
//  Created by Zackory Cramer on 11/3/18.
//  Copyright © 2018 Zackori Cui. All rights reserved.
//

import Foundation

class Evaluator {
	
	private let _facts = Facts()
	private let _premises = SetStack<Premise>()
	private let _premiseGraph = TreeGraph<Premise>()
	private let _premiseDirection = PremiseTable()
	
	private var _poppedPremise: Premise?
	private var _shouldEvalute: Bool = false
	
	func addFact(_ premise: Premise, _ result: Result) {
		if !_facts.addEvaluatedPremise(premise, result) {
			print("Premise already in factionary. ", premise, result)
		}
	}
	
	@discardableResult
	func addPremise(_ premise: Premise) -> Bool {
		guard _premiseGraph.addElementWithoutParent(premise) else {
			print("Premise is a duplicate in graph: ", premise)
			return true
		}
		guard _premises.stack(premise) else {
			print("Premise is a duplicate in stack: ", premise)
			return true
		}
		return false
	}
	
	func evaluateAll() {
		_shouldEvalute = true
		while _shouldEvalute, let poppedPremise = _premises.pop() {
			_poppedPremise = poppedPremise
			if let r = evaluateOnFacts(poppedPremise) {
				if !_facts.addEvaluatedPremise(poppedPremise, r) {
					declareContradtion(on: poppedPremise, with: r)
				}
				continue
			}
			print("Premise not derivable on facts, attempt to expand: ", poppedPremise)
			if let derivePremises = QueryExander.getDerivedPremises(poppedPremise, _facts) {
				stackDerivedPremises(derivePremises)
				continue
			}
			print("no derivable premises, ", poppedPremise, " is unevaluatable.")
			_shouldEvalute = false
		}
	}
	
	func printFacts() {
		_facts.printFacts()
	}
	
	func printPremises() {
		print("Premises =====")
		_premises.printStack()
	}
	
	func evaluateOnFacts(_ premise: Premise) -> Result? {
		if let res = _facts.resultForPremise(premise) {
			return res
		}
		if let query = premise.getQuery() {
			switch query {
			case let .And(p1, p2):
				let (b1, b2) = (_facts.resultForPremise(p1), _facts.resultForPremise(p2))
				guard b1 != nil && b2 != nil else {
					return nil
				}
				return b1! & b2!
			case let .Or(p1, p2):
				if let b1 = _facts.resultForPremise(p1), b1.getBool() == true {
					return b1
				}
				if let b2 = _facts.resultForPremise(p2), b2.getBool() == true {
					return b2
				}
				return nil
			case let .Not(p):
				return _facts.resultForPremise(p)?.getOppositeClone()
			case .IsTrue:
				if let cond = _premiseGraph.getParents(premise)?.first, let res = _facts.resultForPremise(cond) {
					return res
				}
			default:
				return nil
			}
		}
		//print("not query this is bad! Again!")
		return nil
	}
	
	/**
	* Recognize the contradtion.
	*/
	private func declareContradtion(on premise: Premise, with result: Result) {
		print("Detected contradting query: ", premise, ", with result: ", result.description)
		_shouldEvalute = false
	}
	
	/**
	* Recognize the contradtion.
	*/
	private func declareSelfEvaluation(on premise: Premise) {
		print("Detected self evaluating premise: ", premise)
		_shouldEvalute = false
	}
	
	/**
	* Stack the popped Query on top of the stack.
	* Only call this when you made sure the query
	* to add is unevaluated.
	*/
	private func stackDerivedPremises(_ permises: [Premise], discardPopped: Bool = false) {
		guard _premises.stack(_poppedPremise!) else {
			print("Somehow returne true for popped premise: ", _poppedPremise!)
			return
		}
		for premise in permises {
			guard _premises.stack(premise) else {
				declareSelfEvaluation(on: premise)
				return
			}
			_premiseGraph.addElementWithParent(_poppedPremise!, premise)
		}
	}
}
