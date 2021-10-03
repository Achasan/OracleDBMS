// 1. use strict
// added in ES 5
// use this for Vanila Javascript.
'use strict';

// 2. variable
// let (added in ES6)

// var hoisting (변수를 선언한 순서에 상관없이 변수를 끌어올려져 사용되는 것)
// var는 block scope를 철저히 무시하여 사용된다.

const calculator = (command, a, b) => {
    if(command === 'add') return a + b;
    if(command === 'substract') return a - b;
    if(command === 'divide') return a / b;
    if(command === 'multiply') return a * b;
    if(command === 'remainder') return a % b;
    if(command === 'super') return a ** b;
};

const add = 'add';

document.querySelector('div').textContent = calculator('substract', 10, 2);