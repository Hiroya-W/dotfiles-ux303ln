#!/bin/bash

cat ~/Documents/notes.txt | sed 's/^/ \${color #ddddff}x  \$color /g'
