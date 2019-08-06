import React from 'react';
import { Form, FormGroup, Container, Row, Col, Label, Input, Button } from 'reactstrap';

export default class FeedbackForm extends React.Component {
  render() {
    return (
      <Container>
        <Row>
          <Col xs="3" />
          <Col xs="6">
            <Form>
              <FormGroup>
                <Label>Your name:</Label>
                <Input type="email" />
              </FormGroup>
              <FormGroup>
                <Label>Comments:</Label>
                <Input type="textarea" />
              </FormGroup>
            </Form>
            <Button color="primary" size="sm">Submit</Button>
          </Col>
        </Row>
      </Container>
    );
  }
}
