#!/bin/bash
echo "$0 is executing"

sudo usermod -aG docker jeff
sudo usermod -aG wireshark jeff

echo "$0 is exiting"
