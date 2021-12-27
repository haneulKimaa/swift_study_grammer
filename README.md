# :rocket: Swift 문법 공부

## 목차
[1. 함수 종류](#-:sparkles:-함수-종류)<br>
[2. 조건문](#-:sparkles:-조건문) <br>
[3. 옵셔널](#-:sparkles:-옵셔널)

--------

### :sparkles: 함수 종류
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
### :sparkles: 조건문
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
### :sparkles: 옵셔널
nil값일 수 있는 값 <br>
```Swift
var optionalString: String? = nil
var notOptionalString: String = " aloha"
print(optionalString) // nil
optionalString = "olive"
print(optionalString) // Optional("olive") -> 연산 안됨
//print(optionalString+notOptionalString) // Optional("olive") -> 오류(언랩핑 필요)
```
<br><br>
#### :heavy_exclamation_mark: 옵셔널 바인딩 : 옵셔널타입은 바로 사용할 수 없음(바로 연산, 출력 불가능) 
   3가지 방법. if let과 guard let의 뉘앙스 차이가 있다!
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
4-1. 비교연산자를 통해 값을 비교하면 자동으로 변환.
```Swift
var optionalInt: Int? = 6
if optionalInt == 6 {
    print(optionalInt)
} else {
    print(optionalInt)
}
```
<br>
4-2. 형변환시 옵셔널 사용해야하는 경우 (옵셔널 아닐 시 오류) <br>
변환할 값이 변환 후 타입과 맞지 않을 수 있기 때문

```Swift
let string: String = "12"
var stringToInt: Int! = Int(string)
// 바인딩해야 출력 가능
print(stringToInt+1)
```

#### 1 headers 헤더
