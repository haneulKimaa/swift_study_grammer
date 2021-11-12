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


// 조건문
// repeat - while(조건문 체크전에 일단 실행)
var x = 2
repeat {
    x+=2
    print("value \(x)")
} while x<2

// while : 출력 없음
x = 2
while x<2 {
    x+=2
    print("value \(x)")
}


// 옵셔널 : nil값일 수 있는 값
var optionalString: String? = nil
var notOptionalString: String = " aloha"
print(optionalString) // nil
optionalString = "olive"
print(optionalString) // Optional("olive") -> 연산 안됨
//print(optionalString+notOptionalString) // Optional("olive") -> 오류(언랩핑 필요)

// 옵셔널 바인딩 : 3가지 방법 존재(1,2 뉘앙스 다름)
// 1. if let : 값이 있으면 가져와라
if let testStr = optionalString {
    print("if let : "+testStr+notOptionalString)
}

// 2. guard let : 값이 없으면 실행해라.
func test() {
    guard let testStr2 = optionalString else {
        return
    }
    print("guard let : "+testStr2+notOptionalString)
}
test()
// 3. 강제 언랩핑
print("force unwrapping : "+optionalString!+notOptionalString)
