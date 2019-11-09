#!/bin/bash

getent passwd unchanged 2>&1 >/dev/null
if [ $? -ne 0 ]; then
  useradd unchanged -c "Idempotent User"
fi
