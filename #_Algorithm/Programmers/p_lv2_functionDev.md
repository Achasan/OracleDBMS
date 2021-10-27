# 20211025 알고리즘 문제풀이

레벨2 : 기능개발 [링크](https://programmers.co.kr/learn/courses/30/lessons/42586)

[문제설명]

프로그래머스 팀에서는 기능 개선 작업을 수행 중입니다. 각 기능은 진도가 100%일 때 서비스에 반영할 수 있습니다.

또, 각 기능의 개발속도는 모두 다르기 때문에 뒤에 있는 기능이 앞에 있는 기능보다 먼저 개발될 수 있고, 이때 뒤에 있는 기능은 앞에 있는 기능이 배포될 때 함께 배포됩니다.

먼저 배포되어야 하는 순서대로 작업의 진도가 적힌 정수 배열 progresses와 각 작업의 개발 속도가 적힌 정수 배열 speeds가 주어질 때 각 배포마다 몇 개의 기능이 배포되는지를 return 하도록 solution 함수를 완성하세요.

[제한 사항]

작업의 개수(progresses, speeds배열의 길이)는 100개 이하입니다.
작업 진도는 100 미만의 자연수입니다.
작업 속도는 100 이하의 자연수입니다.
배포는 하루에 한 번만 할 수 있으며, 하루의 끝에 이루어진다고 가정합니다. 예를 들어 진도율이 95%인 작업의 개발 속도가 하루에 4%라면 배포는 2일 뒤에 이루어집니다.

[작성한 코드]

    import java.util.*;

    class Solution {
        public List<Integer> solution(int[] progresses, int[] speeds) {
            List<Integer> answer = new ArrayList<Integer>();
            
            Queue<Integer> queue = new LinkedList<Integer>();
            
            for(int i=0; i<progresses.length; i++) {
                int day = 100 - progresses[i];
                if(day % speeds[i] == 0) {
                    queue.add(day / speeds[i]);
                } else {
                    queue.add(day / speeds[i] + 1);
                }
            }
            
            int max = 0;
            int count = 0;
            while(!queue.isEmpty()) {
                if(max == 0) {
                    max = queue.poll();
                    count++;
                    continue;
                }
                
                int number = queue.poll();
                if(number <= max) {
                    count++;
                } else {
                    answer.add(count);
                    count = 1;
                    max = number; 
                }
            }
            answer.add(count);
            return answer;
        }
    }


순서도를 작성한 다음 코드를 작성하니 생각이 정리되면서 코드 작성에만 집중이 가능했다. 레벨2부터는 순서도를 작성하는게 시간을 줄이는데 큰 도움이 될 것 같다. 습관을 들여야 겠다.

100에서 progresses를 빼고 speeds로 나눴을 때 나머지가 있으면 +1을 해주어야하는데 그 과정을 생략하고 코드를 작성해서 계속 틀렸었다. 여기서 삽질을 많이 했는데, 역시 문제를 제대로 읽어봐야겠다는 생각이든다.

while문에서는 마지막 배포개수가 포함되지 않아서 마지막 줄에 answer.add(count)를 추가했다. 계속 자릿수가 하나 씩 부족했었는데, 한 줄 추가하니 정답으로 나왔다.

처음으로 구글링하지않고 풀어본 문제라서 기분이 좋다. 이대로 3레벨 까지 정진해야겠다.