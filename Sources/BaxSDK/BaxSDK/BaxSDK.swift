//
//  BaxSDK.swift
//
//

import Foundation
import SwiftUI
import WebKit

public enum Environment {
    case sandbox
    case production
}

public class BaxSDK: ObservableObject {
    
    internal var environment: Environment
    internal var url: URL
    internal var hostingController: UIHostingController<WebView>?
    
    public init(environment: Environment) {
        self.environment = environment
        
        switch environment {
        case .sandbox:
            self.url = URL(string: "https://websdk.sandbox.bax.mx/view")!
        case .production:
            self.url = URL(string: "https://websdk.bax.com/view")!
        }
    }
    
    public func initializeSDK() {
        switch environment {
        case .sandbox:
            print("SDK initialized in stage mode")
        case .production:
            print("SDK initialized in production mode")
        }
    }
    
    public func openView(jwtToken: String) {
        initializeSDK()
        
        let webView = WebView(url: url.absoluteString, jwtToken: jwtToken, onDismiss: {
            self.dismissView()
            }, onJavaScriptMessage: { message in
            print("Received JavaScript message: \(message)")
            if message == "close" {
                self.dismissView()
                }
            }
        )

        if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
            let rootViewController = scene.windows.first(where: { $0.isKeyWindow })?.rootViewController {

            hostingController = UIHostingController(rootView: webView)
                    hostingController?.modalPresentationStyle = .fullScreen
            rootViewController.present(hostingController!, animated: true, completion: nil)
        }
    }
    
    public func dismissView() {
        hostingController?.dismiss(animated: true, completion: {
            self.hostingController = nil
        })
    }
}
