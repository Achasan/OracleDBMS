function solution(record) {
  var answer = [];
  var data = [];

  for (let r of record) {
    const datar = r.split(" ");
    switch (datar[0]) {
      case "Enter":
        data.push(datar);
      case "Leave":
        data.forEach((value) => {
          if (datar[1] === value[1]) {
            datar[1] = value[2];
          }
        });
      case "Change":
        data.forEach((value) => {
          if (datar[1] === value[1]) {
            value[2] = datar[2];
          }
        });
    }
  }

  for (let s of data) {
    switch (s[0]) {
      case "Enter":
        answer.push(`${s[2]}님이 들어왔습니다.`);
      case "Leave":
        answer.push(`${s[1]}님이 나갔습니다.`);
    }
  }
  return answer;
}

const input = [
  "Enter uid1234 Muzi",
  "Enter uid4567 Prodo",
  "Leave uid1234",
  "Enter uid1234 Prodo",
  "Change uid4567 Ryan",
];

solution(input);
