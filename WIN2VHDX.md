# 將 Windows 10 安裝至 VHDX 內

1. 先到微軟官網將最新 win10 iso 下載下來
https://www.microsoft.com/zh-tw/software-download/windows10

2. 第一步 先使用 Win 10 內建的磁碟管理工具建置 VHDX
要注意虛擬硬碟大小不要超過目前磁碟大小【可用空間】的 1/2
這邊將這個 VHDX 掛載為 Q: 槽
VHD 放在 D:\MYVHD\MYVHD.vhdx 內

3. 這邊將 Win10 ISO 檔按滑鼠右鍵掛載在 H:

4. 現在要將 H: 的資料塞到 Q:（用 ISO 安裝 Win 10 至 VHDX）
以下使用系統管理員權限執行 CMD

```powershell
> cmd
> Dism /Apply-Image /ImageFile:"H:\sources\install.esd" /index:1 /ApplyDir:Q:\
```

先等他跑完 Win10 就安裝好在 VHDX 檔內了

5. 新增開機選單，以下一樣使用系統管理員權限執行 CMD

```powershell
> cmd
> bcdedit /enum
> bcdedit /copy {current} /d "MYVHD"
```

出現的 identifier 每個人不一樣，這邊是使用
{f5271ab7-94c1-11ea-9a2a-d37dc47c9f8e}

```powershell
> cmd
> bcdedit /set {f5271ab7-94c1-11ea-9a2a-d37dc47c9f8e} device "vhd=[D:]\MYVHD\MYVHD.vhdx"
> bcdedit /set {f5271ab7-94c1-11ea-9a2a-d37dc47c9f8e} osdevice "vhd=[D:]\MYVHD\MYVHD.vhdx"
```

6. 必要的其他設置：

```powershell
> cmd
> :: 將此 VHDX 設定為第一開機順位
> bcdedit /default {f5271ab7-94c1-11ea-9a2a-d37dc47c9f8e}
> :: 將開機選單出現時間設置為 1 秒
> bcdedit /timeout 1
```
7. 若您想要更改此 VHDX 在開機選單顯示的描述，可以輸入以下指令：

```powershell
> cmd
> bcdedit /set {f5271ab7-94c1-11ea-9a2a-d37dc47c9f8e} description "Windows 10 CHTTI"
```

8. 後記：
- 如果這個開機選單不再需要使用了，可以將它從開機選單中刪掉

```powershell
> cmd
> bcdedit /delete {f5271ab7-94c1-11ea-9a2a-d37dc47c9f8e}
```

- 註：若需使用 Windows 開機媒體修復開機磁區，可以在使用開機媒體開機後按下熱鍵呼叫 CMD

```console
Shift + F10
```

