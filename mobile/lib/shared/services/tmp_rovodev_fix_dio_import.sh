#!/bin/bash

# Fix DioClient import path in all service files
for file in *.dart; do
  if grep -q "import '../network/dio_client.dart';" "$file"; then
    sed -i '' "s|import '../network/dio_client.dart';|import '../../core/network/dio_client.dart';|g" "$file"
  fi
done

echo "DioClient imports fixed"
