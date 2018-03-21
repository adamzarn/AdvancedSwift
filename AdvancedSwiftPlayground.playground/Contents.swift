//: A UIKit based Playground for presenting user interface
  
import UIKit

//************************
//Advanced Swift Chapter 3
//************************

//Custom Sequence
//define how to get next element
struct PrefixIterator: IteratorProtocol {
    let string: String
    var offset: String.Index
    init(string: String) {
        self.string = string
        offset = string.startIndex
    }
    mutating func next() -> Substring? {
        guard offset < string.endIndex else { return nil }
        offset = string.index(after: offset)
        return string[..<offset]
    }
    
}
//make a sequence that conforms to the iterator
struct PrefixSequence: Sequence {
    let string: String
    func makeIterator() -> PrefixIterator {
        return PrefixIterator(string: string)
    }
}

for prefix in PrefixSequence(string: "Hello") {
    prefix //H, He, Hel, Hell, Hello
}

//print(PrefixSequence(string: "Hello").map { $0.uppercased() }) ["H", "HE", "HEL", "HELL", "HELLO"]

struct FibonacciIterator: IteratorProtocol {
    var state: (Int, Int)
    init() {
        self.state = (0,1)
    }
    mutating func next() -> Int? {
        let upcomingNumber = state.0
        state = (state.1, state.0 + state.1)
        return upcomingNumber
    }
}

struct FibonacciSequence: Sequence {
    func makeIterator() -> FibonacciIterator {
        return FibonacciIterator()
    }
}

//Subsequences
let fibs = FibonacciSequence().prefix(10)
for i in fibs.prefix(5) { i } //0,1,1,2,3
for i in fibs.suffix(5) { i } //5,8,13,21,34
for i in fibs.dropFirst(9) { i } //34
for i in fibs.dropLast(9) { i } //0
for i in fibs.split(separator: 5) { i } //[[0,1,1,2,3],[8,13,21,34]]

//Singly Linked List (example of custom sequence)
enum List<Element> {
    case end
    indirect case node(Element, next: List<Element>) //Reference Type
}

let emptyList = List<Int>.end
let oneElementList = List.node(1, next: emptyList)

extension List {
    func cons(_ x: Element) -> List {
        return .node(x, next: self)
    }
}
let list = List<Int>.end.cons(1).cons(2).cons(3)

extension List: ExpressibleByArrayLiteral {
    init(arrayLiteral elements: Element...) {
        self = elements.reversed().reduce(.end) { partialList, element in
            partialList.cons(element)
        }
    }
}
let list2: List = [3,2,1]

//Queue (example of custom collection)
protocol Queue {
    associatedtype Element
    mutating func enqueue(_ newElement: Element)
    mutating func dequeue() -> Element?
}

struct FIFOQueue<Element>: Queue {
    private var left: [Element] = []
    private var right: [Element] = []
    /// Add an element to the back of the queue.
    mutating func enqueue(_ newElement: Element) {
        right.append(newElement)
    }
    /// Removes front of the queue.
    /// Returns `nil` in case of an empty queue.
    /// Complexity: Amortized O(1).
    mutating func dequeue() -> Element? {
        if left.isEmpty {
            left = right.reversed()
            right.removeAll()
        }
        return left.popLast()
    }
}

var line = FIFOQueue<Int>()
line.enqueue(1)
line.enqueue(2)

//Queue: Collection Conformance
extension FIFOQueue: Collection {
    public var startIndex: Int { return 0 }
    public var endIndex: Int { return left.count + right.count }
    public func index(after i: Int) -> Int {
        precondition(i < endIndex)
        return i + 1
    }
    public subscript(position: Int) -> Element {
        precondition((0..<endIndex).contains(position), "Index out of bounds")
        if position < left.endIndex {
            return left[left.count - position - 1]
        } else {
            return right[position - left.count]
        }
    }
}

line.count

//Queue: ExpressibleByArrayLiteral Conformance
extension FIFOQueue: ExpressibleByArrayLiteral {
    public init(arrayLiteral elements: Element...) {
        left = elements.reversed()
        right = []
    }
}

var queueFromArray: FIFOQueue<String> = ["Mercury", "Venus", "Earth", "Mars"]
queueFromArray.dequeue()
queueFromArray.count


