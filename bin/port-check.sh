#!/usr/bin/env bash

lsof -i -P -n | grep LISTEN | grep $1
