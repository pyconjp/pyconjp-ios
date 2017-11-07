![](PyConJP/Assets.xcassets/AppIcon.appiconset/1024x1024.jpg)

# PyCon JP Official Guile App [![GitHub license](https://img.shields.io/badge/license-MIT-lightgrey.svg)](https://raw.githubusercontent.com/pyconjp/pyconjp-ios/develop/LICENSE) 

* Swift 4.x
* Xcode 9.x
* iOS 9.0~

## Required

### fastlane
https://docs.fastlane.tools

```sh
$gem install bundler
$bundle install --path vendor/bundle
$bundle exec fastlane init
```

### Libraries are managed by Carthage  
https://github.com/Carthage/Carthage

```sh
$brew install carthage
$carthage update --platform iOS
```

#### Acknowledgements 🎉  
* [APIKit](https://github.com/ishkawa/APIKit)
* [Result](https://github.com/antitypical/Result)
* [Kingfisher](https://github.com/onevcat/Kingfisher)
* [RealmSwift](https://realm.io/docs/swift/latest/)
* [SpreadsheetView](https://github.com/kishikawakatsumi/SpreadsheetView)

## Optional

### Using the SwiftLint recommended
https://github.com/realm/SwiftLint

```sh
$brew install swiftlint
```

### The URL and Basic authentication on Staging server
**Staging credentials are secret in PyCon JP staff**  
The URL, the user name of the basic authentication, and the password refer to the environment variable of Scheme  
For connection to staging, make the following settings  
(You can connect to the production environment without setting it)

1. Create `New Scheme` (Non sharing, Do not include in git)
2. Add the folloeing items to `Edit Scheme` > `Run` > `Arguments` > `Enviroment Variables`
    * APIBaseURL
    * APIAuthUser
    * APIAuthPassword

## License
[pyconjp-ios](https://github.com/pyconjp/pyconjp-ios) is released under the [MIT License](LICENSE.md).


