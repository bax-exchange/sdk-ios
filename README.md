# BaxSDK

BaxSDK is a Swift library designed to simplify integration with the Bax platform. It offers tools to authenticate, initialize, and interact with the platform using SwiftUI and WebKit.

## Features

- Easy integration with the Bax platform.
- Simplified SDK initialization.
- WebView support for displaying Bax-based web content.
- Customizable options for token management and navigation.
---
## Requirements
- iOS 13.0+
- Swift 5.3+
- Xcode 12+
---
## Installation
### CocoaPods
Add `BaxSDK` to your `Podfile`:
```
pod 'BaxSDK'
```
Then run
```
pod install
```
--- 
## Usage
### Import the SDK
```
import BaxSDK
```
### Initializing the SDK
To initialize the SDK, use the initializeSDK function:
```
private var baxSDK = BaxSDK(environment: .sandbox)
```
The avaliable enviorements
```
public enum Environment {
    case sandbox
    case production
}
```
### Displaying a WebView with Authentication
```
import SwiftUI
import BaxSDK

struct AmountView: View {
    @State private var jwtToken: String = ""
    
    private var baxSDK = BaxSDK(environment: .sandbox)
    var body: some View {
        VStack {
            Button("Open BAX SDK") {
                baxSDK.openView(jwtToken: jwtToken)
                }.padding()
            }
        }
    }

```
