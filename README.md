# OnePatchForgeNeo

ForgeNeo をワンパン操作でインストール→即実行を目指すリポジトリ

## インストール方法

- [こちらのファイル](https://github.com/Sunao-Yoshii/OnePatchForgeNeo/raw/main/shells/ProjectInstall.bat) を右クリックから保存します。
  - NVIDIA GPU の Windows PC、20GB 以上の空きストレージ、PC の管理者権限、アバストなどの Windows Diffender でないウィルスチェック無効化、VPN の無効化が必要です。
- `C:/ForgeNeo/` 等の浅いパスの空のフォルダで `ProjectInstall.bat` をダブルクリック実行します。
  - `WindowsによってPCが保護されました` と表示されたら、`詳細表示` から `実行` します。
- インストールが終わったら、`ForgeNeo.bat` を実行します。
  - VRAM が 16GB 以上ある場合、`ForgeNeo-highSpeed.bat` を実行できる可能性があります。こちらは最適化オプション入りなので実行速度が若干早くなる可能性があります。



## 構成

ForgeNeo 環境をインストールするにあたり、複雑な手順をすべて自動化するリポジトリです。  
ディレクトリ構成は次の通りです。

- misc : 追加プラグインなどをインストールするためのフォルダ
- models : ForgeNeo で利用する各種モデル、スクリプト
- shells : 各種自動化を行うにあたり利用する　Bat/PowerShell 置き場

