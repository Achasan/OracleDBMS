// JSON
// JavaScript Object Notation

// 1. Object to JSON
// stringify(object, (key, value)=>{}) : JSON 인터페이스에 있는 정적 메소드이다. 자바스크립트에서 생성한 오브젝트나 데이터를
//                 JSON 파일의 규격에 맞게 매핑하는 함수이다.
//                 오브젝트에 있는 함수, 심볼(Symbol), undefined는 JSON으로 매핑시 포함되지 않는다. 이 점은 유의해야할 사항
//                 또한 매핑시 key와 value에 쌍따옴표가 붙여지게 되는 점이 특징이다. 숫자는 숫자 그대로 출력된다.
//                 JSON은 대부분의 언어에서 사용가능한 확장성을 가지고 있다는 점이 최대장점이라 볼 수 있다.
//                 매개값으로는 오브젝트와 콜백함수를 지정하면 되는데, 콜백함수의 매개값으로는 key와 value를 부여하여 사용할 수 있다.(optional)
//                 두 번째 매개값으로 콜백함수를 통해 JSON으로 변환시킬 때 오브젝트에 있는 데이터를 가공해야할 경우가 있을 때 콜백함수를 사용하면 된다.
let json = JSON.stringify(true);
console.log(typeof json); // true : string

class rabbit {

    name;
    gender;
    canJump;

    constructor(name, gender, canJump){
        this.name = name;
        this.gender = gender;
        this.canJump = canJump;
    }

    jump() {
        console.log(`${this.name} can jump!`);
    }
}

json = new rabbit('rabbit', 'male', true);
json = JSON.stringify(json, (key, value) => {
    return key === 'name' ? 'toki' : value;
});
console.log(json)


// 2. JSON to Object : parse(object, (key, value) => {})
//      JSON 파일을 다시 오브젝트로 불러오는 함수는 parse() 함수를 사용하면 된다. 사용방식은 stringfy와 동일하다.
//      JSON 파일로 변환할 때 함수가 포함되지 않았으므로 Object로 parse 할때도 당연히 함수는 로드되지 않는다.

const obj = JSON.parse(json);
console.log(obj);



let room = {
    number: 23
  };
  
  let meetup = {
    title: "Conference",
    occupiedBy: [{name: "John"}, {name: "Alice"}],
    place: room
  };
  
  // 순환 참조
  room.occupiedBy = meetup;
  meetup.self = meetup;
  
  console.log(JSON.stringify(meetup, function replacer(key, value) {
    return (key != "" && value == meetup) ? undefined : value;
  }));
  
  /* 얼럿창엔 아래와 같은 결과가 출력되어야 합니다.
  {
    "title":"Conference",
    "occupiedBy":[{"name":"John"},{"name":"Alice"}],
    "place":{"number":23}
  }
  */