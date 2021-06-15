import Foundation
//import Cocoa
import XCPlayground


/*
 이번 예제의 스택 타입은 익스텐션을 통해 동작과 기능의 범위를 넓힘.
 - 스택 타입을 추가하는 법
 - 스택 타입 활용에 필요한 스위프트 내장 구조 살펴보기
 
 */

//MARK : - Stack 구조
public struct Stack<T> {
    private var elements = [T]()
    public init() {}
// element 마지막에 들어왔던 순서로 삭제
    public mutating func pop() -> T? {
        return self.elements.popLast()
    }
// element 순서대로 삽입
    public mutating func push(element: T) {
        self.elements.append(element)
    }

    public func peek() -> T? {
        return self.elements.last
    }

    public func isEmpty() -> Bool {
        return self.elements.isEmpty
    }

    public var count: Int {
        return self.elements.count
    }
}


extension Stack: CustomStringConvertible, CustomDebugStringConvertible {
    public var description: String {
        return self.elements.description
    }
    public var debugDescription: String {
        return self.elements.debugDescription
    }
}

// extension 고장
//extension Stack: ExpressibleByArrayLiteral {
//    public init(arrayLiteral elements: T...) {
//        self.init(arrayLiteral: elements)
//    }
//}

// 스택에 IterationProtocol 추가.
// 스택에 포함된 요소의 타입에 따라 값을 반환하는 반복기를 반환
public struct ArrayIterator<T> : IteratorProtocol {
    var currentElement: [T]
    init(elements: [T]) {
        self.currentElement = elements
    }
    
    mutating public func next() -> T? {
        if(!self.currentElement.isEmpty) {
            return self.currentElement.popLast()
        }
        return nil
    }
}

// 기능 고장!
//public init < S : Sequence > (_ s: S) where S.Iterator.Element == T {
//    self.elements = Array(s.reversed())
//}

extension Stack: Sequence {
    public func makeIterator() -> AnyIterator<T> {
        return AnyIterator(IndexingIterator(_elements: self.elements.lazy.reversed()))
    }
}

/*
 "익스텐션은 기존의 클래스, 구조체, 열거형, 프로토콜 타입에 새로운 기능을 추가할 수 있는 방법으로 활용된다. 익스텐션을 이용해서 컴퓨터 연산 프로퍼티 Computed properties, 컴퓨터 연산 타입 프로퍼티 Computed type properties를 추가할 수 있고, 인스턴스 메소드와 타입 메소드를 정의할 수 있으며, 새로운 초기화 객체를 추가할 수 있다. 또, 서브스크립트를 정의하거나 새로운 중첩 타입 nested types을 정의 및 사용할 수 있고, 기존의 타입을 프로토콜에 부합하도록 만들 수도 있다."
 - Apple Swift Documentation -
 */
