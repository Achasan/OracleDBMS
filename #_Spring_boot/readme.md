# 스프링 부트 로드맵 인강 정리 리포지토리

인프런 로드맵 : 김영한의 스프링 완전 정복 [링크](https://www.inflearn.com/roadmaps/373)

<br> <br>

## Spring Boot 로드맵의 전체적인 흐름 강의

[2021.10.16 ~ 2021.10.18]

강의 로드맵을 수강하기 전 스프링 프레임워크에서 배워야하는 핵심 개념들을 코딩을 통해 훑어보는 무료강의
컴포넌트의 개념부터 AOP까지 자바 스프링을 통해 알아야하는 중요한 개념들이 어떤 것이 있는지 알 수 있었다.
물론 스프링을 아예 처음 접했고, 무엇보다 디자인 패턴이라는 개념을 처음 눈으로 보았기 때문에 이게 무슨 코드인지 처음에
이해가 아예되지 않았다. 반복적으로 코드를 직접 타이핑해보니 어느정도 감은 잡힌 것 같다. 

스프링은 나온지가 오래되기도 했고 생태계가 워낙 방대하다보니 공부하다가 지칠 수 있을 것 같아서 인터넷강의를 신청했는데
좋은 이정표가 될 것 같다. 열심히 들어봐야겠다.

- 수강하며 정리한 내용
  - [컴포넌트 스캔으로 자동 빈 등록, 수동 빈 등록](https://github.com/Achasan/Study/blob/main/%23_Spring_boot/%23_Spring_boot_basic/20211015.md)
  - [스프링 프레임워크의 핵심개념 전체적인 흐름 정리](https://github.com/Achasan/Study/blob/main/%23_Spring_boot/%23_Spring_boot_basic/20211017.md)

<br>

## Spring Boot Basic

[2021.10.19 ~ 2021.10.29]

스프링에서 어떤 기술들을 배우고, 흐름이 어떤식으로 흘러가는지는 대충 안 것 같다. 이제 구체적으로 스프링에 대해서 기초적인 부분들을 수강하려고 한다.
[강의링크는여기](https://www.inflearn.com/course/%EC%8A%A4%ED%94%84%EB%A7%81-%EC%9E%85%EB%AC%B8-%EC%8A%A4%ED%94%84%EB%A7%81%EB%B6%80%ED%8A%B8#)

스프링도 스프링이지만 OOP에 대해서 자세하게 배울수 있는 기회가 될 것 같아서 강의를 결제했다. 자바 API를 공부하면서 이 객체가 '왜' 필요한지, 이 메소드는 어떤 상황에서 써야하는지, 이런 객체들과 메소드를 가지고 도대체 어떻게 코드를 작성해야 효율적이고, 가독성이 좋은 코드가 되는건지를 알고싶었는데, 이 강의를 통해서 그 궁금증이 해소되었으면 하는 바램이다.

2021.10.29 - 스프링에서 사용하는 핵심적인 개념에 대해서 알 수 있었다. 의존관계를 주입하는 다양한 방법, 빈 자동등록, 수동 등록, lombok을 통해 생성자 코드를 안써서 효율성 높이기, 빈 생명주기, 스코프의 범위와 프록시 객체를 이용하여 컨테이너에서 새로운 객체 가져오기들을 배웠다.

- 해당 강의를 통해 정리한 내용
  - [스프링이 등장하게 된 배경, 객체지향 설계 5원칙(SOLID)](https://github.com/Achasan/Study/blob/main/%23_Spring_boot/%23_Spring_boot_basic/20211019.md)
  - [스프링 컨테이너에 등록된 빈 조회, XML 설정, 싱글턴 패턴, 컴포넌트 스캔과 의존관계 자동 주입](https://github.com/Achasan/Study/blob/main/%23_Spring_boot/%23_Spring_boot_basic/20211024.md)
  - [컴포넌트 스캔과 의존관계 자동 주입(어노테이션)](https://github.com/Achasan/Study/blob/main/%23_Spring_boot/%23_Spring_boot_basic/20211028_1.md)
    - @Component, @Controller, @Service, @Repository, @Configuration 의 각 역할, 수동 빈 등록과 자동 빈 등록의 충돌 등
  - [다양한 의존관계 주입 방법(4가지)](https://github.com/Achasan/Study/blob/main/%23_Spring_boot/%23_Spring_boot_basic/20211028_2.md)
    - 생성자 주입, 수정자 주입(Setter), 필드 주입, 일반 메서드 주입 : 각 주입방법 별 장/단점 정리 => 생성자 주입 권장
  - [Gradle을 사용하여 lombok 라이브러리 추가하기](https://github.com/Achasan/Study/blob/main/%23_Spring_boot/%23_Spring_boot_basic/20211028_3.md)
  - [추상체에 주입하려는 구현체(빈)가 여러 개 일 때](https://github.com/Achasan/Study/blob/main/%23_Spring_boot/%23_Spring_boot_basic/20211028_4.md)
    - @Autowired에 필드명 선언, @Qualifier, @Primary로 하나의 추상체에 여러 구현체를 사용할 경우 처리방법
  - [조회한 빈이 모두 필요할 때: List, Map을 사용](https://github.com/Achasan/Study/blob/main/%23_Spring_boot/%23_Spring_boot_basic/20211028_5.md)
  - [빈 생명주기](https://github.com/Achasan/Study/blob/main/%23_Spring_boot/%23_Spring_boot_basic/20211028_6.md)
    - 빈이 초기화되거나, 생명주기가 끝날 때 메서드를 호출하는 방법
  - [빈 스코프](https://github.com/Achasan/Study/blob/main/%23_Spring_boot/%23_Spring_boot_basic/20211029.md)

<br> <br>

## 모든 개발자를 위한 HTTP 웹 기본 지식

[2021.10.29 ~]

본격적인 MVC를 배우기 전에 클라이언트와 서버 간에 요청과 응답이 어떤 절차를 통해 이루어지는 지에 대해서 자세히 알 수 있는 강의.

웹 개발을 한다면 알아야하는 필수적인 TCP/IP, 3 ways handshake, HTTP 메시지의 전반적인 구조, REST API에 대해 보다 자세히 알 수 있는 강의였다.

이전부터 REST API에 대해서 공부해야겠다는 생각은 꾸준히 가지고 있었다. 근데 이 강의를 통해서 알게 될 줄은 몰랐는데, 이전에 배웠던 스프링보다 더 좋은 강의인 것 같다. 

국비학원에서는 Servlet에있는 service 메서드만 사용했었다. 새로운 비즈니스 로직을 짜려면 URI를 새롭게 생성해주어야해서 다른 방법이 없나 생각하고 있었는데 같은 URI더라도 GET방식이냐 POST 방식이냐에 따라서 비즈니스로직을 다르게 수행할 수가 있어서 프로젝트 때 꼭 응용해보아야 할 것 같다.

- 해당 강의를 통해 정리한 내용
  - [IP 프로토콜, TCP/UDP의 정의, 특성, Port, DNS](https://github.com/Achasan/Study/blob/main/%23_Spring_boot/%23_HTTP_Basic/20211029_1.md)
  - [URI/URL/URN 정의, 웹 브라우저 요청 전체적인 흐름](https://github.com/Achasan/Study/blob/main/%23_Spring_boot/%23_HTTP_Basic/20211029_2.md)
  - [전체적인 HTTP 개념](https://github.com/Achasan/Study/blob/main/%23_Spring_boot/%23_HTTP_Basic/20211031.md)
    - HTTP의 역사, 특징, **Stateless, Stateful**, 비연결성, HTTP 메시지, 요청/응답 메시지 구조, HTTP 헤더/메시지 바디
  - [HTTP API 설계(RESTAPI)](https://github.com/Achasan/Study/blob/main/%23_Spring_boot/%23_HTTP_Basic/20211101_1.md)
  - [HTTP 상태코드, PRG](https://github.com/Achasan/Study/blob/main/%23_Spring_boot/%23_HTTP_Basic/20211101_2.md)
  - [HTTP 헤더의 자세히 살펴보기(협상, 우선순위)](https://github.com/Achasan/Study/blob/main/%23_Spring_boot/%23_HTTP_Basic/20211102_1.md)
  - [쿠키의 전반적인 개념](https://github.com/Achasan/Study/blob/main/%23_Spring_boot/%23_HTTP_Basic/20211102_2.md)
  - [캐시 전반적인 개념](https://github.com/Achasan/Study/blob/main/%23_Spring_boot/%23_HTTP_Basic/20211102_3.md)

