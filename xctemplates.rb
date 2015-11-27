#!/usr/bin/env ruby

# Copyright 2012-2015 Roy Clarkson
# 
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
#     http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

require 'fileutils'
include FileUtils

staging = 'staging'
templates = staging + '/File Templates'

license = 'ASL'
if !ARGV.empty?
  license = ARGV.first.upcase
end

puts "Using license: #{license}"

if File.exists? staging
  puts "Removing existing staging directory..."
  FileUtils.rm_rf staging
end

license_file = 'templates/' + license + '.txt'
if !File.exists? license_file
  puts "License file not found!"
  exit
end

puts "Creating staging directory..."
FileUtils.mkdir_p templates

puts "Copying templates from Xcode..."

dir_format = ' (' + license + ')'
FileUtils.cp_r '/Applications/Xcode.app/Contents/Developer/Library/Xcode/Templates/File Templates/Core Data', templates + '/Core Data' + dir_format
FileUtils.cp_r '/Applications/Xcode.app/Contents/Developer/Library/Xcode/Templates/File Templates/Source', templates + '/Source' + dir_format

puts "Updating directories..."
Dir.glob(templates + '/**/*').each { |f| 
  extname = '.xctemplate'
  if (File.directory?(f) and File.extname(f).eql?(extname))
    puts "Renaming directory..."
    dirname = File.dirname(f)
    original_basename = File.basename(f, extname)
    new_basename = original_basename + dir_format
    File.rename(f, dirname + '/' + new_basename + extname)
    puts "#{original_basename}#{extname} => #{new_basename}#{extname}"
  end
  }

puts "Updating file headers..."
original_header = File.read('templates/original_header.txt')
new_header = File.read(license_file)
Dir.glob(templates + '/**/*[!png]').each { |f| 
  if (File.file?(f))
    puts "Processing file..."
    text = File.read(f)    
    if String.method_defined?(:encode)
      text.encode!('UTF-16', 'UTF-8', :invalid => :replace, :replace => '')
      text.encode!('UTF-8', 'UTF-16')
    end
    updated_text = text.gsub(original_header, new_header)
    File.open(f, "w") { |file| 
      file.puts updated_text 
      puts "#{f}"
      }
  end
  }

# dest = File.expand_path('~/Library/Developer/Xcode/Templates')
# if File.exists? dest
#   puts "Removing user's existing templates directory..."
#   FileUtils.rm_rf dest
# end
# 
# puts "Copying to user's templates directory..."
# FileUtils.cp_r staging, dest
