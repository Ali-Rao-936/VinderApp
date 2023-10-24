# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'VinderApp' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for VinderApp
	pod 'Alamofire', '4.0'
	pod 'MBProgressHUD'
  pod 'SDWebImage'
  pod 'NVActivityIndicatorView'
  pod 'SwiftyJSON'
  pod 'TagListView', '~> 1.0'
  pod 'LocationPicker'
  pod "Koloda"
  pod 'JJFloatingActionButton'

  target 'VinderAppTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'VinderAppUITests' do
    # Pods for testing
  end

end

post_install do |installer|
    installer.generated_projects.each do |project|
        project.targets.each do |target|
            target.build_configurations.each do |config|
                config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'

            end
        end
    end
end

