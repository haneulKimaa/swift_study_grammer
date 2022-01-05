# :rocket: Swift 문법 공부

## 목차
1. [함수 종류](#sparkles-함수-종류)<br>
2. [조건문](#sparkles-조건문) <br>
3. [옵셔널](#sparkles-옵셔널) <br>
    3-1. [암시적 추출 옵셔널](#heavy_exclamation_mark-암시적-추출-옵셔널-implicitly-unwrapped-optionals) <br>
    3-2. [옵셔널 바인딩](#heavy_exclamation_mark-옵셔널-바인딩-optional-binding) <br>
4. [구조체](#sparkles-구조체) <br>
5. [클래스](#sparkles-클래스) <br>
    5-1. [클래스와 구조체의 차이점](#heavy_exclamation_mark-클래스와-구조체의-차이점) <br>
    5-2. [클래스 초기화](#heavy_exclamation_mark-클래스-초기화-initializers) <br>
　5-2-1. [실패 가능한 초기화](#heavy_exclamation_mark-실패-가능한-초기화) <br>
    5-3. [deinitializers](#heavy_exclamation_mark-deinitializers) <br>
6. [고차함수](#sparkles-고차함수) <br>
7. [assert](#sparkles-assert) <br>


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

### :heavy_exclamation_mark: 암시적 추출 옵셔널 (Implicitly Unwrapped Optionals)
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

### :heavy_exclamation_mark: 옵셔널 바인딩 (Optional Binding)
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

3. 강제 언랩핑 (Forced Unwrapping)
```Swift
print("force unwrapping : "+optionalString!+notOptionalString)
```

4. 묵시적 해제 : 컴파일러에 의한 자동 해제 <br>
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


