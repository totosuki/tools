#!/bin/bash

gcc $1 $(python3-config --includes) -l python3.11