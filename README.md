# Integration tests for Offender Management Allocation API & Manager 

## Setup instructions

### Running tests

    bundle install
    bundle exec rspec spec

## Test Configuration

I recommend copying `.env.example` to `.env` and using direnv to automatically load these configuration variables (`brew install direnv`).

See `.env.example` for default development configuration.

### `START_PAGE`
This should be the start page for the offender management allocation manager.

## Docker build

    docker build -t offender-management-integration .
    docker run --env-file=.env offender-management-integration
