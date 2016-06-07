Pod::Spec.new do |spec|
  spec.name         = 'CrashReporter'
  spec.version      = '1.0.0'
  spec.license      = { :type => 'MIT' }
  spec.homepage     = 'https://github.com/Nandaballabh/CrashReporter.git'
  spec.authors      = { 'Nanda Ballabh' => 'nandaballabh.kec08@gmail.com' }
  spec.summary      = 'This is sample code for enabling the popup after crash in iosapplication to ask user to send logs to development team'
  spec.source       = { :git => 'https://github.com/Nandaballabh/CrashReporter.git'}
  spec.source_files = 'NBCrashReporter{h,m}'
end