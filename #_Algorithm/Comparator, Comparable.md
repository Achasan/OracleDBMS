# Comparator, Comparable 정리

보통 배열이나 컬렉션 객체에 들어있는 데이터를 오름차순, 내림차순으로 정렬하기위해서 sort() 메서드를 많이 사용할 것이다.

Arrays.sort(), Collections.sort()를 사용하면 기본적으로 오름차순으로 정렬이 된다. 하지만 정렬 기준을 보다 세부적으로 설정하거나, 기본자료형이 아닌 객체를 정렬할 경우 등 직접 기준을 세워 어떤 데이터를 기준으로 정렬할 지를 정해야하는 경우가 있다.

정렬하는 기준을 설정하기 위해서는 Comparator, Comparable 객체를 사용하여 정렬해야한다. 두 객체는 모두 인터페이스이며, 객체를 생성할 경우 추상메서드를 구현하여 사용하여야 한다.

두 객체는 정렬할 시 기준을 정하여 두 원소를 비교한다는 공통점을 가지고 있지만, 비교하는 방식에서 차이점을 보인다.

<br> <br>

## Comparator

일단 예시코드를 한번 보도록 하자.

    Arrays.sort(arr, new Comparator<String>() {

        @Override
        public int compare(String o1, String o2) {
            if(o1.length() ==  o2.length()) {
                return o1.compareTo(o2);
            }

            return o1.length() - o2.length();
        }
    });

보통 오름차순 정렬을 할 때는 Arrays.sort(arr)를 사용하여 정렬할 것이다. 여기서 두 번째 매개변수에 Comparator 익명 객체를 생성하여 compare 추상 메서드를 구현하면 원하는 정렬기준을 설정하고 이를 사용할 수 있다.

위에서는 Comparator 객체를 생성하여 사용하였다. Comparator 객체는 제네릭을 사용하여 비교하는 객체를 하나의 타입으로 제한하여 사용한다. 원래는 클래스에서 상속하여 compare 메서드를 구현하여 사용할 수있지만 익명객체를 생성하면 간단한 배열의 정렬기준에도 적용할 수 있다.

이제 compare 메서드를 알아보자. compare 메서드는 Comparator 인터페이스의 추상메서드이고, **두 객체를 비교할 때** 사용한다.

위의 코드블럭을 보면 String o1, String o2가 매개변수로 들어가게되어 두 객체를 비교한 다음 int 값을 리턴함으로써 정렬기준을 만들게 된다. compare 메서드는 int값을 리턴하여 두 객체를 비교했을 때 교환해야할지 말아야할지를 결정한다.

int 값이 음수일 경우 두 원소의 교환이 일어나지 않고, 양수일 경우 두 원소를 교환한다. 0일 때는 기본적으로 교환이 일어나지 않는다.

int 값을 리턴할 때는 -1, 0, 1로 return 하도록 설정하여 사용하는 것이 바람직하다. int 값의 범위는 -21,4748,3648 ~ +21,4748,3647 이므로, 만약 두 객체를 비교했는데 해당 값의 범위를 초과할 경우 음수, 양수가 바뀌게 되어 잘못된 정렬이 설정될 수 있다.

정리하자면 다음과 같다.

- Comparable은 compare 추상메서드를 가진 인터페이스이다. 익명객체로 만든다음 이를 구현하여 Arrays.sort() 메서드의 정렬기준을 설정할 수 있다.

- compare 메서드는 int값을 리턴한다. -1, 0 일 경우 두 비교 객체는 교환안함(default), 1일 경우에는 두 비교 객체의 교환이 일어난다.
  - 보통은 두 객체를 빼거나 더함으로써 나오는 int값을 리턴하도록 설정한다. 하지만 int값의 범위는 한정적이므로 이를 감안하여 사용하도록 하자.

<br> <br>

## Comparable

Comparable도 Comparator객체와 사용방법이 비슷하다. 다만 추상메서드로 compareTo()를 가지고 있다. compareTo() 메서드는 자기 자신과 대상 객체를 비교하게된다는 점에서 차이점을 가진다.

또한 lang 패키지에서 제공되어 import 없이 사용가능한 Comparator와 다르게 Comparable 객체는 util 패키지에서 제공되어진다.

    Arrays.sort(arr, new Comparator<String>() {

        @Override
        public int compare(String o1, String o2) {
            if(o1.length() ==  o2.length()) {
                return o1.compareTo(o2);
            }

            return o1.length() - o2.length();
        }
    });

같은 예제코드이다.

o1, o2 String 변수를 비교했을 때 길이가 같을 경우 compareTo 메서드를 사용하여 나온 int값을 리턴하도록 되어있다. 이미 String 클래스에서는 Comparable 인터페이스를 상속받고 compareTo 메서드가 구현이 되어있기 때문에 바로 사용이 가능한 것이다. compareTo는 비교할 자신과 대상객체를 작성하기 때문에 매개변수는 하나이다.

    public int compareTo(String anotherString) {
            byte v1[] = value;
            byte v2[] = anotherString.value;
            if (coder() == anotherString.coder()) {
                return isLatin1() ? StringLatin1.compareTo(v1, v2)
                                : StringUTF16.compareTo(v1, v2);
            }
            return isLatin1() ? StringLatin1.compareToUTF16(v1, v2)
                            : StringUTF16.compareToLatin1(v1, v2);
        }

String 클래스의 compareTo는 다음과 같이 구현되어있다. (참고)

알고리즘 문제를 풀 때 정렬은 어디서나 물어볼 수 있다고 생각한다. 따라서 정렬을 사용하는 인터페이스를 알아두고, 문제해결을 하기 위해 할외하는 시간을 줄이기 위해 해당 인터페이스를 정리하는 글을 작성하였다.
