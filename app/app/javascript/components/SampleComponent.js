import React from "react";
import PropTypes from "prop-types";

class SampleComponent extends React.Component {
  constructor(props) {
    super(props);

    this.state = {
      name: "John Doe"
    };
  }

  componentDidMount() {
  }

  render () {
    return (
      <>
        Name: {this.state.name}
      </>
    );
  }
}

SampleComponent.propTypes = {
  name: PropTypes.string
};
export default SampleComponent
