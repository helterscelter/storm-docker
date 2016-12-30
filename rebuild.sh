#!/bin/bash

docker build -t="helterscelter/storm-base" --force-rm=true $*  storm-base
docker build -t="helterscelter/storm-nimbus" --force-rm=true $* storm-nimbus
docker build -t="helterscelter/storm-supervisor" --force-rm=true $* storm-supervisor
docker build -t="helterscelter/storm-ui" --force-rm=true $* storm-ui
