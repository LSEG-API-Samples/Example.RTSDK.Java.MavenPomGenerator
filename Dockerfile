#docker pull ruby:3.2.3-alpine3.19
ARG RUBY_VERSION=3.2.3
ARG VARIANT=alpine3.19
#FROM ruby:3.2.2-slim
FROM ruby:${RUBY_VERSION}-${VARIANT}
LABEL maintainer="Developer Relations"

# Create app directory
WORKDIR /App

# Copy everything
COPY . ./
# Install Dependencies
RUN bundle install
# Run application
ENTRYPOINT ["ruby","maven_pom_generator.rb"]
#ENTRYPOINT [ "/bin/bash" ]