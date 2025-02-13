#!/usr/bin/env bash

read -p "Enter domain value: " dm
curl "127.0.0.1:8000/reg/realms?r=${dm}.babblevoice.com" | jq
