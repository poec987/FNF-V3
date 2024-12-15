del /f /s /q "./export/release/windows/bin/*"
rmdir /s /q "./export/release/windows/bin/"
del /f /s /q "./export/debug/windows/bin/*"
rmdir /s /q "./export/debug/windows/bin/"
git pull
lime test windows -debug