# 20211027 : 백준 알고리즘 문제풀이

10989번 : 수 정렬하기 [문제 링크](https://www.acmicpc.net/problem/10989)

## 문제

N개의 수가 주어졌을 때, 이를 오름차순으로 정렬하는 프로그램을 작성하시오.

## 입력

첫째 줄에 수의 개수 N(1 ≤ N ≤ 10,000,000)이 주어진다. 둘째 줄부터 N개의 줄에는 수가 주어진다. 이 수는 10,000보다 작거나 같은 자연수이다.

## 출력

첫째 줄부터 N개의 줄에 오름차순으로 정렬한 결과를 한 줄에 하나씩 출력한다.

## 조건

Java : 3초, 메모리 512MB

[첫 번째 코드] - 시간초과

    import java.io.BufferedReader;
    import java.io.IOException;
    import java.io.InputStreamReader;
    import java.util.PriorityQueue;

    public class Main {
        public static void main(String[] args) throws NumberFormatException, IOException {
            BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
            PriorityQueue<Integer> queue = new PriorityQueue<Integer>();
            int num = Integer.parseInt(br.readLine());

            for(int i=0; i<num; i++) {
                queue.add(Integer.parseInt(br.readLine()));
            }

            for(int i=0; i<num; i++) {
                System.out.println(queue.poll());
            }
        }
    }

저번에 배운 최대힙으로 문제를 풀어보려 했다. 하지만 입력하는 수가 많아질 수록 처리하는데 시간이 오래걸리는지 시간초과가 뜬다.. 다른 정렬방식을 알아봐야겠다고 생각했는데, 문제 소개에 Counting sort를 사용하여 문제를 풀어야된다는 문구가 있었다.

## Counting Sort(계수 정렬)

Counting sort는 정렬 알고리즘의 하나로, '수의 범위에 조건이 잇는 경우' 빠르게 정렬이 가능한 정렬방식이다. 시간복잡도가 O(N)이니, 조건만 충족한다면 웬만한 정렬알고리즘보다 빠르다.

위의 문제를 보면 수는 10,000보다 작거나 같은 자연수라고 써져있다. 수의 범위에 조건이 걸려있으므로 Counting sort를 사용하기 아주 좋은 문제이다.

Counting Sort는 크기를 기준으로 갯수를 세서 수를 정렬한다. 사용방법은 다음과 같다.

1. 수의 범위 만큼의 index를 가진 배열을 생성한다, 여기서는 arr이라고 칭한다.

2. arr의 길이만큼 루프문을 돌린다. 그리고 배열에 있는 value마다 일치하는 index에 1씩 카운팅한다. 여기서 주의할 점은 배열 index는 0부터 시작하므로 arr[i-1]에 카운트를 해줘야한다.

3. 카운팅한 배열을 다시 한번 for문으로 돌린다. 0이면 continue, 0이 아닐경우 for문을 한번 더 돌려줘서 출력해준다.

출력할 때 syso로 하지않고 Stringbuilder 객체를 생성해서 append를 해주었다.

<br>
Counting sort를 공부할 때 참조한 링크이다.

[안경잡이개발자-나동빈님블로그](https://blog.naver.com/ndb796/221228361368) : 계수정렬에대한 전반적인 설명

[Counting Sort Visualization](https://www.cs.usfca.edu/~galles/visualization/CountingSort.html) : Counting sort 알고리즘을 애니메이션으로 보여줌

[두 번째 코드]

    import java.io.BufferedReader;
    import java.io.IOException;
    import java.io.InputStreamReader;

    public class Main {
        public static void main(String[] args) throws NumberFormatException, IOException {
            BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
            StringBuilder sb = new StringBuilder();

            int max = Integer.parseInt(br.readLine());

            int[] arr = new int[10000];

            for(int i=0; i<max; i++) {
                int num = Integer.parseInt(br.readLine());
                arr[num - 1]++;
            }

            for(int i=0; i<arr.length; i++) {
                if(arr[i] == 0) continue;
                for(int j=0; j<arr[i]; j++) {
                    sb.append(i+1).append("\n");
                }
            }
            System.out.println(sb);

        }

    }

for문을 돌릴 때 i의 최대값을 얼마나 해줄지를 잘 정해야한다. 처음에 작성하다가 헷갈려서 왜 틀리나 했었다. Counting sort만 알면 비교적 간단한 문제였다. 간단하면서도 강력한 알고리즘을 하나 더 알게 되었다. Counting sort는 입력받는 수의 범위가 정해져 있을 때 사용하는 알고리즘이라는 것을 알아두자.
