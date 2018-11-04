//
//  main.swift
//  Logic
//
//  Created by Zackory Cramer on 11/1/18.
//  Copyright © 2018 Zackori Cui. All rights reserved.
//

import Foundation

let p1 = Predicate(query: .IsTrue(.A))

let logic = LogicSystem()
let pre1 = Premise(.IsTrue(.A))
let pre2 = Premise(.IsTrue(.B))
logic.addFact(pre1, Result(true, 3))
logic.addPremise(pre2)
logic.evaluateAll()
logic.printFacts()
logic.printPredicates()



//print("\(p1.hashValue), \(p2.hashValue)")

