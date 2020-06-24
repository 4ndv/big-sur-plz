# frozen_string_literal: true

def yes
  STDIN.gets.chomp == 'yes'
end

#
# Check installer
#

installer_path = ARGV[0] || '/Applications/Install macOS Beta.app'

assistant_path = "#{installer_path}/Contents/MacOS/InstallAssistant"

unless File.exist?(assistant_path)
  puts '[ERROR] Couldn\'t find installer in the default location'
  puts '[ERROR] Specify correct path to Big Sur installer'
  exit 1
end

puts "Found installer at #{installer_path}"
puts "Found InstallAssistant at #{assistant_path}"

#
# SIP
#
puts 'Checking SIP status'

sip_status_output = `csrutil status`

unless sip_status_output.include? 'disabled'
  puts '[ERROR] SIP is enabled. Reboot to recovery mode (Cmd+R and power on) and enter "csrutil disable" in terminal'
  exit 1
end

#
# FileVault
#

puts 'Checking FileVault status'

filevault_status_output = `fdesetup status`

if filevault_status_output.include? 'is On.'
  puts '[WARN] FileVault is Enabled and may cause some issues. I HAVEN\'T CHECKED how it affects installation.'
  puts '[WARN] Please, if you decide to proceed with FileVault enabled'
  puts 'after installation try to remount root as rw and submit results'
  puts '[WARN] If you want to try proceeding with FileVault enabled, enter "yes":'

  exit 1 unless yes
end

#
# Library validation
#

puts 'Disabling library validation'

#
# Add boot vars
#

`sudo defaults write /Library/Preferences/com.apple.security.libraryvalidation.plist DisableLibraryValidation -bool true`

puts 'Checking current boot args'

current_boot_args = `sudo nvram boot-args`

unless current_boot_args.include? 'Error getting variable'
  puts '[WARN] There is already boot args set:'
  puts current_boot_args
  puts '[WARN] Type "yes" to overwrite it:'

  if yes
    `sudo nvram boot-args="-no_compat_check"`
  else
    puts 'Continuing without setting boot args'
  end
end

puts 'Downloading patcher'

if File.exist?('Hax.dylib') && File.exist?('InstallHax.m') && File.exist?('patcher.zip')
  puts 'Patcher already exists, skipping download'
else
  `curl https://forums.macrumors.com/attachments/really-simple-installer-hack-zip.926156/ -o patcher.zip`

  puts 'Extracting patcher'

  `unzip patcher.zip`
end

puts 'Applying patcher'

`launchctl setenv DYLD_INSERT_LIBRARIES #{File.expand_path('Hax.dylib').gsub(/ /, '\ ')}`

puts 'Running installer'

installer = fork do
  exec assistant_path.gsub(/ /, '\ ')
end

puts 'Detaching installer'

Process.detach(installer)
