#
# Be sure to run `pod lib lint PasswordStrength.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "PasswordStrength"
  s.version          = "0.1.0"
  s.summary          = "Password Strength Lib"
  s.description      = <<-DESC
                       PasswordStrength will return a value of 0 - 1 based on the strength of a password

                      This can then be used to create a colour to use with progress bars.

                       Enjoy :)
                       DESC
  s.homepage         = "https://github.com/matthewellis/PasswordStrength"
  s.license          = 'MIT'
  s.author           = { "Matthew Ellis" => "matthewellis1995@gmail.com" }
  s.source           = { :git => "https://github.com/matthewellis/PasswordStrength.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/mellis1995'

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
 
end
