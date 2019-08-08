import React from 'react';
import { Alert, Button, Col, Container, Form, FormGroup, Input, Label, Row } from 'reactstrap';
import { observer } from 'mobx-react';
import { observable } from 'mobx';
import * as api from '../utils/helper';

@observer
export default class FeedbackForm extends React.Component {
  @observable name = '';
  @observable comment = '';
  @observable alert = '';
  @observable alertColor;


  handleSubmit = (e) => {
    e.preventDefault();
    return api.post('/api/feedbacks', { feedback: { name: this.name, comment: this.comment } }).then(() => {
      this.name = '';
      this.comment = '';
      this.alert = 'Submit successfully !';
      this.alertColor = 'success';
    }).catch(() => {
      this.alert = 'A name and a comment is required !';
      this.alertColor = 'danger';
    });
  }


  render() {
    return (
      <Container>
        <Row>
          <Col xs='3' />
          <Col xs='6'>
            <Form onSubmit={this.handleSubmit} >
              { this.alert && <Alert color={this.alertColor}>{this.alert}</Alert> }
              <FormGroup>
                <Label>Your name:</Label>
                <Input value={this.name} onChange={(e) => { this.name = e.target.value; }} />
              </FormGroup>
              <FormGroup>
                <Label>Comments:</Label>
                <Input type="textarea" value={this.comment} onChange={(e) => { this.comment = e.target.value; }} />
              </FormGroup>
              <Button color="primary" size="sm">Submit</Button>
            </Form>
          </Col>
        </Row>
      </Container>
    );
  }
}
