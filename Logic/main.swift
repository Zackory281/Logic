//
//  main.swift
//  Logic
//
//  Created by Zackory Cramer on 11/1/18.
//  Copyright © 2018 Zackori Cui. All rights reserved.
//

import Foundation

let p1 = Predicate(query: .IsTrue(n: .A))

let logic = LogicSystem()
logic.addFact(.IsTrue(n: .A), Result.init(bool: true, grade: 3))
logic.addPredicate(Predicate(query: Query.IsTrue(n: .B), tippingResult: Result(bool: false, grade: -1)))
logic.evaluateAll()
logic.printQueries()
logic.printFacts()



//print("\(p1.hashValue), \(p2.hashValue)")

