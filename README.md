# Covidence Code Challenge

## Overview



* Full Problem Statement: See [https://gist.github.com/ajoneil/5790a23a906e16ea08c3b0e93f380f48]
* This is a dockerised (base image Ruby 2.6.5) Ruby API (using Sinatra as a lightweight api framework), providing endpoints to:
  * list all citations (listing its id, year, title, outcome and total reviews)
    * GET http://localhost:3000/api/v1/citations
  * submit a review for a citation
    * POST http://localhost:3000/api/v1/reviews
  
## Prerequisites

* Ruby 2.6.x
* Docker (https://docs.docker.com/)
* Docker Compose (https://docs.docker.com/compose/)
  
## How to Run

* ```docker-compose build```
* ```docker-compose up```
* The server will now be running on port 3000

You can list all citations via http://localhost:3000/api/v1/citations.
You can submit a review using a POST request, for example, to submit a review for:
* Reviewer id 3
* Citation id 1
* Outcome 'yes' (anything other than 'yes' is treated as not being approved)

```curl --data "reviewer_id=3&citation_id=1&outcome=yes" http://localhost:3000/api/v1/reviews```

##How to Run Unit Tests

* Bundle exec rspec

## Assumptions

* A reviewer may only submit a review for a citation once. If a second attempt is made, an error is returned
```See citation_spec#add_review```

## Design Notes

* Sinatra has been used simply as the interface to the business logic.
  All of the concensus and classification logic is in the 'Covidence' module
  
* The Covidence::Manager is used by the controllers as the layer via which the Covidence domain objects are access (e.g. Citation, Review, Reviewer...)
  
  As such, the controllers _only_ have visibility of the Manager (not any of the underlying domain objects).
  This is intended to separate concerns ('front facing api' vs 'back end logic') --> the theory being we could swap out the API framework if desired 
  
* There is no back end database - it is currently held in memory, by loading the 241 citation sample file 'sample_241_citations.json'
* The intention is that the database layer could be swapped out by a 'real one' if desired, as the DataAccessor is injected into the Manager.
  This means that for example a 'PostgresDataAccessor' (which implements the same methods) could be injected into the manager with no other changes.
  
#### Configuration
* The minimum no. of 'yes' reviews required for a citation to be Included is configured in 'config.yaml'
* The minimum no. of reviews required for a citation have an Outcome is also in config.yaml
