##PyCon JPのガイド用iOSアプリ

ライブラリはCocoaPodsで管理しています   
https://cocoapods.org

CocoaPodsはBundlerで管理しています  
http://bundler.io

###Bundlerのインストール

```
$ (sudo) gem install bundler
```

###CocoaPodsのインストール

```
$ bundle install #Gemfileがあるディレクトリで
```

###CocoaPods管理のライブラリをインストール

```
$ bundle exec pod install  #Podfileがあるディレクトリで
```

###CocoaPods管理のライブラリをアップデート

```
$ bundle exec pod update #Podfileがあるディレクトリで
```

もしくは

```
$ ./cleanCocoapod.sh
```

`PyConJP2016.xcworkspace` を開く
