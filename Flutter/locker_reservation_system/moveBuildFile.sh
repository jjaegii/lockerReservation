#!/bin/bash

echo "-----빌드 시작------"
flutter build web
echo "-----빌드 완료------"
echo "-----파일 옮기기 시작-----"
rm -rf ../../Django/flutter_web_app/*
cp -r build/web/* ../../Django/flutter_web_app
echo "-----파일 옮기기 완료------"
