# 20211026 TIL : 알고리즘 문제풀이

[문제 설명]

매운 것을 좋아하는 Leo는 모든 음식의 스코빌 지수를 K 이상으로 만들고 싶습니다. 모든 음식의 스코빌 지수를 K 이상으로 만들기 위해 Leo는 스코빌 지수가 가장 낮은 두 개의 음식을 아래와 같이 특별한 방법으로 섞어 새로운 음식을 만듭니다.

섞은 음식의 스코빌 지수 = 가장 맵지 않은 음식의 스코빌 지수 + (두 번째로 맵지 않은 음식의 스코빌 지수 \* 2)
Leo는 모든 음식의 스코빌 지수가 K 이상이 될 때까지 반복하여 섞습니다.
Leo가 가진 음식의 스코빌 지수를 담은 배열 scoville과 원하는 스코빌 지수 K가 주어질 때, 모든 음식의 스코빌 지수를 K 이상으로 만들기 위해 섞어야 하는 최소 횟수를 return 하도록 solution 함수를 작성해주세요.

제한 사항

- scoville의 길이는 2 이상 1,000,000 이하입니다.
- K는 0 이상 1,000,000,000 이하입니다.
- scoville의 원소는 각각 0 이상 1,000,000 이하입니다.
- 모든 음식의 스코빌 지수를 K 이상으로 만들 수 없는 경우에는 -1을 return 합니다.

[첫 번째 시도 코드]

    import java.util.*;

    class Solution {
        public int solution(int[] scoville, int K) {
            int answer = 0;
            List<Integer> list = new ArrayList<Integer>();

            for(int i=0; i<scoville.length; i++) {
                list.add(scoville[i]);
            }

            Collections.sort(list);

            while(true) {
                if(list.size() < 2) {
                    answer = -1;
                    break;
                }
                int a = list.get(0);
                int b = list.get(1);
                if(a < K) {
                    answer++;
                    int scovillize = a + (b * 2);
                    list.remove(0);
                    list.remove(0);
                    list.add(scovillize);
                    Collections.sort(list);
                } else {
                    break;
                }
            }

            return answer;
        }
    }

테스트 코드 16개 중에서 1개 틀림, 효율성 테스트 하나도 통과못함. 아무래도 sort하는 과정에서 시간을 대부분 잡아먹는거 같다는 생각이 들었다.

그래서 어떻게 해야하나 생각해보니 어차피 K보다 큰 숫자는 빼도 상관이 없지않나? 하는 생각이 들어서 K보다 큰 수는 list에서 아예 제외시키고 틀린 테스트코드를 맞추도록 다시 작성해보기로했다.

30분 동안 삽질을 해봤으나 실패했다. 테스트코드에서 계속 몇 개가 틀리는 상황이 나오고, 효율성은 계속 제로, 아무래도 sort를 벗어나기 위해서는 새로운 뭔가를 알아야할 것 같은데, 문제 유형이 Heap이더라, heap은 단순히 메모리 저장 공간 중 하나인 줄 알았는데 아니었다. 아무튼, 이 문제는 Heap을 기반으로하는 자료구조 우선순위 큐를 사용해서 문제를 풀었어야했다.

## Heap?

힙은 우선순위 큐를 위해 고안된 이진트리 형태의 자료구조이다. 최댓값, 최솟값을 구해내는 연산이 빠르다는 것이 특징. 다르다는 점은 TreeSet, TreeMap과같은 이진탐색트리와 달리 중복된 값이 허용된다는 점이다.

### 최대 힙

부모 노드의 키 값이 자식노드보다 크거나 같은 완전 이진트리
![최대힙](https://img1.daumcdn.net/thumb/R1280x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdn%2FcT2Dxb%2FbtqSATggBLA%2FCIBeKSLq0s6MDTNVM345Jk%2Fimg.png)

### 최소 힙

부모 노트의 키 값이 자식 노드보다 작거나 같은 완전 이진트리
![최소힙](https://img1.daumcdn.net/thumb/R1280x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdn%2FbwtTZl%2FbtqSASIpEE1%2FzJxtetzfI1OGHucT99Mcuk%2Fimg.png)

사실 내가 작성했던 코드가 우선순위 큐를 구현하는 과정이었다는 점을 알게되었다. 하지만 시간복잡도에서 큰 차이를 보이는데, 시간복잡도는 나중에 따로 마크다운으로 작성해야겠다.

아무튼 배열이나 List 객체는 삽입,삭제를 위한 시간복잡도가 O(n)이다. 하지만 힙 트리는 완전 이진트리구조이기 때문에 높이를 따져서 최댓값, 최솟값을 구하는게 가능하다. 따라서 힙의 시간복잡도는 O(log₂n)이다.

우선순위 큐는 이진트리구조의 힙과 FIFO인 힙을 합친 구조이다. scovile 배열에 있는 숫자들이 중요도라고 치고, 중요도가 7보다 낮은 숫자를 연산시킨다음 다시 queue에 넣고 빼는 과정을 반복하면 쉽게 문제를 풀 수 있다.

    PriorQueue<Integer> queue = new PriorityQueue<>();

최소 힙의 우선순위 큐는 위와 같이 생성,

    PriorityQueue<Integer> priorityQueue = new PriorityQueue<>(Collections.reverseOrder());

최대 힙의 우선순위큐는 파라미터에 Collections.reverseOrder() 메서드를 넣어서 생성한다.

전반적인 메서드는 queue와 같다. 다만 먼저 넣은 순서대로 나오는게 아니라 넣은 값 중 최댓값 or 최솟값부터 나온다는 점에서 다르다.

[두 번째 작성 코드]

    import java.util.*;

    class Solution {
        public int solution(int[] scoville, int K) {
            int answer = 0;
            PriorityQueue<Integer> queue = new PriorityQueue<>();

            for(int s : scoville) {
                queue.add(s);
            }

            while(queue.peek() <= K) {
                if(queue.size() == 1) {
                    answer = -1;
                    break;
                }
                int a = queue.poll();
                int b = queue.poll();
                int scovilize = a + (b*2);

                queue.add(scovilize);
                answer++;
            }
            return answer;
        }
    }

문제를 꼼꼼히 읽었어야 했는데, [모든 음식의 스코빌 지수를 K 이상으로 만들 수 없는 경우에는 -1을 return 합니다.] 이 문장을 깜빡하고 코드를 작성하고 있었다. 우선순위 큐는 당연히 작은 수가 먼저나오고, while문 조건에서 K보다 수가 클 경우에는 알아서 0이 되므로 if문으로 사이즈가 1일 경우에는 -1을 리턴하도록 했다.

이번 문제로 Heap 자료구조를 이해하게 되었고, 우선순위 큐에 대한 사용법도 알게 되었다. 점점 컬렉션 라이브러리에 익숙해져 가는 것 같다.
