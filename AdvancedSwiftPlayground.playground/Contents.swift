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


