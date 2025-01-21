//
//  WebView.swift
//
//

import SwiftUI
import WebKit

public struct WebView: UIViewRepresentable {
    public let url: String
    public let jwtToken: String
    public var onDismiss: (() -> Void)?

    public init(url: String, jwtToken: String, onDismiss: (() -> Void)? = nil) {
        self.url = url
        self.jwtToken = jwtToken
        self.onDismiss = onDismiss
    }

    public func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.navigationDelegate = context.coordinator        
        webView.scrollView.delegate = context.coordinator
        
        return webView
    }

    public func updateUIView(_ uiView: WKWebView, context: Context) {
        loadWebView(uiView)
    }
    
    func loadWebView(_ uiView: WKWebView) {
        guard let validURL = URL(string: url), validURL.scheme != nil, validURL.host != nil else {
            print("Invalid URL")
            return
        }
        var request = URLRequest(url: validURL)
        request.setValue("\(jwtToken)", forHTTPHeaderField: "Authorization")
        
        uiView.load(request)
    }

    public func makeCoordinator() -> WebViewCoordinator {
        return WebViewCoordinator(onDismiss: onDismiss)
    }
}

public class WebViewCoordinator: NSObject, WKNavigationDelegate, UIScrollViewDelegate {
    private var onDismiss: (() -> Void)?

    init(onDismiss: (() -> Void)?) {
        self.onDismiss = onDismiss
    }

    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y < 0 {
            return
        }
        
        if scrollView.contentOffset.y > 100 {
            onDismiss?()
        }
    }

    public func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        print("Error loading page: \(error.localizedDescription)")
    }

    public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("Page loaded successfully")
    }
}
