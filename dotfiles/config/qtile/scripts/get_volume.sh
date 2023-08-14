#!/bin/bash

volume=$(pamixer --get-volume-human)

printf '[%s]' $volume
