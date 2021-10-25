# 프로그래머스 코딩테스트 : 비밀지도[1차]

링크는 https://programmers.co.kr/learn/courses/30/lessons/17681

<img href="http://t1.kakaocdn.net/welcome2018/secret8.png">

문제 자체는 생각보다 간단하다. n x n 크기의 지도가 주어진다. 그리고 각 행마다 정수가 주어지는데, 정수를 2진수로 변환한 다음 각 자릿수에 1이 있으면 #, 없으면 공백으로 둔다.

두 지도를 겹쳤을 때, 두 지도 모두 공백인 자리만 공백으로 두고, 나머지는 #으로 채워주면 된다.

toBinaryString() 함수를 모르면 사용할 수 없는 문제, 여기에 String.format() 메소드까지 알고 있어야 문제의도대로 정확히 풀 수 있는 문제이다.

들어보기만했고 실제로 써 본적은 없는 함수인데, 한번 알아보자.

Integer.toBinaryString(int i) : i를 2진수로 변환하고 String타입으로 리턴한다.

일단 정수를 2진수로 바꿀 수 있어서 이번 문제의 핵심 함수이지만, 하나 더 필요하다.

Integer.toBinaryString(9) = "1001";
위의 사진에서 보다시피, 지도의 크기는 5x5이다. 근데 정수 9를 이진법으로 변환하면 1001이 나오므로, 맨 앞에 0이 들어가주어야 지도의 크기에 맞출 수 있다.

String.format("format", String s) : 문자열을 입력한 형식에 맞추어 변환한다. 형식은 여러가지가 있는데, [여기](https://blog.jiniworld.me/68)를 참조하는 것을 추천한다. 여기서 사용해야할 형식은 %s이다. %s는 Stirng 타입의 문자열의 형식을 지정할 수 있는데, %5s를 입력할 경우, String의 length는 5가 되어야하고 만약 s의 length가 5보다 작다면 남은 부분은 공백으로 채운다. 공백은 replaceAll을 사용하여 0으로 바꿔주어야 한다.

이제 코드를 보자,

    import java.util.*;

    class Solution {
        public List<String> solution(int n, int[] arr1, int[] arr2) {
            List<String> answer = new ArrayList<String>();

            String temp = "";
            for(int i=0; i<n; i++) {
                String a = String.format("%"+n+"s", Integer.toBinaryString(arr1[i]));
                String b = String.format("%"+n+"s", Integer.toBinaryString(arr2[i]));
                a = a.replaceAll(P" ", "0");
                b = b.replaceAll(" ", "0");


                for(int j=0; j<n; j++){
                    temp += (a.charAt(j) == '0' && b.charAt(j) == '0') ? " " : "#";
                }

                answer.add(temp);
                temp = "";
            }

            return answer;

        }
    }


    2중 for문을 사용하였다. arr1과 arr2에 있는 숫자를 하나씩 꺼내와서 2진수로 변환하고 공백부분을 0으로 바꿔주었다. 그리고 for문을 하나 더 생성하여 변환한 숫자의 각 자릿수가 0과 같다면 공백을, 아니면 #을 temp에 추가한 다음 완성된 행을 answer에 추가하였다.

    문제는 생각보다 어렵지 않았지만, 함수를 모르면 아예 풀 수 없는 문제였다. 이번 기회에 toBinaryString() 함수와 format 함수에 대해서 잘 알게되었고, replace와 replaceAll의 차이점에 대해서도 다시한번 상기할 수 있게 되었다.
