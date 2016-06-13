Pod::Spec.new do |s|
  s.name         = 'CrashReporter'
  s.version      = '1.0'
  s.license =  { :type => 'MIT', :file => 'LICENSE' }
  s.framework = 'MessageUI'
  s.homepage = 'https://github.com/Nandaballabh/CrashReporter'
  s.summary      = 'This is sample code for enabling the popup after crash in iosapplication to ask user to send logs to development team'
  s.author = {
    'Nanda Ballabh' => 'nandaballabh.kec08@gmail.com' 
  }
  s.source = {
    :git => 'https://github.com/Nandaballabh/CrashReporter.git',
    :tag => s.version.to_s 
  }
  s.source_files = 'CrashReporter/*.{h,m}'
  s.requires_arc  = true
end
