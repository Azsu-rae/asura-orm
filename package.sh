#!/usr/bin/env bash

mvn clean package
cp ./target/orm-1.0.jar ../EDT/lib/
