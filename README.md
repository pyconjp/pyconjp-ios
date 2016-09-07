## PyCon JPのガイド用iOSアプリ

|Swift 2.x|
|:--------|
|iOS 9.0~ |

### SwiftLintを導入推奨
https://github.com/realm/SwiftLint


### ライブラリはCarthageで管理しています   
https://github.com/Carthage/Carthage

* [Alamofire](https://github.com/Alamofire/Alamofire)
* [RealmSwift](https://realm.io/docs/swift/latest/)


###ステージングAPIのURL、basic認証
APIのURL、basic認証のユーザー名、パスワードはSchemeの環境変数を参照しています  
ステージングへの接続は、以下の設定をしてください (本番環境へは、設定せずに接続できます)

1. `New Scheme` から新しいSchemeを作成 (非共有設定、git管理にしない)
2. `Edit Scheme` > `Run` > `Arguments` > `Enviroment Variables` に以下を追加  
    * APIBaseURL
    * APIAuthUser
    * APIAuthPassword
 
