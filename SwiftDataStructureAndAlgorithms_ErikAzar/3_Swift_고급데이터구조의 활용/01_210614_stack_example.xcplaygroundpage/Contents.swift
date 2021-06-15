import UIKit

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

    var myStack = Stack<Int>()
// 'push' 순서대로 stack을 쌓음
// Stack에서 LIFO(Last In First Out)을 볼 수 있음
myStack.push(element: 5)
// 5
myStack.push(element: 44)
// 5, 44
myStack.push(element: 23)
// 5, 44, 23
// pop
// 마지막 Array가 하나씩 빠짐
var x = myStack.pop()

x = myStack.pop()
// 5, 44
x = myStack.pop()
// 5
// 마지막으로 남아있던 5가 pop되어 nil
x = myStack.pop()
// nil

