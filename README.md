# Code Corps API

![Code Corps Phoenix Logo](https://d3pgew4wbk2vb1.cloudfront.net/images/github/code-corps-api.png)

[![CircleCI](https://circleci.com/gh/code-corps/code-corps-api.svg?style=shield)](https://circleci.com/gh/code-corps/code-corps-api) [![Inline docs](http://inch-ci.org/github/code-corps/code-corps-api.svg?branch=develop)](http://inch-ci.org/github/code-corps/code-corps-api) [![Coverage Status](https://coveralls.io/repos/github/code-corps/code-corps-api/badge.svg?branch=develop)](https://coveralls.io/github/code-corps/code-corps-api?branch=develop) [![Deps Status](https://beta.hexfaktor.org/badge/prod/github/code-corps/code-corps-api.svg)](https://beta.hexfaktor.org/github/code-corps/code-corps-api) [![Deps Status](https://beta.hexfaktor.org/badge/all/github/code-corps/code-corps-api.svg)](https://beta.hexfaktor.org/github/code-corps/code-corps-api) [![Slack Status](http://slack.codecorps.org/badge.svg)](http://slack.codecorps.org)

This is the [Elixir](http://elixir-lang.org/) and [Phoenix](http://www.phoenixframework.org/) backend API for [codecorps.org](https://www.codecorps.org).

Code Corps is an open source platform for building and funding public software with massive social impact.

Our goals:

- **Connect people** - Match developers and designers, project managers and marketers – any and every talent – to ambitious projects that need their help.
- **Provide support** - Educate and train, develop and encourage people who build public software. Help projects be successful and people to do their best work.
- **Fund projects** - Crowdfund ongoing work and keep funders engaged in projects and connected to the teams they're supporting.
- **Develop new tools** - Help people collaborate on, organize, and even distribute their work. Listen closely to hear what needs built, and then build it.

## How can I help?

We'd love to have you contribute to Code Corps directly!

- First, read the guidelines in our [`CONTRIBUTING.md`](https://github.com/code-corps/code-corps-api/blob/develop/.github/CONTRIBUTING.md).
- Then check out some GitHub issues to see where you can help out.

You can also always come :wave: hello [in our Slack](http://slack.codecorps.org), where there are always a ton of us around to help you learn, debug, or just shoot the breeze.

We highlight everyone who's contributed to [the Code Corps team page](https://www.codecorps.org/team). If we've missed you for some reason, please [open an issue in the Ember app](https://github.com/code-corps/code-corps-ember/issues/new)!

**At the moment, our focus is integration with Stripe**, so if you want to help, that would be the most useful spot. Check our [Donations milestone](https://github.com/code-corps/code-corps-api/blob/develop/milestone/1) to see which parts we need help on. Of course, help with other areas is always welcome, so if that sort of thing isn't your cup of tea, feel free to pick anything else.

## Installing with Docker

To make your life easier, you can just clone this repository and use our Docker container. [Follow this guide to get started.](https://github.com/code-corps/code-corps-api/blob/develop/docs/INSTALLING.md)

## Usage

Have everything installed and ready to work? Read [our usage guides](USAGE.md) to learn how to:

- [Run normal `mix` commands through Docker](USAGE.md#interacting-with-the-app)
- [Stop and start the server](USAGE.md#stopping-and-starting-the-server)
- [Run tests](USAGE.md#running-tests)
- [Linting and Style Guidelines](USAGE.md#linting-code-with-credo)
- [Rebuild Docker containers](USAGE.md#rebuilding-docker-containers)
- [Work with the Ember front-end](USAGE.md#serving-ember)
- [Set up environment variables](USAGE.md#environment)
- [Push changes to GitHub](USAGE.md#pushing-changes)

## Documentation

We have several types of docs:

- Project documentation (README, CONTRIBUTING, etc.)
- [API documentation](http://docs.codecorpsapi.apiary.io/) written in [API Blueprint](https://apiblueprint.org/) format in [`blueprint/api.apib`](https://github.com/code-corps/code-corps-api/blob/develop/blueprint/api.apib) and published to the web when merging into `develop`
- [Inline documentation](https://code-corps.github.io/code-corps-api-github-pages) for the Elixir app generated by [`ex_doc`](https://github.com/elixir-lang/ex_doc) and published to GitHub pages when merging into `develop`

Want to improve the documentation? [Get started here.](https://github.com/code-corps/code-corps-api/blob/develop/.github/CONTRIBUTING.md#what-kind-of-documentation-are-you-writing)

## Things we care about

Our values for this project reflect the Code Corps values as a whole, though with some minor differences.

We care about:

- Each other :raised_hands:
- Social impact :earth_africa:
- Good documentation :memo:
- Testing :microscope:
- Welcoming and teaching new contributors :wave:
- Writing small, clear, and achievable issues :dart:

We also track quantifiable metrics like inline documentation coverage, testing coverage, and so on. You can see some of these metrics in the icons at the top of this page.
