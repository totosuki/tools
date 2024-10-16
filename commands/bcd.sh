#!/bin/bash

echo "Number of times to go back : ${1}"

for i in {1..${1}}
do
  cd ../
done

