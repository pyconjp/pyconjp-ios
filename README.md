##PyCon JPのガイド用iOSアプリ

###SwiftLintを導入推奨
https://github.com/realm/SwiftLint


###ライブラリはCocoaPodsで管理しています   
https://cocoapods.org

CocoaPodsはBundlerで管理しています  
http://bundler.io

####Bundlerのインストール

```
$ (sudo) gem install bundler
```

####CocoaPodsのインストール

```
$ bundle install #Gemfileがあるディレクトリで
```

####CocoaPods管理のライブラリをインストール

```
$ bundle exec pod install  #Podfileがあるディレクトリで
```

####CocoaPods管理のライブラリをアップデート

```
$ bundle exec pod update #Podfileがあるディレクトリで
```

もしくは

```
$ ./cleanCocoapod.sh
```

`PyConJP2016.xcworkspace` を開く


###ステージングAPIのURL、basic認証
APIのURL、basic認証のユーザー名、パスワードはSchemeの環境変数を参照しています  
ステージングへの接続は、以下の設定をしてください (本番環境へは、設定せずに接続できます)

1. `New Scheme` から新しいSchemeを作成 (非共有設定、git管理にしない)
2. `Edit Scheme` > `Run` > `Arguments` > `Enviroment Variables` に以下を追加  
    * APIBaseURL
    * APIAuthUser
    * APIAuthPassword
 
