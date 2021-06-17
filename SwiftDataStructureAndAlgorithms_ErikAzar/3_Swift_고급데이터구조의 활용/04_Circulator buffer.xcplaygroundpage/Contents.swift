// Circulator buffer - 순환 버퍼

/*
 📌📍🔺🔻♦️
 🔴🟠🟡🟢🔵🟣⚪️🟤
 ✅❎
 🧠
*/

import Foundation

/*
 시작 부분을 연결해주는 - 헤드 인덱스 Head Index
                    - 테일 인덱스 Tale Index 등
📍 고정 크기의 데이터 구조
 
 순환 버퍼 - FIFO 데이터 구조를 구현할 때 유용함
        - Head index와 Tale index가 맞물려 있음
        - 크기가 고정, 고로 버퍼의 메모리 크기 역시 안정적 상태
        

 Function
        - 버퍼의 크기를 조절할 수 있는 기능
        - 기존의 데이터 요소를 새로 생성된 버퍼로 전달할 수 있는 기능
 버퍼의 크기를 빈번하게 조절해야 하는 경우,
 배열 대신 *연결 목록
 */

/*
 📌버퍼 메소드
 push() : 버퍼의 끝에 요소를 추가
 pop() : 버퍼의 첫 번째 요소를 반환하고 버퍼에서 삭제
 peek() : 버퍼의 첫 번째 요소를 반환하되 삭제하지는 않음
 clear() : 버퍼를 재설정해 빈 상태로 만듦
 isEmpty() : 버퍼가 비어있는 경우 true를 반환하고, 그렇지 않은 경우 false를 반환
 isFull() : 버퍼가 가득 차있는 경우 true를 반환하고, 아니면 false
 count : 버퍼에 포함된 요소의 수를 반환
 capacity : 버퍼의 용량을 반환 또는 설정할 수 있는 read/write 프로퍼티
 
 📌도우미 메소드
 insert(_:atIndex) : 버퍼의 특정 인덱스 위치에 요소를 삽입하는 메소드
 removeAtIndex(_) : 버퍼의 특정 인덱스 위치에 있는 요소를 제거하는 메소드
 
 */


// 🟢 구현 방법

public struct CircularBuffer<T> {
    fileprivate var data: [T]
    fileprivate var head: Int = 0, tail: Int = 0
    
    private var interalCount: Int = 0
    private var overwriteOperation: CircularBufferOperation = CircularBufferOperation.Overwrite
    
    // 빈 CircularBuffer 구조를 생성
    public init() {
    data = [T]()
    data.reserveCapacity(Constants.defaultBufferCapacity)
    }
    
    // 'count' 프로퍼티의 CircularBuffer를 생성
    // - 주의: 'count'만큼 2를 거듭제곱하지 않은 경우,
    // 그에 가장 가까운 수만큼 2를 거듭제곱함
    public init(_ count: Int, overwriteOperation: CircularBufferOperation = .Overwrite) {
        var capacity = count
        if (capacity < 1) {
            capacity = Constants.defaultBufferCapacity
        }
        
        // 'count'만큼 2를 거듭제곱으로 함
        if ((capacity & (~capacity +1)) != capacity) {
            var b = 1
            while (b < capacity) {
                b = b << 1
            }
            capacity = b
        }
        
        data = [T]()
        data.reserveCapacity(capacity)
        self.overwriteOperation = overwriteOperation
    }
    
    // 시퀀스에서 CircularBuffer를 생성
    public init<S: Sequence>(_ elements: S, size: Int)
    where S.Iterator.Element == T {
        self.init(size)
        elements.forEach({ push(element: $0) })
    }
    
    // 버퍼에서 첫 번째 요소를 삭제한 뒤 반환
    // - 반환값의 타입 :
    // - 버퍼가 비어있지 않은 경우, 첫 번째 요소의 타입은 'T'
    // - 버퍼가 비어있는 경우, 'nil'을 반환.
    public mutating func pop() -> T? {
        if (isEmpty()) {
            return nil
        }
        
        let el = data[head]
        head = incrementPointer(pointer: head)
        internalCount -= 1
        return el
    }

}
