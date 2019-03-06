#!/bin/bash
set -euo pipefail
set -o posix

service_url="https://$(aws elbv2 describe-load-balancers | jq -r '.LoadBalancers[] | select(.LoadBalancerName=="weather-service-lb") | .DNSName')"
sed -i '' "s#weather_service_url: .*#weather_service_url: \"$service_url\"#g" _config.yml
