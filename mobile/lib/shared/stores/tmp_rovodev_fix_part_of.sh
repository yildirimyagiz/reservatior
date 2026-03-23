#!/bin/bash

# Fix part of directive in all store files
for file in *.dart; do
  if grep -q "part of '../abcx3_stores_library.dart';" "$file"; then
    sed -i '' "s|part of '../abcx3_stores_library.dart';|part of '../../gen_models/abcx3_stores_library.dart';|g" "$file"
  fi
done

echo "Fixed part of directives in all store files"
