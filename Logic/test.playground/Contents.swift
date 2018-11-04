import Foundation

class o: NSObject {
	var i: Int
	init(_ i: Int) {
		self.i = i
	}
}

var set = Set<o>()
set.insert(o(1))
set.insert(o(2))
set.insert(o(3))
set.insert(o(4))
set.insert(o(5))

var dict = Dictionary<Int, Double>()
class ForrestNode<T>: NSObject {
	
	private var _left, _right: ForrestNode?
	private var _element: T
	
	func getElement() -> T {
		return _element
	}
	
	init(_ t: T) {
		_element = t
	}
	
	init(_ t: T, _ left: ForrestNode<T>?, _ right: ForrestNode<T>?) {
		_element = t
		_left = left
		_right = right
	}
}
//let oo = []
print(malloc_size(Unmanaged.passRetained(ForrestNode<o>(o(0))).toOpaque()))
