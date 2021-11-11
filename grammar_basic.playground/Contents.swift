import UIKit

// 함수 종류
// 1. 기본형
func sum(a: Int, b: Int) -> Int {
    return a+b
}
// 1-1. 파라미터에 디폴드 값 지정
func sumDefinedValue(a: Int, b: Int=1) -> Int {
    return a+b
}
sum(a: 1, b: 2)
sumDefinedValue(a: 1)

// 2. 전달인자 레이블 사용(의미를 분명하게 해줌-> 코드 가독성 높임)
func sendMessage(from myName: String, to name: String) -> String {
    return "Hello \(name) \(myName)"
}
sendMessage(from: "Kim", to: "olive")

// 3. 와일드 카드 식별자 사용(전달인자 레이블 사용하지 않음)
func sendMessage2(_ name: String) -> String {
    return "Hello \(name)"
}
sendMessage2("olive")

// 4. 가변매개변수 (배열로 넘겨받음)
func sendmessage3(me: String, friends: String...) -> String {
    return "Hello \(friends)! my name is \(me)"
}
sendmessage3(me: "Olive", friends: "aa", "b", "c")

