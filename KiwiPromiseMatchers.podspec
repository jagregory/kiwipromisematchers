Pod::Spec.new do |s|
  s.name         = "KiwiPromiseMatchers"
  s.version      = "0.0.1"
  s.summary      = "A collection of RXPromise matchers for Kiwi specs"
  s.description  = <<-DESC
                   RXPromise matchers for Kiwi specs.

                   * Make it easier to assert on promises, without having to write
                     your own then blocks to capture results.
                   * Assert on resolved, fulfilled, rejected, and cancelled states of promises.
                   * Capture the value of a promise for normal assertions
                   DESC

  s.homepage     = "https://github.com/jagregory/kiwipromisematchers"
  s.license = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "James Gregory" => "james@jagregory.com" }
  s.social_media_url   = "http://twitter.com/jagregory"
  s.ios.deployment_target = "5.1"
  s.osx.deployment_target = "10.8"
  s.source = { :git => "https://github.com/jagregory/kiwipromisematchers.git", :tag => "0.0.1" }
  s.default_subspec = 'SenTestingKit'
  s.requires_arc = true

  s.subspec 'SenTestingKit' do |sentest|
    sentest.requires_arc = true
    sentest.framework = 'SenTestingKit'
    sentest.source_files = "*.{h,m}"
    sentest.dependency 'Kiwi/SenTestingKit', '~>2.2.3'
    sentest.dependency 'RXPromise'
  end

  s.subspec 'XCTest' do |xctest|
    xctest.requires_arc = true
    xctest.framework = 'SenTestingKit'
    xctest.source_files = "*.{h,m}"
    xctest.dependency 'Kiwi/XCTest', '~>2.2.3'
    xctest.dependency 'RXPromise'
  end
end
