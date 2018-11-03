//
//  Predicates.swift
//  Logic
//
//  Created by Zackory Cramer on 11/2/18.
//  Copyright © 2018 Zackori Cui. All rights reserved.
//

import Foundation

class Queries {
	
	private var _querySet = Set<Query>()
	private var _queries:[Query] = []
	
	func addQuery(_ query:Query) {
		guard !existsQuery(query) else {
			print("Predicate \(query) already exists");
			return }
		_queries.append(query)
		_querySet.insert(query)
	}
	
	func deleteQuery(_ query: Query) {
		guard existsQuery(query) else { print("query doesn't exist \(query)"); return}
		_querySet.remove(query)
		//_queries.remove(at: _queries.firstIndex(of: query)!)
	}
	
	func existsQuery(_ query: Query) -> Bool {
		return _querySet.contains(query)
	}
	
	func peek() -> Query? {
		return _queries.last
	}
	
	@discardableResult
	func pop() -> Query? {
		guard let pop = _queries.popLast() else { return nil }
		return _querySet.remove(pop)!
	}
	
	func printQueries() {
		print("Queries =====")
		for q in _queries {
			print(q)
		}
	}
}

public class SetStack<T: Hashable> {
	
	private var _head: StackNode<T>
	private var _set: Set<T>
	private var _toRemove: Set<T>
	private var _size: Int
	
	func stack(_ t: T) -> Bool {
		guard !_set.contains(t) else {
			return false
		}
		clearRemoval(until: t)
		_size += 1
		_set.insert(t)
		_head = StackNode(element: t, _head)
		return true
	}
	
	func remove(_ t: T) -> Bool{
		guard _set.contains(t) else {
			return false
		}
		let b = _toRemove.insert(t).0
		print(b)
		guard b else {
			return true
		}
		_size -= 1
		_set.remove(t)
		clearRemovalFromHead()
		return true
	}
	
	func pop() -> T? {
		clearRemovalFromHead()
		guard let e = _head._next?.element() else { return nil }
		_size -= 1
		_head._next = _head._next!._next
		_set.remove(e)
		return e
	}
	
	func peek() -> T? {
		clearRemovalFromHead()
		return _head._next?.element()
	}
	
	func contains(_ t: T) -> Bool {
		return _set.contains(t)
	}
	
	func size() -> Int {
		return _size
	}
	
	/** Only call if CPU is very free. */
	func clearAllRemovals() {
		
	}
	
	init() {
		_size = 0
		_head = EmptyStackNode<T>(nil)
		_set = Set<T>()
		_toRemove = Set<T>()
	}
	
	private func clearRemoval(from: StackNode<T>) {
		var head:StackNode<T>? = from._next
		while let e = head?.element(), _toRemove.contains(e) {
			head = head?._next
			_toRemove.remove(e)
		}
	}
	
	private func clearRemovalFromHead() {
		while let e = _head._next?.element(), _toRemove.contains(e) {
			_head._next = _head._next?._next
			_toRemove.remove(e)
		}
	}
	
	private func clearRemoval(until node: T) {
//		guard _toRemove.contains(node) else { return }
//		clearRemovalFromHead()
//		guard var head = _head else { return }
		var head = _head
		while head._next != nil {
			let e = head._next!.element()
			if _toRemove.remove(e) != nil {
				head._next = head._next?._next ?? nil
				if e == node {
					return
				}
			}
			head = head._next!
		}
		repeat {
			head = head._next!
		} while head._next != nil
		print("iterated all stack but no remove element: ", node)
	}
}

class StackNode<T> {
	private var _element: T!
	var _next: StackNode<T>?
	
	func element() -> T {
		return _element
	}
	
	init(element: T!, _ next: StackNode<T>?) {
		_next = next
		_element = element
	}
}

class EmptyStackNode<T>: StackNode<T> {
	
	init(_ next: StackNode<T>?) {
		super.init(element: nil, next)
		_next = next
	}
}
