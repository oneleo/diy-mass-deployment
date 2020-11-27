# 安裝好 SSH for Windows + 免密碼
 注意：若更改 Windows 使用者的密碼後，免密碼的功能將會失效

## 安裝 OpenSSH 伺服器 for Windows
- 請使用「設定 > 應用程式 > 選用功能 > 新增功能」的 Windows GUI 介面安裝 OpenSSH 伺服器、OpenSSH 用戶端，不要使用指令安裝，經測試可能會導致再也無法安裝 SSH 服務的狀況

## 確定防火牆讓 OpenSSH 透通
- 亦使用 GUI 來設置防火牆，確定「OpenSSH Server (sshd)」是啟用（允許）狀態，若使用指令設置防火牆會導致太多冗餘的防火牆政策。

## 啟動 SSH 伺服器及設定開機時自動啟動
```powershell
> Start-Service sshd
> Set-Service -Name sshd -StartupType 'Automatic'
> Get-Service sshd
```

## 測試連線
```powershell
> ssh $env:USERNAME@localhost
```

## 建立 OpenSSHUtils PowerShell 模組，以進行金鑰驗證
```powershell
> Set-Service -Name ssh-agent -StartupType 'Automatic'
> Start-Service ssh-agent
> Get-Service ssh-agent
```

## 使用者金鑰產生，均使用預設的參數
```powershell
> New-Item -Path "$ENV:USERPROFILE\.ssh" -ItemType Directory
> cd $env:USERPROFILE\.ssh
> ssh-keygen -t rsa
```

## 將私Now load your key files into ssh-agent
```powershell
> ssh-add $env:USERPROFILE\.ssh\id_rsa
```

## 部署公開金鑰（經確認，要確保權限正常，請直接手動複製 id_rsa.pub 成 authorized_keys 檔）
```powershell
> ssh $env:USERNAME@localhost mkdir $env:USERPROFILE\.ssh\
> scp $env:USERPROFILE\.ssh\id_rsa.pub $env:USERNAME@localhost:$env:USERPROFILE\.ssh\authorized_keys
```
## 備份 OpenSSH 設定檔 sshd_config
- 手動複製 C:\ProgramData\ssh\sshd_config 至 C:\ProgramData\ssh\sshd_config.bak 檔，以避免修改錯誤，還可以還原

## 查看 C:\ProgramData\ssh\sshd_config 檔案，修改／確認下方 5 條【沒有】被註解
```bash
#（必要設置）
PubkeyAuthentication yes
AuthorizedKeysFile	.ssh/authorized_keys

#（非必要設置）
PermitRootLogin no
PermitUserEnvironment yes
UseDNS no
```

## 查看 C:\ProgramData\ssh\sshd_config 檔案，修改／確認下方 2 條【有】被註解
```bash
#Match Group administrators
#       AuthorizedKeysFile __PROGRAMDATA__/ssh/administrators_authorized_keys
```

## 請建置一個【%ProgramData%\ssh\ssh_config】檔，並寫入下面一行設置，使得連線認證一律寫入 %programData%/ssh/ssh_known_hosts 不要再詢問
```bash
StrictHostKeyChecking no
```

## 備註：Windows 和 Linux 的 OpenSSH 設定檔對照表
1. OpenSSH Client 設定檔：
    - 使用者層級：Windows 的【%UserProfile%\.ssh\config】，對映到 Linux 的【~/.ssh/config】
    - 系統層級：Windows 的【%ProgramData%\ssh\ssh_config】，對映到 Linux 的【/etc/ssh/ssh_config】
2. OpenSSH Server 設定檔：
    - 只有系統層級：Windows 的【%ProgramData%\ssh\sshd_config】，對映到 Linux 的【/etc/ssh/sshd_config】

## 重啟及測試連線
```powershell
> Restart-Service sshd
> ssh $env:USERNAME@localhost
```