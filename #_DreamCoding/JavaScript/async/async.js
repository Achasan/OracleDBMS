// async & await
// clear style of using promise :)

// 1. async
// 함수 앞에 async 라는 키워드를 작성하면 해당 함수가 실행부에서 자동적으로 Promise 객체를 갖게 된다.
async function fetchUser() {
    // do network request in 10 secs...
    return 'ellie';
}

const user = fetchUser();
console.log(user);


// 2. await
