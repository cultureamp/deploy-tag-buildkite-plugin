# deploy-tag-buildkite-plugin

Applies a unique tag per environment to deployed images. Use with lifecycle rules to prevent in-use images being deleted.

## Example

Add the following to your `pipeline.yml`:

```yml
steps:
  - label: ":docker: [${STEP_ENVIRONMENT}/${FARM}] Tag deployed image"
    agents:
      queue: $BUILD_AGENT
    env:
      FARM: $FARM
      STEP_ENVIRONMENT: $STEP_ENVIRONMENT
    plugins:
      - cultureamp/aws-assume-role:
          role: $BUILD_ROLE
      - cultureamp/deploy-tag#v1.0.0:
          image-ref: "full-image-name-and-tag"
```

## Configuration

Important: this plugin assumes that it has access to ECR for pulling and pushing
images.

`STEP_ENVIRONMENT` is required to be set in the environment and will be used
when generating the tag for the image. The `FARM` variable is optional and will
also be used if available.

### `image-ref` (Required, string)

The full name of the image to tag, including the registry, repository and tag.

Example: `"${ECR_REPO}:release-${BUILDKITE_BUILD_NUMBER}"`.

## Developing

To run the tests:

```shell
docker-compose run --rm tests
```
