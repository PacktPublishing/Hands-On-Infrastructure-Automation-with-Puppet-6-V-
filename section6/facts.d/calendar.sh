#!/bin/bash

echo "---"
echo "google:"
echo "  www: $(getent hosts www.google.com |head -1 |cut -d' ' -f1)"
echo "  mail: $(getent hosts mail.google.com |head -1 |cut -d' ' -f1)"
echo "  calendar: $(getent hosts calendar.google.com |head -1 |cut -d' ' -f1)"
