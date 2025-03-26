# deploy-tag-buildkite-plugin

Applies a unique tag per environment to deployed images. Use with lifecycle rules to prevent in-use images being deleted.

## Example

Add the following to your `pipeline.yml`:

```yml
steps:
  - command: ls
    plugins:
      - cultureamp/deploy-tag#v1.0.0:
          image-ref: "full-image-name-and-tag"
```

## Configuration

### `image-ref` (Required, string)

The full name of the image to tag, including the registry, repository and tag.

## Developing

To run the tests:

```shell
docker-compose run --rm tests
```
