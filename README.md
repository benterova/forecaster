# Forecaster

A basic application that allows users to enter their zip code, and get a forecast including the current temperature, high and low for a given date range.

Forecasts are daily, and are stored in cache based on zip code for 30 minutes. There is an indicator when the forecast results are being pulled from cache.

## Introduction

Based on the requirements of this application, we don't need to interact with the database. Instead, we use a service, facade, and presenter pattern to encapsulate logic for accessing the api, considering the cache, and preparing data for the view layer, respectively.


## Usage

- Requires Ruby 3.3.5

First, create the file `master.key` in `app/config` and place `da5cd8aad01fe6e522908e43fc941977` within it. Run `bundle install` to install dependencies, then start the application with `bin/dev`.

## DEV NOTES

This is a submission for my Senior Ruby on Rails Engineer application. There are certain considerations that would be made if this were an application of scale, including several third-party integrations, so intead of implementing them for demo purposes I thought it'd be more useful to document them here.

There are a few things missing from this repository that I would be a higher priority if this application were intended to be scaled and shared across multiple developers:

**Access Logging**:

- There is a way for us to reduce throughput by storing the amount of times a zip code has been searched for and increasing the cache duration for these zip codes to reduce cache misses.

**Testing:**

- In an application where forecasting is the main function of the application, I would use a tool such as FactoryBot or other deterministic ways to enure data has the correct form and values for a given geocoded request.
- Instead of testing live endpoints during the test suite, in a production application I would likely mock out expected responses using a tool like WebMock

**Pre-fetching**:

- With knowledge on zip code access frequency, we have an opportunity to use jobs to pre-fetch and cache forecast data for highly requested zipcodes and timeframes

**Rate Limiting**:

- If this were a production application, there is ample opporunity for abuse due to lacking rate limits for searching forecasts. If this app were to scale, it's likely we'd want to consider the amount of requests made from a single IP to mitigate simple abuse.

**UI Management**:

- A non-consideration for Rails prior to 7.0, but it appears that ViewComponents are being accepted as the Rails solution to the "component dillema" that plagues managing partials as of 8.0 and propelled by GitHub, as a response to React-like patterns. Seeing as this is the future, we'd want a new application to be forward-looking to what these future defaults hold.

**Developer-Friendliness**:

- In most of my Rails applications, I tend to use VScode's Devcontainers to ensure a consistent environment across development machines; simplifires troubleshooting for commonly encountered issues. Other container-based approaches like docker-compose or podman are equally suitable. The primary objective with this approach is to quickly integrate new developers while reducing the chances of experienced devs spending time troubleshooting environment-specific onboarding issues.

**Security**:

- I would never put the credential keys in the Github README. But it's also the most convenient method for this application with nothing security related besides a URL to share it with the folks administrating my assessment.
- Credentials would typically be separated by environment, with a `production.key`, `staging.key` and `development.key` for each of the keys needed to run the application without compromising security.
