/* eslint-env mocha */

import assert from 'assert';
import { shallow } from 'enzyme';
import React from 'react';
import FeedbackForm from '../../components/FeedbackForm';

describe('<FeedbackForm />', () => {
  it('should render correctly', () => {
    const wrapper = shallow(<FeedbackForm />);
    assert.strictEqual(wrapper.find('Container').length, 1);
    assert.strictEqual(wrapper.find('Row').length, 1);
    assert.strictEqual(wrapper.find('Col').length, 2);
    assert.strictEqual(wrapper.find('Col').first().prop('xs'), '3');
    assert.strictEqual(wrapper.find('Col').last().prop('xs'), '6');
    assert.strictEqual(wrapper.find('Form').length, 1);
    assert.strictEqual(wrapper.find('FormGroup').length, 2);
    assert.strictEqual(wrapper.find('Label').length, 2);
    assert.strictEqual(wrapper.find('Label').first().children().text(), 'Your name:');
    assert.strictEqual(wrapper.find('Label').last().children().text(), 'Comments:');
    assert.strictEqual(wrapper.find('Input').length, 2);
    assert.strictEqual(wrapper.find('Input').first().prop('type'), 'email');
    assert.strictEqual(wrapper.find('Input').last().prop('type'), 'textarea');
    assert.strictEqual(wrapper.find('Button').length, 1);
    assert.strictEqual(wrapper.find('Button').prop('color'), 'primary');
    assert.strictEqual(wrapper.find('Button').prop('size'), 'sm');
    assert.strictEqual(wrapper.find('Button').children().text(), 'Submit');
  });
});
