

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

// 옵셔널을 다루는 다섯 가지 방법
// 옵셔널타입은 바로 사용할 수 없음(바로 연산, 출력 불가능)
// 1. 옵셔널 체이닝
// 완전히 옵셔널을 벗겨내지 않고 접근할 때 사용
struct Developer {
    var name: String
}
struct Company {
    var name: String
    var developer: Developer?
}
var developer = Developer(name: "Mark")
var company = Company(name: "Olive", developer: developer)
print(company.developer?.name) // Optional("Mark")
// 강제 언랩핑
print(company.developer!.name) // Mark

// 2. Optional Binding : 옵셔널 바인딩
// (1,2 뉘앙스 다름)
// 2-1. if let : 값이 있으면 가져와라
if let testStr = optionalString {
    print("if let : "+testStr+notOptionalString)
}

// 2-2. guard let : 값이 없으면 실행해라.
func test() {
    guard let testStr2 = optionalString else {
        return
    }
    print("guard let : "+testStr2+notOptionalString)
}
test()
// 3. Force unwrapping : 강제 언랩핑
print("force unwrapping : " + optionalString! + notOptionalString)

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

// 5. 암시적 추출 옵셔널 (Implicitly Unwrapped Optionals)
// 매번 옵셔널 바인딩하는 것이 불팰요할 때 사용한다.
// 옵셔널과 같으나 nil이 할당되어있을 때 접근하려고 하면 오류가 난다.
var owner: Person!

// 6. nil 병합 연산자(Nil Coalescing)
// 옵셔널 변수가 nil일 경우 반환하는 값을 명시한다.
var nilC: Int?
var num22 = nilC ?? 5
print(num22) // 5

// 구조체
struct User {
    var nickname: String
    var age: Int
    
    func information() {
        print("\(nickname) : \(age)")
    }
}
// memberwise가 아닌 custom Initializer
extension User {
    init(nickname: String) {
        self.nickname = nickname
        self.age = 24
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


// enum
// 1. 연관된 항목을 나열
// 2. 새로운 타입처럼 사용 가능해서 class처럼 대문자로 선언
// 3. 각 항목은 항목의 원시값(rawValue)을 가지게 할 수 있음(특정 타입으로 선언 가능)
// 다른 언어에서는 Integer타입 원시값만 가질 수 있지만 swift는 String, Character, Number Type 가능
// 모든 케이스가 동일한 형식을 사용해야함

// raw value를 할당한 경우
enum CompassPoint: String {
    case north = "북"
    case south = "남"
    case east = "동"
    case west
}
var direction: CompassPoint = .north
direction = .south
switch direction {
case .north:
    print(direction.rawValue)
case .south:
    print(direction.rawValue)
case .east:
    print(direction.rawValue)
case .west:
    print(direction.rawValue)
}
// 3-1. 생성자 매개변수로 rawValue를 넘겨 항목을 알 수 있음
// 없을 경우 nil을 리턴(생성자는 옵셔널)
let direction2 = CompassPoint(rawValue: "남")

enum Task: Int {
    case morning, afternoon = 100, evening
}
enum Planet: Int {
    case mercury = 1, venus, earth, mars, jupiter, saturn, uranus, neptune
}
let earth = Planet(rawValue: 3)
print(earth!) // earth


enum Score: Character {
    case math = "A"
    case science = "B"
    // 원시값이 Charater형일 때 모든 항목을 직접 할당해줘야함
    // case evening
}

// 4. 재귀 열거형 indirect
enum ArithmeticExpression {
    case number(Int)
    indirect case addition(ArithmeticExpression, ArithmeticExpression)
    indirect case multiplication(ArithmeticExpression, ArithmeticExpression)
}

// 원시값 선언하지 않을 경우 항목명으로 들어감
// 원시값이 Int형일 경우 0부터. 선언한 값이 있다면 그 이후부터 1씩 올라감
CompassPoint.west.rawValue // west
Task.morning.rawValue // 0
Task.afternoon.rawValue // 100
Task.evening.rawValue // 101


// 4. 연관값(associated value)을 가질 수 있음
// 항목과 연관된 다른 타입의 값을 저장할 때 사용
enum PhoneError {
    case unknown
    case batteryLow(String, Int)
    
}
let error = PhoneError.batteryLow("배터리가 곧 방전됩니다. ", 5)
switch error {
case .batteryLow(let message, let percent):
    print("\(message)\(percent)퍼센트 입니다.")
case .unknown:
    print("알 수 없는 에러입니다.")
}
// 배터리가 곧 방전됩니다. 5퍼센트 입니다.

// 에러 처리
// 프로그램 내에 에러가 발생한 상황에 대응하고 복구하는 과정
// 런타임에 에러가 발생한 경우
// 1. 발생(throwing) 2. 감지(catching) 3. 전파 propagaing
// 4. 조작(manipulating)

// 에러 프로토콜 채택한 열거형 선언
enum PhoneError2: Error {
    case unknown
    case batteryLow(batteryLevel: Int)
}

// 에러 발생 예상 부분에 throw로 오류를 던짐 -> 오류 발생시 이후 코드는 실행되지 않음
// "olive" == "Olive" throw PhoneError2.batteryLow(batteryLevel: 20)
// Swift에서 오류를 처리하는 방법 4가지
// 1. 함수에서 발생한 오류를 해당 함수를 호출한 코드에 전파
func checkPhoneBatteryStatus(batterLevel: Int) throws -> String {
    guard batterLevel != -1 else {
        throw PhoneError2.unknown
    }
    guard batterLevel >= 20 else {
        throw PhoneError2.batteryLow(batteryLevel: 20)
    }
    return "배터리 상태가 정상입니다."
}
// 2. do catch로 해결
// 오류 발생을 전달받은 코드블록에서 do catch로 오류 처리
// do에서 오류를 던지고 catch에서 오류를 전달받아 예외처리
do {
    try checkPhoneBatteryStatus(batterLevel: -1)
} catch PhoneError2.unknown{
    print("알 수 없는 에러")
} catch PhoneError2.batteryLow(let batteryLabel) {
    print("배터리 전원 부족 남은 배터리 : \(batteryLabel)")
} catch {
    print("그 외 오류 발생 : \(error)")
}
// 3. optional 값으로 처리
// 4. 오류가 나지 않을 것으로 확신

// Escaping
// 1. 함수의 밖의 변수에 저장되거나
// 2. 함수가 종료된 뒤 실행
// non-Escaping Closure
func runClosure(closure: () -> Void) {
    print("전")
    closure()
    print("후")
}
runClosure {
    print("runClosure")
}
//전
//runClosure
//후

class closureTestClass {
    // 얘는 @escape closure
    var property: (() -> Void)?
    
    func closureTestFunction(closure: @escaping () -> Void) {
        // 인자 closure는 non-escaping => 할당 불가
        // non es-는 es에 할당할 수 없지만 반대로 es는 non에 할당가능
        self.property = closure
    }
}



