THING_ID="$(openssl rand -hex 8)"

TOKEN="$(knot-cloud create-token april2@jnt.com test1234 --server bt.fog --port 80 --token a --protocol http | jq '.token')"

echo "Running commands"

echo "Generating user token"

knot-cloud create-thing $THING_ID $THING_ID --server broker.fog --port 5672 --token $TOKEN --protocol amqp

echo "Updating schema"

knot-cloud update-schema $THING_ID --server broker.fog --port 5672 --token $TOKEN --protocol amqp

echo "Updating data"

knot-cloud set-data $THING_ID 0 true --server broker.fog --port 5672 --token $TOKEN --protocol amqp

echo "Requesting data"

knot-cloud get-data $THING_ID 0 --server broker.fog --port 5672 --token $TOKEN --protocol amqp

echo "Obtaining registered things"

knot-cloud list-things --server broker.fog --port 5672 --token $TOKEN --protocol amqp

echo "Publishing data as thing"

knot-cloud publish-data $THING_ID 0 true --server broker.fog --port 5672 --token $TOKEN --protocol amqp

echo "Removing thing"

knot-cloud delete-thing $THING_ID --server broker.fog --port 5672 --token $TOKEN --protocol amqp