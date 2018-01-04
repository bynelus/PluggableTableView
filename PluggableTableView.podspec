#
# Be sure to run `pod lib lint PluggableTableView.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'PluggableTableView'
  s.version          = '0.1.0'
  s.summary          = 'PluggableTableView provides a TableView to work easily with ViewModels.'

  s.description      = <<-DESC
PluggableTableView provides a tableview working with viewmodels to use for easy lists.
                       DESC

  s.homepage         = 'https://github.com/NielsKoole/PluggableTableView'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'NielsKoole' => 'me@nielskoole.nl' }
  s.source           = { :git => 'https://github.com/bynelus/PluggableTableView.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/nielskoole'
  s.ios.deployment_target = '11.0'
  s.ios.source_files = 'PluggableTableView/Classes/**/*'
end
