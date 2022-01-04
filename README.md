# :rocket: Swift 문법 공부

## 목차
- [함수 종류](#sparkles-함수-종류)<br>
- [조건문](#sparkles-조건문) <br>
- [옵셔널](#sparkles-옵셔널) <br>
　+ [옵셔널 바인딩](#sparkles-옵셔널-바인딩)

- [구조체](#sparkles-구조체) <br>


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
### :heavy_exclamation_mark: 옵셔널 바인딩
> 옵셔널타입은 바로 사용할 수 없음(바로 연산, 출력 불가능) 
> 3가지 방법. if let과 guard let의 뉘앙스 차이가 있다!
1. if let : 값이 있으면 가져와라
```Swift
if let testStr = optionalString {
    print("if let : "+testStr+notOptionalString)
}
```
2. guard let : 값이 없으면 실행해라.
```Swift
func test() {
    guard let testStr2 = optionalString else {
        return
    }
    print("guard let : "+testStr2+notOptionalString)
}
```
3. 강제 언랩핑
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
<br><br>
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
