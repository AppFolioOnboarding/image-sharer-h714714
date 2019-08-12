import React from 'react';
import Header from './Header';
import Footer from './Footer';
import FeedbackForm from './FeedbackForm';

export default class App extends React.Component {
  render() {
    return (
      <div>
        <Header title="Tell us what you think" />
        <FeedbackForm />
        <Footer />
      </div>
    );
  }
}

/* TODO: Add Prop Types check*/
