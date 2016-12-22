#!/bin/sh
docker run --rm -i -t --link stormdocker_nimbus_1:nimbus --network stormdocker_default  -p 22 storm-base /bin/bash
