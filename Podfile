# Uncomment this line to define a global platform for your project
# platform :ios, '9.0'

target 'tictactoe' do
  # Comment this line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for tictactoe


    post_install do |installer|
        installer.pods_project.targets.each do |target|
            target.build_configurations.each do |config|
                config.build_settings['SWIFT_VERSION'] = '3.0'
            end
        end
    end
    
    
  target 'tictactoeTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'tictactoeUITests' do
    inherit! :search_paths
    # Pods for testing
  end
  
  pod 'SAConfettiView', :git => 'https://github.com/gokhanakkurt/SAConfettiView', :branch => 'swift3'
  pod 'Spring', :git => 'https://github.com/MengTo/Spring.git', :branch => 'swift3'

end
