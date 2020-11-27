# diy-mass-deployment
 土炮型大量部署電腦，以教室環境為例

## Requirement
1. 您需要先[製作安裝在 VHDX 內的 Windows](./WIN2VHDX.md)
2. 進到上述的 VHDX 內的 Windows 之後，需要[安裝好 SSH for Windows + 免密碼](./WINSSH_NOPASS.md)、以及安裝好 [Git for Windows](https://git-scm.com/)
3. （一次性作業）將教室內欲部署的所有電腦，均複製一份上述的 VHDX 檔（含 SSH 免密碼 + 安裝好 Git），並將之設定為第一優先開機順序
4. 您需要建置一檔案伺服器，好讓被部署的電腦，可以到主控端下載新版本的 VHDX 檔，建議您使用 [Golang File Server](https://github.com/oneleo/gofs)

## How to use
1. 這裡的【主控台】IP 為 10.131.28.11
2. 在【主控台】開啟 gofs，確定可透過瀏覽器下載新版本的 VHDX 檔，這邊以 http://10.131.28.11/MYVHD.vhdx 為例
3. 在 class.conf 放置您欲部署的目標電腦 IP
4. 執行 class.cmd 檔