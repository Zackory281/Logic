//
//  main.swift
//  Logic
//
//  Created by Zackory Cramer on 11/1/18.
//  Copyright © 2018 Zackori Cui. All rights reserved.
//

import Foundation

let p1 = Predicate(noun: .A, condition: .IsTrue)
let p2 = Predicate(noun: .B, condition: .IsTrue)

print(p1 == p2)
print("\(p1.hashValue), \(p2.hashValue)")

