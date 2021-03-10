#!/bin/bash
cd ~/Downloads
JNLPFILE=`ls -Art *.jnlp | tail -n 1`
echo "Launching: $JNLPFILE"
javaws "$JNLPFILE"
