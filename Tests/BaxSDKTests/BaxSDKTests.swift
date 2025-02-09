import SwiftUI
import XCTest
@testable import BaxSDK

struct MockWebView {
    var url: String
    var jwtToken: String
    var dismissAction: () -> Void

    init(url: String, jwtToken: String, dismissAction: @escaping () -> Void) {
        self.url = url
        self.jwtToken = jwtToken
        self.dismissAction = dismissAction
    }
}

class BaxSDKTests: XCTestCase {
    
    var sdk: BaxSDK!

    override func setUp() {
        super.setUp()
        sdk = BaxSDK(environment: .sandbox)
    }
    
    override func tearDown() {
        sdk = nil
        super.tearDown()
    }

    func testInitializeSDK_inSandbox() {
        let sdk = BaxSDK(environment: .sandbox)
        sdk.initializeSDK()
        XCTAssertEqual(sdk.environment, .sandbox, "The SDK should be initialized in the sandbox environment.")
    }
    
    func testInitializeSDK_inProduction() {
        let sdk = BaxSDK(environment: .production)
        sdk.initializeSDK()
        XCTAssertEqual(sdk.environment, .production, "The SDK should be initialized in the production environment.")
    }

    func testDismissView() {
        let sdk = BaxSDK(environment: .sandbox)
        sdk.openView(jwtToken: "valid_jwt_token")
        sdk.dismissView()
        XCTAssertNil(sdk.hostingController, "Hosting controller should be nil after dismissing the view.")
    }
    
    func testUrlForEnvironment() {
        let sandboxSDK = BaxSDK(environment: .sandbox)
        let productionSDK = BaxSDK(environment: .production)
        
        print("Sandbox URL: \(sandboxSDK.url.absoluteString)")
        print("Production URL: \(productionSDK.url.absoluteString)")
        
        XCTAssertEqual(sandboxSDK.url.absoluteString, "https://websdk.sandbox.bax.mx/view", "URL should be correct for sandbox environment.")
        XCTAssertEqual(productionSDK.url.absoluteString, "https://websdk.bax.com/view", "URL should be correct for production environment.")
    }
}
