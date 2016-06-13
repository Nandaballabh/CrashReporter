Pod::Spec.new do |s|
  s.name         = 'CrashReporter'
  s.version      = '1.0.0'
  s.summary      = 'This is sample code for enabling the popup after crash in iosapplication to ask user to send logs to development team'
  s.author = {
    'Nanda Ballabh' => 'nandaballabh.kec08@gmail.com' 
  }
  s.source = {
    :git => 'https://github.com/Nandaballabh/CrashReporter.git',
    :tag => '1.0.0'
  }
  s.source_files = 'NBCrashReporter/*.{h,m}'
  s.dependency     ''
end
