import React from "react";
import PropTypes from "prop-types";

// props.title = { title }
// props.id = { id } 몇시간 삽질하는거냐..
function Movies({ key, title, year, rating, runtime, poster, summary }) {
  return (
    <div class="movies__movie">
      <img src={poster} alt={title} title={title} />
      <div class="movie__data">
        <h3 class="movie__title">{title}</h3>
        <h5 class="movie__year">{year}</h5>
        <p class="movie__summary">{summary.slice(0, 200)}...</p>
      </div>
    </div>
  );
}

Movies.propTypes = {
  id: PropTypes.number.isRequired,
  title: PropTypes.string.isRequired,
  year: PropTypes.number.isRequired,
  rating: PropTypes.number.isRequired,
  runtime: PropTypes.number.isRequired,
  poster: PropTypes.string.isRequired,
  summary: PropTypes.string.isRequired,
};

export default Movies;
