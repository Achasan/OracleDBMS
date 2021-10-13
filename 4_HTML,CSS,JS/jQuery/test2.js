function solution(record) {
  var answer = [];
  const data = {};
  const sentence = [];

  for (let s of record) {
    const [type, id, name] = record.split(" ");
    data[id] = name;
    const temp = [type, id];
    sentence.push(temp);
  }

  console.log(data);

  return answer;
}
