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
dest = File.expand_path('~/Library/Developer/Xcode/Templates')

if File.exists? staging
  puts "Copying to user's templates directory..."
  FileUtils.cp_r staging, dest
end
