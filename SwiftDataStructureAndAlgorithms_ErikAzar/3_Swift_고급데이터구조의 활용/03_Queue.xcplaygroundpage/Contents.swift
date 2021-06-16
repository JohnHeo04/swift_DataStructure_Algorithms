// 큐 - Queue
/*
 📌📍🔺🔻♦️
 🔴🟠🟡🟢🔵🟣⚪️🟤
 ✅❎
 🧠
*/

/*
 먼저 입력된 데이터가 먼저 출력되는 FIFO(First In First Out)데이터 구조를 지님
 
 EX) 슈퍼마켓에서 계산을 위해 줄을 선 구매자들과 비슷한 모습
 줄의 맨 앞에 선 구매자(head)가 계산대에 도착하면, 계산원은 구매한 물건을 계산하고 구매자는 댓가를 지불한 뒤
물건을 모두 담아서는 떠나게(pop) 됨
 두 번째 구매자는 줄의 첫 번째 위치로 이동하고, 첫 번째 구매자가 거쳤던 과정을 반복
 0. ◼︎-> ◻︎◻︎◻︎◻︎◻︎  (push)
 1.     ◼︎◻︎◻︎◻︎◻︎
 2.     ◻︎◼︎◻︎◻︎◻︎
 3.     ◻︎◻︎◼︎◻︎◻︎
 4.     ◻︎◻︎◻︎◼︎◻︎
 5.     ◻︎◻︎◻︎◻︎◼︎
 6.     ◻︎◻︎◻︎◻︎◻︎  (◼︎-pop)
 7. 위의 과정 반복
 */

/*
 🔴다음 Queue 7 메소드 제공🔴
 enqueue() : 큐의 맨 뒤에 새로운 요소를 추가
 dequeue() : 큐에서 첫 번째 요소를 제거한 뒤 반환
 peek() : 큐의 첫 번째 요소를 반한하되, 제거하지는 않음
 clear() : 큐를 재설정해 빈 상태가 되게 함
 count : 큐에 있는 요소의 수를 반환
 isEmpty() : 큐가 비어있으면 true를 반환, 그렇지 않은 경우 false를 반환
 isFull() : 큐가 꽉 차있으면 true 반환, 아니면 false 반환
 
 🟡그 외 도우미 메소드
 capacity : 큐 용량을 가져오거나 설정하기 위한 read/write 프로퍼티
 insert(_:atIndex) : 큐의 특정 인덱스 위치에 요소를 삽입
 removeAtIndex(_) : 큐의 특정 인덱스 위치에 있는 요소를 제거
 
 */

/*
 🔴음식점에서 주문 및 계산에 사용하는 POS(Point-Of-Sale) 시스템이 대표적
 
 이번 큐 데이터 구조를 구현할 때도 어떤 데이터 타입이든 받아들일 수 있을 정도로 유연한 스위프트 '제너릭'을 활용 예정
 
 */

public struct Queue<T> {
    private var data = [T]()
    // 빈 큐 구조를 정의
    public init() {}

    // 큐에서 첫 번째 요소를 제거하고 반환
    // - 반환값 :
    // - 큐가 빈 상태가 아닌 경우, 첫 번째 요소의 타입은 'T'
    // - 큐가 빈 상태인 경우, 'nil'을 반환
    public mutating func dequeue() -> T? {
        return data.removeFirst()
    }
    
    // 큐에서 첫 번째 요소를 제거하지 않고 반환
    // - 반환값 :
    // - 큐가 빈 상태가 아닌 경우, 첫 번째 요소의 타입은 'T'
    // - 큐가 빈 상태인 경우, 'nil'을 반환
    public func peek() -> T? {
        return data.first
    }
    
    // 큐의 맨 뒤에 요소를 추가
    // - 복잡성 : O(1)
    // - 파라미터 요소 : 'T' 타입의 요소
    public mutating func enqueue(element: T) {
        data.append(element)
    }
    
    //MARK : - 순환 버퍼를 위한 도우미 메소드 구현
    // 버퍼를 재설정해 빈 상태가 되게 함
    public mutating func clear() {
        data.removeAll()
    }
    
    
    // 큐에 있는 요소의 수를 반환
    // 'count'는 큐에 있는 요소의 수
    public var count: Int {
        return data.count
    }
    
    // 큐의 용량을 반환
    public var capacity: Int {
        get {
            return data.capacity
        }
        set {
            data.reserveCapacity(newValue)
        }
    }
    
    // 큐가 꽉 찼는지 확인
    // - 반환값 : 큐가 꽉 찬 경우 'True'를 반환, 그렇지 않으면 'false' 반환
    public func isFull() -> Bool {
        return count == data.capacity
    }
    
    // Check if the queue is empty
    // 반환값 : 큐가 비어있는 경우 'ture', 아니면 'false' 반환
    public func isEmpty() -> Bool {
        return data.isEmpty
    }
}

/*
 
 🧠큐 데이터 구조의 구현은 비교적 간단🧠 :
 배열을 wrapping하고 접근자 메소드를 통해 큐의 속성을 나타내도록 함
 이때 배열의 용량은 포함되는 데이터의 수에 따라 동적으로 조절됨
 
 */

// 예제

var queue = Queue<Int>()
// []
queue.enqueue(element: 100)
// [100]
queue.enqueue(element: 120)
// [100, 120]
queue.enqueue(element: 125)
// [100, 120, 125]
queue.enqueue(element: 130)
// [100, 120, 125, 130]


let x = queue.dequeue()
// Optional(100)

// 해당 요소를 제거하지 않고 다음 요소를 확인
let y = queue.peek()
// Optional(120)
// dequeue로 120 요소 제거하기
let z = queue.dequeue()
// Optional(120)


// ✅프로토콜
/*
 CustomerStringConvertible, CustomerDebugStringConvertible
 두 가지 프로토콜을 만들어서 타입 값을 출력할 때 좀 더 이해하기 쉬운 이름을 반환하도록 함
 */

extension Queue: CustomStringConvertible, CustomDebugStringConvertible {
    
    public var description: String {
        return data.description
    }
    
    public var debugDescription: String {
        return data.debugDescription
    }
}
