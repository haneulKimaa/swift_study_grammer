# :rocket: Swift 문법 공부

개인 공부 목적의 코드입니다 :)

---

## 목차
1. [함수 종류](#sparkles-함수-종류)<br>
2. [조건문](#sparkles-조건문) <br>
3. [옵셔널](#sparkles-옵셔널) <br>  
    옵셔널을 다루는 다섯 가지 방법 <br>
    1. [암시적 추출 옵셔널](#1-암시적-추출-옵셔널-implicitly-unwrapped-optionals) <br>
    2. [옵셔널 바인딩](#2-옵셔널-바인딩-optional-binding) <br>
    3. [강제 언랩핑](#3-강제-언랩핑-forced-unwrapping) <br>
    4. [묵시적 해제](#4-묵시적-해제)
    5. [옵셔널 체이닝](#5-옵셔널-체이닝)
    
4. [구조체](#sparkles-구조체) <br>
5. [클래스](#sparkles-클래스) <br>  
    5-1. [클래스와 구조체의 차이점](#heavy_exclamation_mark-클래스와-구조체의-차이점) <br>
    5-2. [클래스 초기화](#heavy_exclamation_mark-클래스-초기화-initializers) <br>
　5-2-1. [실패 가능한 초기화](#heavy_exclamation_mark-실패-가능한-초기화) <br>
    5-3. [deinitializers](#heavy_exclamation_mark-deinitializers) <br>
6. [고차함수](#sparkles-고차함수) <br>
7. [assert](#sparkles-assert) <br>
8. [enum](#sparkles-enum) <br>
9. [에러 처리](#sparkles-에러-처리) <br>

--------

## :sparkles: 함수 종류
1. 기본형
```Swift
func sum(a: Int, b: Int) -> Int {
    return a+b
}
```
1-1. 파라미터에 디폴드 값 지정
```Swift
func sumDefinedValue(a: Int, b: Int=1) -> Int {
    return a+b
}
```
2. 전달인자 레이블 사용(의미를 분명하게 해줌-> 코드 가독성 높임)
```Swift
func sendMessage(from myName: String, to name: String) -> String {
    return "Hello \(name) \(myName)"
}
```
3. 와일드 카드 식별자 사용(전달인자 레이블 사용하지 않음)
```Swift
func sendMessage2(_ name: String) -> String {
    return "Hello \(name)"
}
```
4. 가변매개변수 (배열로 넘겨받음)
```Swift
func sendmessage3(me: String, friends: String...) -> String {
    return "Hello \(friends)! my name is \(me)"
}
```
<br><br>
## :sparkles: 조건문
1. repeat - while(조건문 체크전에 일단 실행)
```Swift
var x = 2
repeat {
    x+=2
    print("value \(x)")
} while x<2
```
2. while : 출력 없음
```Swift
x = 2
while x<2 {
    x+=2
    print("value \(x)")
}
```
<br><br>
## :sparkles: 옵셔널
> nil값일 수 있는 값 <br>
```Swift
var optionalString: String? = nil
var notOptionalString: String = " aloha"
print(optionalString) // nil
optionalString = "olive"
print(optionalString) // Optional("olive") -> 연산 안됨
//print(optionalString+notOptionalString) // Optional("olive") -> 오류(언랩핑 필요)
```

<br><br>
### :heavy_exclamation_mark: 옵셔널을 다루는 다섯 가지 방법

### 1. 암시적 추출 옵셔널 (Implicitly Unwrapped Optionals)
> 매번 옵셔널 바인딩하는 것이 불팰요할 때 사용한다.
> 옵셔널과 같으나 nil이 할당되어있을 때 접근하려고 하면 오류가 난다.
<br>

선언 
```Swift
var owner: Person!
```
<details markdown="1">
<summary>접근시 나는 오류 메시지</summary>

error: Execution was interrupted, reason: EXC_BAD_INSTRUCTION (code=EXC_I386_INVOP, subcode=0x0).
The process has been left at the point where it was interrupted, use "thread return -x" to return to the state before expression evaluation. <br>
__lldb_expr_12/grammar_basic.playground:153: Fatal error: Unexpectedly found nil while implicitly unwrapping an Optional value<br>

</details>

<br><br>

### 2. 옵셔널 바인딩 (Optional Binding)
> 옵셔널타입은 바로 사용할 수 없음(바로 연산, 출력 불가능) <br>
> 3가지 방법. if let과 guard let의 뉘앙스 차이가 있다! <br>
1. if let : 값이 있으면 가져와라
```Swift
if let testStr = optionalString {
    print("if let : "+testStr+notOptionalString)
}
```
2. guard let : 값이 없으면 실행해라.
> 빠른 종료(early exit)를 위해서 사용 <br>
> 디버깅뿐만 아니라 어떤 조건에서도 사용 가능 <br>
> else문 내에 코드블럭을 종료하는 지시어가 반드시 있어야함 <br>
```Swift
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
```
<br>

### 3. 강제 언랩핑 (Forced Unwrapping)
```Swift
print("force unwrapping : "+optionalString!+notOptionalString)
```

### 4. 묵시적 해제
> 컴파일러에 의한 자동 해제 <br>

- 비교연산자를 통해 값을 비교하면 자동으로 변환.
```Swift
var optionalInt: Int? = 6
if optionalInt == 6 {
    print(optionalInt)
} else {
    print(optionalInt)
}
```

<br>

- 형변환시 옵셔널 사용해야하는 경우 (옵셔널 아닐 시 오류) <br>
변환할 값이 변환 후 타입과 맞지 않을 수 있기 때문 <br>

```Swift
let string: String = "12"
var stringToInt: Int! = Int(string)
// 바인딩해야 출력 가능
print(stringToInt+1)
```
<br>

### 5. 옵셔널 체이닝
> 완전히 옵셔널을 벗겨내지 않고 접근할 때 사용 <br>

```Swift
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
```
<br><br>

## :sparkles: 구조체
```Swift
struct User {
    var nickname: String
    var age: Int
    
    func information() {
        print("\(nickname) : \(age)")
    }
}
```
구조체 - 인스턴스 생성
```Swift
var user = User(nickname: "olive", age: 23)
user.information() // olive : 23
user.nickname = "Mark"
user.information() // Mark : 23
```
<br><br>
## :sparkles: 클래스
> 생성자 초기화 필수(class .. has no initializers)<br>
```Swift
class Dog {
    var name: String = ""
    var age: Int = 0
    
    init() {
        self.name = name
        self.age = age
    }
    func introduce() {
        print("my \(name), \(age)")
    }
}

var dog = Dog()
dog.name = "bin"
dog.age = 11
dog.introduce() // my bin, 11
```
<br>

### :heavy_exclamation_mark: 클래스와 구조체의 차이점

|항목|Class|Struct|
|---|---|---|
|타입|참조|값|
|상속|가능|불가능|
|형변환(상위 또는 하위 클래스 타입으로)|가능|불가능|
|디이널라이저|가능|불가능|
|참조 횟수 계산|가능|불가능|

#### 참조 타입이란?
> 값이 복사되는 것이 아닌 메모리를 참조한다.
```Swift
var dog = Dog()
dog.name = "bin"
dog.age = 11
dog.introduce() // my bin, 11
let dog2 = dog
dog2.name = "gin"
dog2.introduce() // my gin, 11
```
위에서 dog2는 dog가 복사된 것이 아닌 dog가 가리키는 값을 참조하기 때문에 상수로 선언되어도 값이 변경 가능하다.
<br><br>

### :heavy_exclamation_mark: 클래스 초기화 (initializers)
> 생성자(기본 형태)
```Swift
init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
```
> 자신 클래스의 생성자를 받아와서 사용하는 경우
```Swift
convenience init(name: String, age: Int, nickname: String) {
    // 중복코드 줄이기
    // 생성자에 convenience가 붙어야함
    self.init(name: name, age: age)
    self.nickname = nickname
}
```
<br>

### :heavy_exclamation_mark: 실패 가능한 초기화
> 인스턴스 생성시 옵셔널로 생성해야한다.
<br>
선언 <br>

```Swift
init?(age: Int){
    if (0...120).contains(age) == false {
        return nil
    }
}
```

인스턴스 생성<br>

```Swift
var aPerson: Person? = Person(age: 130, name: "Olive")
print("aPerson is \(aPerson)") // aPerson is nil
```
<br>

### :heavy_exclamation_mark: deinitializers
> 클래스의 인스턴스가 메모리에서 해제되는 시점에 호출된다.<br>
> 매개변수를 가질 수 없다. <br>
<br>

```Swift
deinit {
    print("\(name)이 삭제되었습니다.")
}
```

```Swift
aPerson = nil // Olive이 삭제되었습니다.
```

<br>

## :sparkles: 고차함수
> 전달인자를 함수로 전달받거나 함수 실행의 결과를 함수로 반환하는 함수

1. map
```Swift
let num: [Int] = [0, 1, 2, 3]
var num2 = num.map({(number: Int) -> Int in
    return number * 2
})
// 생략
var num3 = num.map{String($0)}
```

2. filter
> 컨테이너 내부의 값을 걸러서 새로운 컨테이너로 추출
```Swift
let numbers2: [Int] = num.filter({(number: Int) -> Bool in
    return number%2 == 0
})
numbers2
let number3: [Int] = num.filter{
    $0 % 2 == 0
}
```

3. reduce
> 컨테이너 내부의 콘텐츠를 하나로 통합
```Swift
let sum: Int = num.reduce(0, {(first: Int, second: Int) -> Int in
    return first + second
})
let sum2: Int = num.reduce(0) {$0*$1}
```
<br>

## :sparkles: assert
> 디버깅 모드에서만 사용 가능 <br>
> 코드가 실행될 때 반드시 만족해야하는 상황에서 사용한다. <br>
> assert는 주장한다는 의미로, 디버깅시 "이 값이 나와야해!"조건의 검증을 위해 사용한다. <br>
> assert(조건, 실패시 출력할 메시지) <br>
```Swift
var someInt: Int = 0
assert(someInt == 1, "someInt가 0이 아님!")
print("i don't know") // 출력되지 않음
```
<details markdown="1">
<summary>assert문에서 나는 오류 메시지</summary>

error: Execution was interrupted, reason: EXC_BAD_INSTRUCTION (code=EXC_I386_INVOP, subcode=0x0).
The process has been left at the point where it was interrupted, use "thread return -x" to return to the state before expression evaluation. <br>
__lldb_expr_27/grammar_basic.playground:210: Assertion failed: someInt가 0이 아님!<br>

</details>

<br><br>

## :sparkles: enum
1. 연관된 항목을 나열 <br>
2. 새로운 타입처럼 사용 가능해서 class처럼 대문자로 선언 <br>
3. 각 항목은 항목의 원시값(rawValue)을 가지게 할 수 있음(특정 타입으로 선언 가능) <br>
> 다른 언어에서는 Integer타입 원시값만 가질 수 있지만 swift는 String, Character, Number Type 가능 <br>
> 모든 케이스가 동일한 형식을 사용해야함 <br>

```Swift
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
```
<br>

3-1. 생성자 매개변수로 rawValue를 넘겨 항목을 알 수 있음
> 없을 경우 nil을 리턴(생성자는 옵셔널) <br>
```Swift
let direction2 = CompassPoint(rawValue: "남")

enum Task: Int {
    case morning, afternoon = 100, evening
}
enum Score: Character {
    case math = "A"
    case science = "B"
    // 원시값이 Charater형일 때 모든 항목을 직접 할당해줘야함
    // case evening
}
// 원시값 선언하지 않을 경우 항목명으로 들어감
// 원시값이 Int형일 경우 0부터. 선언한 값이 있다면 그 이후부터 1씩 올라감
CompassPoint.west.rawValue // west
Task.morning.rawValue // 0
Task.afternoon.rawValue // 100
Task.evening.rawValue // 101
```
<br>

4. 연관값(associated value)을 가질 수 있음
> 항목과 연관된 다른 타입의 값을 저장할 때 사용
<br>

```Swift
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
```
<br>

## :sparkles: 에러 처리
> 프로그램 내에 에러가 발생한 상황에 대응하고 복구하는 과정 <br>
> 런타임에 에러가 발생한 경우 <br>
> 1. 발생(throwing) 2. 감지(catching) 3. 전파(propagaing) 4. 조작(manipulating) <br>

에러 프로토콜 채택한 열거형 선언
```Swift
enum PhoneError2: Error {
    case unknown
    case batteryLow(batteryLevel: Int)
}
```

### :heavy_exclamation_mark: Swift에서 오류를 처리하는 4가지 방법
<img src="https://user-images.githubusercontent.com/63438947/148641910-f1769479-1c88-486b-bf79-0bf59a776ca6.jpeg"  width="700" height="370"> 
<br>

1. 함수에서 발생한 오류를 해당 함수를 호출한 코드에 전파
```Swift
func checkPhoneBatteryStatus(batterLevel: Int) throws -> String {
    guard batterLevel != -1 else {
        throw PhoneError2.unknown
    }
    guard batterLevel >= 20 else {
        throw PhoneError2.batteryLow(batteryLevel: 20)
    }
    return "배터리 상태가 정상입니다."
}
```
<br>

2. do catch로 해결
> 오류 발생을 전달받은 코드블록에서 do catch로 오류 처리 <br>
> do에서 오류를 던지고 catch에서 오류를 전달받아 예외처리
```Swift
do {
    try checkPhoneBatteryStatus(batterLevel: -1)
} catch PhoneError2.unknown{
    print("알 수 없는 에러")
} catch PhoneError2.batteryLow(let batteryLabel) {
    print("배터리 전원 부족 남은 배터리 : \(batteryLabel)")
} catch {
    print("그 외 오류 발생 : \(error)")
}
```
<br>

3. optional 값으로 처리
4. 오류가 나지 않을 것으로 확신
