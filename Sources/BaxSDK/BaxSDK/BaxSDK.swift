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
        
        let webView = WebView(url: url.absoluteString, jwtToken: jwtToken) {
            self.dismissView()
        }

        if let rootViewController = UIApplication.shared.windows.first?.rootViewController {
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
