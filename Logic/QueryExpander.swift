//
//  QueryExpander.swift
//  Logic
//
//  Created by Zackory Cramer on 11/2/18.
//  Copyright © 2018 Zackori Cui. All rights reserved.
//

import Foundation

class QueryExander {
	
	static func getExandedQuery(_ premise: Premise) -> Premise? {
		switch premise.getQuery() {
		case let Query.IsTrue(n):
			return Premise(.IsTrue(n.next())) //Query.And(q1: .IsTrue(n: n.next()), q2: .IsTrue(n: n.next().next()))//
		default:
			return nil
		}
	}
	
}
