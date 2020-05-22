# knot-stack-dev


## Deploy stack

1. Bring services up:

    `docker stack deploy --compose-file base.yml -c dev.yml knot-fog`

## Create tokens

1. Install [KNoT Cloud CLI](https://github.com/netoax/knot-cloud/tree/devel_migration_cli).


1. Create a new user in the Cloud:

    `knot-cloud create-user test@luigi.com mario --server api.knot.cloud --protocol https`

1. Generate a token for that user:

    `knot-cloud create-token test@luigi.com mario --server api.knot.cloud --protocol https`

    Example:
    ```text
    eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE1OTAxODc2NjgsImlhdCI6MTU5MDE1MTY2OCwiaXNzIjoibWFpbmZsdXguYXV0aG4iLCJzdWIiOiJ0ZXN0QGx1aWdpLmNvbSIsInR5cGUiOjB9.32l25MAjHpcwc3SzJXLxgsZ-BPKa4AeyhyccbbsLuCE
    ```

Please, repeate the same process for the Fog. You just need to update the parameters `server` and `protocol` to `api.fog` (or whatever you configured in `/etc/hosts`) and `http`.


## Configure services with generated tokens

### Thingd

1. Update the `devices.conf` with the user token.

### Connector

1. Firstly, update the [environment variable file](./env.d/knot-connector.env) and update the `token` property of `CLOUD_SETTINGS` value with the **cloud** user's token. Lastly, update the `FOG_USER_TOKEN` variable with the **fog** user's token.


## Deploy thingd and connector

1. Add connector to the stack:

    `docker stack deploy -c connector.yml knot-fog`

1. Add thingd to the stack:

    `docker stack deploy -c thingd.yml knot-fog`

## Verify services

1. List services and check if they're scaled 1/1.

    `docker service ls`