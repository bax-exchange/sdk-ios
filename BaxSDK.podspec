Pod::Spec.new do |spec|
  spec.name         = "BaxSDK"
  spec.version      = "0.0.7"
  spec.summary      = "Bax SDK for iOS enables seamless integration of web-based content into your SwiftUI applications."
  spec.description  = <<-DESC
  BaxSDK provides an intuitive API for embedding web content within iOS applications, utilizing WKWebView for web rendering and SwiftUI for modern UI components. Ideal for developers looking to streamline web-based feature integration.
  DESC
  spec.homepage     = "https://www.bax.mx/"
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.author       = { "BAX BLOCKCHAIN SERVICES SA DE CV" => "sdk@bax.mx" }
  spec.platform     = :ios, "13.0"
  spec.ios.deployment_target = "13.0"
  spec.source = { :git => "https://github.com/bax-exchange/sdk-ios.git", :tag => "#{spec.version}" }
  spec.source_files = "Sources/**/*.{h,m,swift}"
  spec.frameworks    = ["UIKit", "Foundation", "WebKit"]
  spec.swift_version = '5.7'
  spec.requires_arc = true
  spec.test_spec do |test_spec|
    test_spec.source_files = "Tests/**/*.{swift}"
    test_spec.requires_arc = true
    test_spec.frameworks = ["XCTest"]
  end

end
