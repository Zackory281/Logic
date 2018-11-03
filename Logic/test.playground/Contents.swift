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
print(set[set.firstIndex(of: o(4))!])
