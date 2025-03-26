#!/usr/bin/env bats

setup() {
  load "$BATS_PLUGIN_PATH/load.bash"

  # Uncomment to enable stub debugging
  # export GIT_STUB_DEBUG=/dev/tty
}

@test "Fails when image-ref not provided" {
  run "$PWD/hooks/command"

  assert_failure
  assert_output --partial "Missing required parameter: 'image-ref'"
}

@test "Fails when STEP_ENVIRONMENT is undefined" {
  export BUILDKITE_PLUGIN_DEPLOY_TAG_IMAGE_REF="image-ref"

  run "$PWD/hooks/command"

  assert_failure
  assert_output --partial "Missing environment variable: 'STEP_ENVIRONMENT'"
}

@test "When image and environment are provided, it applies a tag to a remote image" {
  export BUILDKITE_PLUGIN_DEPLOY_TAG_IMAGE_REF="image-ref"
  export STEP_ENVIRONMENT="testenv"

  stub crane \
    ':: echo stubbed crane $@'

  run "$PWD/hooks/command"

  assert_success
  assert_line --partial "stubbed crane tag image-ref deployed-testenv"

  unstub crane
}

@test "When image, environment and farm are provided, it applies a tag to a remote image" {
  export BUILDKITE_PLUGIN_DEPLOY_TAG_IMAGE_REF="image-ref"
  export STEP_ENVIRONMENT="testenv"
  export FARM="testfarm"

  stub crane \
    ':: echo stubbed crane $@'

  run "$PWD/hooks/command"

  assert_success
  assert_line --partial "stubbed crane tag image-ref deployed-testenv-testfarm"

  unstub crane
}
