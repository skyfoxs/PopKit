Pod::Spec.new do |spec|
  
  spec.name         = "PopKit"
  spec.version      = "0.0.1"
  spec.summary      = "A short description of PopKit."

  spec.homepage     = "https://github.com/skyfoxs/PopKit"
  spec.license      = { :type => "MIT", :text => 'Copyright © 2023 Pakornpat Sinjiranon. All rights reserved.' }
  spec.author       = { "Pakornpat Sinjiranon" => "skyfox.ku@gmail.com" }
  
  spec.platform     = :ios, "16.4"
  spec.source       = { :git => "git@github.com:skyfoxs/PopKit.git", :tag => "#{spec.version}" }
  spec.source_files  = "PopKit/**/*.{swift,h,m}"
  
  # spec.exclude_files = "Classes/Exclude"
  # spec.resource  = "icon.png"
  # spec.resources = "Resources/*.png"

end
