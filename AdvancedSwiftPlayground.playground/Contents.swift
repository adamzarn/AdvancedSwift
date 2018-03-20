//: A UIKit based Playground for presenting user interface
  
import UIKit

//************************
//Advanced Swift Chapter 2
//************************

// The Fibonacci numbers
let fibs = [0, 1, 1, 2, 3, 5]
var mutableFibs = [0, 1, 1, 2, 3, 5]
mutableFibs.append(8)
mutableFibs.append(contentsOf: [13, 21])
mutableFibs

//Arrays are value types
var x = [1,2,3]
var y = x
y.append(4)
x

//NSArrays are reference types
let a = NSMutableArray(array: [1,2,3])
let b: NSArray = a
a.insert(4, at: 3)
b

//Correct way to copy NSArrays
let c = NSMutableArray(array: [1,2,3])
let d = c.copy() as! NSArray
c.insert(4, at: 3)
d

let array = [1,2,3]
func someMatchingLogic(element: Int) -> Bool {
    return true
}
func someTransformation(element: Int) -> Int {
    return element*2
}
func someCriteria(element: Int) -> Bool {
    return element < 2
}

//Want to iterate over the array?
for x in array {x}

//Want to iterate over all but the first element of an array?
for x in array.dropFirst() {x}

//Want to iterate over all but the last 5 elements?
for x in array.dropLast(5) {x}

//Want to number all the elements in an array?
for (num, element) in array.enumerated() { (num, element) }

//Want to find the location of a specific element?
if let idx = array.index(where: { someMatchingLogic(element: $0) }) {idx}

//Want to transform all the elements in an array?
array.map { someTransformation(element: $0) }

//Want to fetch only the elements matching a specific criterion?
array.filter { someCriteria(element: $0) }

//Write your own Higher Order Functions
let names = ["Paula", "Elena", "Zoe"]

//Without extension
var lastNameEndingInA: String?
for name in names.reversed() where name.hasSuffix("a") {
    lastNameEndingInA = name
    break
}
lastNameEndingInA

//With extension
extension Sequence {
    func last(where predicate: (Element) -> Bool) -> Element? {
        for element in reversed() where predicate(element) {
            return element
        }
        return nil
    }
}

let match = names.last { $0.hasSuffix("a") }
match

//Flatmap
let suits = ["♠︎", "♥︎", "♣︎", "♦︎"]
let ranks = ["J","Q","K","A"]
let result = suits.flatMap { suit in
    ranks.map { rank in
        (suit, rank)
    }
}

let nestedArray = [[1,2,3], [4,5,6]]
let multipliedFlattenedArray = nestedArray.flatMap { array in array.map { element in element * 2 }}
let shorthand = nestedArray.flatMap { $0.map { $0 * 2 }}
shorthand

//forEach

(1..<10).forEach { number in
    if number > 2 { return }
}

//Slices

let slice = fibs[1...]
slice // [1, 1, 2, 3, 5]
type(of: slice)
let newArray = Array(slice)
type(of: newArray)

//Dictionaries

enum Setting {
    case text(String)
    case int(Int)
    case bool(Bool)
}

let defaultSettings: [String:Setting] = [
    "Airplane Mode": .bool(false),
    "Name": .text("My iPhone"),
]

//Merge
var settings = defaultSettings
let overriddenSettings: [String:Setting] = ["Name": .text("Jane's iPhone")]
settings.merge(overriddenSettings, uniquingKeysWith: { $1 })
settings

//Sets
var naturals: Set = [1, 2, 3, 2]
naturals.contains(3)
naturals.contains(0)

//Set Operations
naturals.subtracting(Set([1]))
naturals.intersection(Set([1]))
naturals.formUnion(Set([4,5,6]))

//IndexSet and CharacterSet

var indices = IndexSet()
indices.insert(integersIn: 1..<5)
indices.insert(integersIn: 11..<15)
let evenIndices = indices.filter { $0 % 2 == 0 }
evenIndices

//Unique Elements
extension Sequence where Element: Hashable {
    func unique() -> [Element] {
        var seen: Set<Element> = []
        return filter { element in
            if seen.contains(element) {
                return false
            } else {
                seen.insert(element)
                return true
            }
        }
    }
}
[1,2,3,12,1,3,4,5,6,4,6].unique()
["jars", "of", "clay", "clay", "jars", "of", "world", "series"].unique()

//Ranges
let singleDigitNumbers = 0..<10
Array(singleDigitNumbers)
let lowercasedLetters = Character("a")...Character("z")

let fromZero = 0...
let upToZ = ..<Character("z")

singleDigitNumbers.contains(9)
lowercasedLetters.overlaps("c"..<"f")

//Substrings

extension String {
    func index(from: Int) -> Index {
        return self.index(startIndex, offsetBy: from)
    }
    func substring(with r: Range<Int>) -> String {
        let startIndex = index(from: r.lowerBound)
        let endIndex = index(from: r.upperBound)
        return String(self[startIndex..<endIndex])
    }
}



