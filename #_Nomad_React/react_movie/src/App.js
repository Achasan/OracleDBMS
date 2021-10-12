import React from "react";
import axios from "axios";
import Movies from "./Movies";
import "./App.css";

// import PropTypes from "prop-types";

// setState 함수를 호출하면 react는 자동으로 render function를 호출하여 component를 refresh한다.
// JS는 객체 중괄호인지, 함수 중괄호인지 구분하지 못한다. 객체 중괄호일 경우에는 바깥에 소괄호를 묶어
// 객체 중괄호임을 표시하자.
// current는 state 객체를 의미한다. state 객체안에 count 변수를 설정하도록 작성
// componentDidUpdate() : component의 props or state가 update 되었을 때 실행되는 함수
// 여기에서는 setState 함수가 실행될 때 자동으로 render 함수가 호출되면서 state에 있는 count 속성값이 변경되므로
// componentDidUpdate() 함수가 실행되게 된다.

class App extends React.Component {
  render() {
    const { isLoading, movies } = this.state;
    // React는 변화가 있는 부분만 골라서 값을 변경한다. The number is는 변경되지않음 React의 장점
    return (
      <section class="container">
        {isLoading ? (
          <div class="loader">
            <span class="loader__text">Loading...</span>
          </div>
        ) : (
          <div class="movies">
            {movies.map((index) => (
              <Movies
                key={index.id}
                title={index.title}
                year={index.year}
                rating={index.rating}
                runtime={index.runtime}
                poster={index.medium_cover_image}
                summary={index.summary}
              />
            ))}
          </div>
        )}
      </section>
    );
  }

  getMovies = async () => {
    const {
      data: {
        data: { movies },
      },
    } = await axios.get(
      "https://yts-proxy.nomadcoders1.now.sh/list_movies.json?sort_by=rating"
    );
    this.setState({ movies, isLoading: false });
  };

  // component Life Cycle : component가 생성되고
  // componentDidMount() : component가 render 되었을 경우에 실행되는 함수이다.
  componentDidMount() {
    this.getMovies();
  }

  state = {
    isLoading: true,
  };
}

export default App;
