#!/bin/sh

volume=$(pamixer --get-volume-human)

printf '[%s]' $volume
