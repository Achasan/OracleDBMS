
// 1. make a string out of an array
const fruits1 = ['apple', 'banana', 'orange'];
console.log(fruits1.join());


// 2. make an array out of a string
const fruits2 = '🍎, 🥝, 🍌, 🍒';
console.log(fruits2.split(', '));
// split(separator, index) : 문자열에 있는 문자를 기준으로 문자열을 쪼개 배열로 만듦.
//  index는 separator를 통해 쪼갠 문자열 중에 몇 번째까지만 배열에 포함시킬지를 정함(optional).


// 3. make this array look like this: 5, 4, 3, 2, 1
const numbers = [5, 4, 3, 2, 1];
console.log(numbers.reverse());
// reverse() : 원본 배열 자체의 items를 거꾸로 바꿔버린다.


// 4. make new aray without the first two elements
{
    const array = [1, 2, 3, 4, 5];
    const array_slice = array.slice(2);
    console.log(array_slice);
}
// splice(startIndex, endIndex) : startIndex 부터 endIndex의 전까지 item을 없앤다.
// splice는 원본 배열에 있는 items들을 삭제한다. item을 없앤 배열을 생성하기 위해서는 slice()를 사용해야한다.
// slice()는 splice와 parametor가 반대이다. 시작index와 끝index를 적으면 그 사이에 있는 item으로 구성된 배열을 생성한다.



class Student {
    constructor(name, age, enrolled, score) {
      this.name = name;
      this.age = age;
      this.enrolled = enrolled;
      this.score = score;
    }
  }

  const students = [
    new Student('A', 29, true, 45),
    new Student('B', 28, false, 80),
    new Student('C', 30, true, 90),
    new Student('D', 40, false, 66),
    new Student('E', 18, true, 88),
  ];

// 5. find a student with the score 90
// const findStu = [];
// students.forEach((a) => {
//     if(a.score === 90){
//         findStu.push(a);
//     }
// });
// console.log(findStu);

const findStu = students.find((item) => item.score === 90);
console.log(findStu);
// find() : 배열 안에 있는 데이터의 값을 찾는다. 매개값으로는 콜백함수를 작성하여 해당 함수를 통해
//              true 값을 리턴하는 데이터값이 있으면 그 데이터를 리턴한다.

// 6. make an array of enrolled students
// const enrollStu = [];
// students.forEach((a) => {
//     if(a.enrolled){
//         enrollStu.push(a);
//     }
// });
// console.log(enrollStu);

const enrolledStudents = students.filter((student) => student.enrolled);
console.log(enrolledStudents);

// 7. make an array containing only the students' scores
//      result should be : 45 80 90 66 88
// const studentsArr = [];
// for(let s of students){
//     studentsArr.push(s.score);
// }
// console.log(studentsArr);

const scoreArr = students.map((a) => a.score);
console.log(scoreArr);

// map() : 배열안에 있는 데이터의 값들을 각각 매핑한다. 예를 들어 배열 안에 [1, 2, 3]이 있다고 했을 때,
//            [1, 2, 3].map((item) => item * 2); 코드를 입력하게되면 [2, 4, 6]으로 배열값들이 바뀌는 식이다.

// 8. check if there is a student with the score lower than 50
const filtered = students.filter((a) => a.score < 50);
console.log(filtered);

// 9. compute students' average score
// let sum = 0;
// for(let a of studentsArr){
//     sum += a;
// }
// console.log(sum / studentsArr.length)
const average = students.reduce((a, b) => a + b.score, 0) / students.length;
console.log(average);
// reduce(a, b) :  b는 초기값을 의미한다. a는 콜백함수를 넣는다. 콜백함수를 통해 배열에 있는 모든 item 값을 
//                  더해서 누적된 값을 리턴한다.

// 10. make a string containing all the scores 
//      result should be: '45, 80, 90, 66, 88'
console.log(students.map((a) => a.score).join(', '));

// // Bonus : do Q10 sorted in ascending order
// //      result should be: '45, 66, 80, 88, 90'
console.log(students.map((a) => a.score).sort().join(', '));

