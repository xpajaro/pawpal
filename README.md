# README

PawPal is a rails application to recommend a pet to the user (cat or dog) based on their weight and height.

The recommendation algorithm works by:
comparing the no of cat fans and dog fans at the user's height and weight
to:
the no of cat and dog fans at similar user stats

a weighted average of the results is taken with a bias for results from the user's metrics.

the algorithm improves by taking feedback from the user and adding it to exiting records.

----------------

Pawpal is a full stack application:
- it using jquery and bootstrap frameworks for the heavy lifting in the frontend.
- it uses a REST api powered by rails in the backend.

Basic line charts are also provided using chart.js

----------------

INSTALLATION

- the dev environment uses ruby 2.3.1 and rails 5.1.4

- cd to the app folder 

  - enter 'bundle install' to install dependencies
  - populate the db using 'rake:populate' (this will empty the current data and seed the db with random values)
  - run the application by entering 'rails server'
    - navigate to localhost:3000 to test the app.
  
  - you can run tests by entering 'guard' followed by hitting return after when presented with a prompt.