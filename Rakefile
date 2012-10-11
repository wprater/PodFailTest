# -*- coding: utf-8 -*-
$:.unshift("/Library/RubyMotion/lib")
require 'motion/project'
require 'motion-cocoapods'

Motion::Project::App.setup do |app|
  # Use `rake config' to see complete project settings.
  app.name = 'PodFailTest'

  app.info_plist['ELAWSS3Bucket'] = 'eventlab-dev'

  app.pods do
    pod 'AFS3Client', podspec: 'vendor/AFS3Client.podspec'
  end

end
