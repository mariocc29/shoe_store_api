# Shoe Store Inventory Monitoring System API
**Potloc Test Ruby backend**

### Overview

This system is designed to enable the inventory department to monitor Aldo's stores and shoe inventory in real-time. It collects inventory data from store events and provides functionalities for data visualization.

## Features
* Real-time Monitoring: Receive real-time updates on inventory levels for each store and shoe model.
* Event Broadcasting: Broadcast events to the frontend when a new shoe model or store is created, as well as when inventory events occur.
* Data Storage: Store inventory data in a relational database to maintain historical records.
* RESTful API: Access inventory data via a RESTful JSON API for integration with other systems.
* Alerting System: Receive alerts when inventory levels go beyond defined thresholds.

## Technologies

The following technologies are used in this project:

||Version|Command for checking
|-|-:|-|
|ruby|3.2.3|ruby --version|
|rails|7.1.3.2|rails --version|
|postgresql|16.2-1.pgdg120+2|postgres --version|

## Deployment

1. **WebSocket Server**: Install websocketd for capturing inventory events.

**[Download for Linux, OS X and Windows](https://github.com/joewalnes/websocketd/wiki/Download-and-install)**

2. **Ruby Dependencies**: Install required gems using Bundler:

```bash
bundle install
```

3. **Database Setup**: Set up the PostgreSQL database and run migrations:

```bash
rails db:create
rails db:migrate
```

4. **Start WebSocket Server**: Run the WebSocket server to listen for inventory events:

```bash
bin/websocketd --port=8080 ruby websocket/inventory.rb
```
5. **Start Rails Server**: Start the Rails server to provide RESTful API endpoints:

```bash
bin/rails server
```

6. **Start Sidekiq**: Run Sidekiq to process background jobs:

```bash
bundle exec sidekiq
```

7. **Run WebSocketWorker**: Start the Rails console and execute the WebSocketWorker to connect with the WebSocket server:

```bash
bin/rails console
```
```ruby
WebSocketWorker.perform_async
```

## API Reference

To access the API documentation, perform the following steps:

1. Retrieve the documentation:

```bash
curl  -X GET \
  'localhost:3000/api/docs' \
  --header 'Accept: */*'
```

2. Copy the content and visualize it using [Swagger Editor](https://editor.swagger.io/)

## Running Tests

Execute the following command to run the tests:

```bash
   bundle exec rspec spec/
```

## Solution Approach

In the shoe store project, the following approach was implemented to fulfill the requirements and enhance the inventory monitoring system:

1. **Choosing the Framework:** We opted to use the Grape framework for building our RESTful API. Grape provides a lightweight and flexible approach to define API endpoints and manage request handling.

2. **Documentation Generation:** We integrate Grape Swagger and Grape Swagger Entity to automatically generate Swagger-compliant documentation for our API. This ensures that our API endpoints are well-documented and easy to explore.

3. **Testing Strategy:** We employ RSpec and related gems for behavior-driven development (BDD) and testing. RSpec Rails provides a robust framework for testing Rails applications, while Rack Test allows us to test Rack applications with a simple API. Additionally, we use RSpec JSON Expectations for validating JSON responses in our tests.

4. **Code Quality:** To maintain code quality and adherence to best practices, we utilize RuboCop, a linter for Ruby code. RuboCop helps us enforce consistent coding styles and identify potential issues in our codebase.

5. **Service Objects:** Developed three service objects: Store, Model, and Inventory. These service objects are responsible for handling the business logic related to inventory management.

6. **Job Implementation:** In the shoe store project, a job named WebSocketJob was implemented to process WebSocket messages and store inventory information. This job is responsible for persisting inventory data received from WebSocket messages into the database and broadcasting real-time inventory updates to connected clients.

## Future Enhancements
* Implement additional anomaly detection algorithms to detect more complex inventory patterns.
* Integrate anomaly detection with TensorFlow for predictive inventory management.
  * Implement additional anomaly detection algorithms using machine learning models built with TensorFlow in Python.
  * Compile the model using the Adam optimizer and Mean Squared Error (MSE) loss function for optimal performance.
  * Adam Optimizer: Adam is an optimization algorithm used in training machine learning models. It combines concepts from both the momentum and RMSProp methods to calculate adaptive learning rates for each parameter of the model, making it efficient and effective across a wide range of problems.
  * Mean Squared Error (MSE) Loss Function: The Mean Squared Error loss function is a commonly used metric in regression problems in machine learning. It calculates the average squared difference between the model's predictions and the actual values, helping to assess how close the model's predictions are to the training data.