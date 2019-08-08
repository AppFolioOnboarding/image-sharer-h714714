/* eslint-env mocha */

import assert from 'assert';
import { shallow } from 'enzyme';
import React from 'react';
import sinon from 'sinon';
import FeedbackForm from '../../components/FeedbackForm';
import * as api from '../../utils/helper';

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
    assert.strictEqual(wrapper.find('Input').last().prop('type'), 'textarea');
    assert.strictEqual(wrapper.find('Button').length, 1);
    assert.strictEqual(wrapper.find('Button').prop('color'), 'primary');
    assert.strictEqual(wrapper.find('Button').prop('size'), 'sm');
    assert.strictEqual(wrapper.find('Button').children().text(), 'Submit');
  });

  it('should call post when submit', () => {
    const wrapper = shallow(<FeedbackForm />);
    wrapper.instance().name = 'my name';
    wrapper.instance().comment = 'my comment';
    wrapper.update();

    const preventDefaultSpy = sinon.spy();
    const mockEvent = { preventDefault: preventDefaultSpy };

    const stub = sinon.stub(api, 'post');
    stub.resolves();
    wrapper.instance().handleSubmit(mockEvent).then(() => {
      wrapper.update();
      assert(preventDefaultSpy.calledOnce);
      assert.strictEqual(wrapper.instance().alertColor, 'success');
    });
    stub.restore();
  });

  it('should raise warning when submit invalid form', () => {
    const wrapper = shallow(<FeedbackForm />);
    wrapper.instance().comment = 'my comment';
    wrapper.update();

    const preventDefaultSpy = sinon.spy();
    const mockEvent = { preventDefault: preventDefaultSpy };

    const stub = sinon.stub(api, 'post');
    stub.rejects();
    wrapper.instance().handleSubmit(mockEvent).then(() => {
      wrapper.update();
      assert(preventDefaultSpy.calledOnce);
      assert.strictEqual(wrapper.instance().alertColor, 'danger');
    });
    stub.restore();
  });

  it('should not render Alert when alert is nil', () => {
    const wrapper = shallow(<FeedbackForm />);
    assert.strictEqual(wrapper.find('Alert').length, 0);
  });

  it('should change name when input changes', () => {
    const wrapper = shallow(<FeedbackForm />);
    const input = wrapper.find('Input').first();
    input.simulate('change', { target: { value: 'something' } });

    assert.strictEqual(wrapper.instance().name, 'something');
  });
});
