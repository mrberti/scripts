#!/bin/bash
echo $1 | sed -e 's:[\ \(]:\\&:g'