#
#  Be sure to run `pod spec lint SHLocation.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |spec|

s.name         = "SHLocation"
s.version      = "1.0.0"
s.summary      = "定位管理器"
s.license      = "MIT"
s.authors      = { "CSH" => "624089195@qq.com" }
s.platform     = :ios, "8.0"
s.requires_arc = true
s.homepage     = "https://github.com/CCSH/SHLocation"
s.source       = { :git => "https://github.com/CCSH/SHLocation.git", :tag => s.version }
s.source_files = "SHLocation/*.{h,m}"

end
