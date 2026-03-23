#!/bin/bash

# Add badCertificate case to all DioExceptionType switches
for file in property_service.dart user_service.dart; do
  if grep -q "case DioExceptionType.unknown:" "$file"; then
    # Add the badCertificate case before the unknown case
    sed -i '' '/case DioExceptionType.unknown:/i\
      case DioExceptionType.badCertificate:\
        message = '\''Invalid SSL certificate. Please check the server configuration.'\'';\
        break;
' "$file"
  fi
done

echo "Added badCertificate cases"
