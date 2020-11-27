:: Open as administrator
:: 請搭配 File Server：gofs
@echo off
:: class.conf 檔案格式，平抬 LF 一定是要 Unix 格式。
:: 下面指令說明：
:: 1、雙引號是 Linux 指令，目的在使用 SSH 連結至目標電腦
:: 2、單引號是成功遠端之後要執行的 Windows 指令

:: 若無法將 MYVHD.vhdx 成功複製到 E:\VHD\，表示目前環境的 VHD 是 E:\MYVHD\MYVHD.vhdx，後續的 bcdedit 及 shutdown 指令都不會執行。
"%PROGRAMFILES%\Git\bin\sh.exe" --login -i -c "for i in $(cat ./class.conf); do ssh chtti@$i 'curl --create-dirs --output E:\MYVHD\MYVHD.vhdx --url http://10.131.28.11/MYVHD.vhdx && bcdedit /set {current} device VHD=[E:]\MYVHD\MYVHD.vhdx && bcdedit /set {current} osdevice VHD=[E:]\MYVHD\MYVHD.vhdx && shutdown -r -t 30'; done"

:: 若無法將 MYVHD.vhdx 成功複製到 D:\VHD\，表示目前環境的 VHD 是 D:\MYVHD\MYVHD.vhdx，後續的 bcdedit 及 shutdown 指令都不會執行。
"%PROGRAMFILES%\Git\bin\sh.exe" --login -i -c "for i in $(cat ./class.conf); do ssh chtti@$i 'curl --create-dirs --output D:\MYVHD\MYVHD.vhdx --url http://10.131.28.11/MYVHD.vhdx && bcdedit /set {current} device VHD=[D:]\MYVHD\MYVHD.vhdx && bcdedit /set {current} osdevice VHD=[D:]\MYVHD\MYVHD.vhdx && shutdown -r -t 30'; done"
