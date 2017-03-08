
class LinkedList<T> {
    let next: LinkedList?
    let value: T

    init(next: LinkedList?, value: T) {
        self.next = next
        self.value = value
    }

    init?(array: [T]) {
		let reversed = Array(array.reversed())
        guard let first = array.first else {
            return nil
        }
		
		var tailLinkedList: LinkedList? = nil
		
		for i in 0 ..< reversed.count - 1 {
			tailLinkedList = LinkedList(next: tailLinkedList, value: reversed[i])
		}
		
		self.next = tailLinkedList
		self.value = first
    }
	
	func array() -> Array<T> {
		if let next = next {
			return [value] + next.array()
		}
		return [value]
	}
}

class DoublyLinkedList<T> {
    let next: DoublyLinkedList?
    private(set) var previous: DoublyLinkedList? = nil
    var head: DoublyLinkedList {
        guard let previous = previous else {
            return self
        }
        return previous.head
    }

    var value: T
	
	init(next: DoublyLinkedList?, value: T) {
		self.value = value
		self.next = next
		self.next?.previous = self
	}
	
	
	init?(array: [T]) {
		let reversed = Array(array.reversed())
		guard let first = array.first else {
			return nil
		}
		
		var tailDoublyLinkedList: DoublyLinkedList? = nil
		
		for i in 0 ..< reversed.count - 1 {
			let nextTail = DoublyLinkedList(next: tailDoublyLinkedList, value: reversed[i])
			tailDoublyLinkedList?.previous = nextTail
			tailDoublyLinkedList = nextTail
		}
		
		self.value = first
		self.next = tailDoublyLinkedList
		self.next?.previous = self
	}

    convenience init?(linkedList: LinkedList<T>?) {
		guard let linkedList = linkedList else {
			return nil
		}
		self.init(array: linkedList.array())
    }

    func array() -> Array<T> {
        if let next = next {
            return [value] + next.array()
        }
        return [value]
    }
}
