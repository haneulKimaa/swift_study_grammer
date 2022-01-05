

import UIKit
import Foundation

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

// 옵셔널 바인딩 : 옵셔널타입은 바로 사용할 수 없음(바로 연산, 출력 불가능)
// 3가지 방법 존재(1,2 뉘앙스 다름)
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

// 4. 묵시적 해제 : 컴파일러에 의한 자동 해제
// 4-1. 비교연산자를 통해 값을 비교하면 자동으로 변환.
var optionalInt: Int? = 6
if optionalInt == 6 {
    print(optionalInt)
} else {
    print(optionalInt)
}

// 4-2. 형변환시 옵셔널 사용해야하는 경우 (옵셔널 아닐 시 오류)
// 변환할 값이 변환 후 타입과 맞지 않을 수 있기 때문
let string: String = "12"
var stringToInt: Int! = Int(string)
// 바인딩해야 출력 가능
print(stringToInt+1)


// 구조체
struct User {
    var nickname: String
    var age: Int
    
    func information() {
        print("\(nickname) : \(age)")
    }
}
// 구조체 - 인스턴스 생성
var user = User(nickname: "olive", age: 23)
user.information() // olive : 23
user.nickname = "Mark"
user.information() // Mark : 23

// 클래스
// 생성자 초기화 필수(class .. has no initializers)
class Person {
    var name: String
    var age: Int
    // 실패 가능한 이니셜라이저(옵셔널 반환 가능한 경우)
    init?(age: Int, name: String){
        self.name = name
        self.age = age
        if (0...120).contains(age) == false {
            return nil
        }
    }
    deinit {
        print("\(name)이 삭제되었습니다.")
    }
}
var aPerson: Person? = Person(age: 130, name: "Olive")
print("aPerson is \(aPerson)") // aPerson is nil
aPerson = nil // Olive이 삭제되었습니다.
class Dog {
    var name: String = ""
    var age: Int = 0
    
    // 암시적 추출 옵셔널
    // 인스턴스 사용에 꼭 필요하지만 초기값을 설정하지 않을 때
    var owner: Person!
    
    // 옵셔널
    var nickname: String?
    
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
    convenience init(name: String, age: Int, nickname: String) {
        // 중복코드 줄이기
        // 생성자에 convenience가 붙어야함
        self.init(name: name, age: age)
        self.nickname = nickname
    }

    func introduce()  {
        print("my \(name), \(age)")
        // owner 없을 때 nill 반환
        print("owner is \(owner.name)")
    }
}

var dog = Dog(name: "dog", age: 12)
dog.name = "bin"
dog.age = 11
// 암시적 추출 옵셔널 접근 오류
// dog.introduce()

// error: Execution was interrupted, reason: EXC_BAD_INSTRUCTION (code=EXC_I386_INVOP, subcode=0x0).
// The process has been left at the point where it was interrupted, use "thread return -x" to return to the state before expression evaluation.

let dog2 = dog
dog2.name = "gin"
// dog2.introduce() // my gin, 11


// 고차함수
// 전달인자를 함수로 전달받거나 함수 실행의 결과를 함수로 반환하는 함수

// 고차함수 고차함수 1. map
let num: [Int] = [0, 1, 2, 3]
var num2 = num.map({(number: Int) -> Int in
    return number * 2
})
// 생략
var num3 = num.map{String($0)}

// 고차함수 2. filter
// 컨테이너 내부의 값을 걸러서 새로운 컨테이너로 추출
let numbers2: [Int] = num.filter({(number: Int) -> Bool in
    return number%2 == 0
})
numbers2
let number3: [Int] = num.filter{
    $0 % 2 == 0
}
number3

// 고차함수 3. reduce
// 컨테이너 내부의 콘텐츠를 하나로 통합
let sum: Int = num.reduce(0, {(first: Int, second: Int) -> Int in
    return first + second
})
sum
let sum2: Int = num.reduce(0) {$0*$1}
sum2

// assert
// 디버깅 모드에서만 사용 가능
// 코드가 실행될 때 반드시 만족해야하는 상황에서 사용한다.
var someInt: Int = 0
// assert 오류!
//assert(someInt == 1, "someInt가 0이 아님!")
print("i don't know") // 출력되지 않음

// guard
// 빠른 종료(early exit)를 위해서 사용
// 디버깅뿐만 아니라 어떤 조건에서도 사용 가능
// else문 내에 코드블럭을 종료하는 지시어가 반드시 있어야함
var someInt2: Int?
func runGuard() {
    guard let a = someInt2 else {
        print("someInt2 is nil")
        return
    }
    print("\(a)")
}
someInt2 = nil
runGuard() // someInt2 is nil
someInt2 = 24
runGuard() // 24
//print("\(a)")


