import XCTest
import WebKit
@testable import BaxSDK

// Mock WKWebView to track URL load attempts
class MockWKWebView: WKWebView {
    var didLoadURLRequest: Bool = false
    var lastLoadedURL: URL?

    override func load(_ request: URLRequest) -> WKNavigation? {
        didLoadURLRequest = true
        lastLoadedURL = request.url
        return nil
    }
}

class WebViewTests: XCTestCase {
    
    // Test if WebView loads a valid URL
    func testWebViewLoadsValidURL() {
        let validURLString = "https://www.bax.mx/"
        let jwtTokenString = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJPbmxpbmUgSldUIEJ1aWxkZXIiLCJpYXQiOjE3MzA4MzIxODEsImV4cCI6MTc5MzkwNDE4MSwiYXVkIjoid3d3LmV4YW1wbGUuY29tIiwic3ViIjoidXNlckBzYW1wbGUuY29tIiwiR2l2ZW5OYW1lIjoiU2FtcGxlIiwiU3VybmFtZSI6IlVzZXIiLCJFbWFpbCI6InVzZXJAc2FtcGxlLmNvbSIsIlJvbGUiOlsiTWFuYWdlciIsIlByb2plY3QgQWRtaW5pc3RyYXRvciJdfQ.yV0JE0oK_CRmHtwAB-CkyxM-AlNs3qD1QLNoyrEN0Hg"
        let webViewHandler = WebView(url: validURLString, jwtToken: jwtTokenString)
        let mockWebView = MockWKWebView()
        webViewHandler.loadWebView(mockWebView)

        XCTAssertTrue(mockWebView.didLoadURLRequest, "WebView should attempt to load a valid URL.")
        XCTAssertEqual(mockWebView.lastLoadedURL?.absoluteString, validURLString)
    }

    // Test if WebView handles invalid URL properly (not crashing or loading)
    func testWebViewHandlesInvalidURL() {
        let invalidURLString = "invalid_url"
        let jwtTokenString = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJPbmxpbmUgSldUIEJ1aWxkZXIiLCJpYXQiOjE3MzA4MzIxODEsImV4cCI6MTc5MzkwNDE4MSwiYXVkIjoid3d3LmV4YW1wbGUuY29tIiwic3ViIjoidXNlckBzYW1wbGUuY29tIiwiR2l2ZW5OYW1lIjoiU2FtcGxlIiwiU3VybmFtZSI6IlVzZXIiLCJFbWFpbCI6InVzZXJAc2FtcGxlLmNvbSIsIlJvbGUiOlsiTWFuYWdlciIsIlByb2plY3QgQWRtaW5pc3RyYXRvciJdfQ.yV0JE0oK_CRmHtwAB-CkyxM-AlNs3qD1QLNoyrEN0Hg"
        let webViewHandler = WebView(url: invalidURLString, jwtToken: jwtTokenString)
        let mockWebView = MockWKWebView()
        webViewHandler.loadWebView(mockWebView)

        XCTAssertFalse(mockWebView.didLoadURLRequest, "WebView should not attempt to load an invalid URL.")
        XCTAssertNil(mockWebView.lastLoadedURL, "WebView should not have a valid URL to load.")
    }
}
