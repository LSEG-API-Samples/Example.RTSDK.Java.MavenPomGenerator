#|-----------------------------------------------------------------------------
#|            This source code is provided under the MIT license             --
#|  and is provided AS IS with no warranty or guarantee of fit for purpose.  --
#|                See the project's LICENSE.md for details.                  --
#|           Copyright Refinitiv 2023.       All rights reserved.            --
#|-----------------------------------------------------------------------------

=begin
Example Code Disclaimer:
ALL EXAMPLE CODE IS PROVIDED ON AN “AS IS” AND “AS AVAILABLE” BASIS FOR ILLUSTRATIVE PURPOSES ONLY. REFINITIV MAKES NO REPRESENTATIONS OR WARRANTIES OF ANY KIND, EXPRESS OR IMPLIED, AS TO THE OPERATION OF THE EXAMPLE CODE, OR THE INFORMATION, CONTENT, OR MATERIALS USED IN CONNECTION WITH THE EXAMPLE CODE. YOU EXPRESSLY AGREE THAT YOUR USE OF THE EXAMPLE CODE IS AT YOUR SOLE RISK.
=end

require "optparse"
require "FileUtils"
require "erb"
require "yaml"

default_api = "EMA"
default_ema_pom_template = "../templates/rtsdk_maven_pom_xml.erb"
rtsdk_versions_config = "../config/rtsdk_versions.yaml"
maven_rtsdk_version_data  = YAML.load(File.read(rtsdk_versions_config))

# define defaul input parameter
options = {:sdkversion => maven_rtsdk_version_data["latest_version"], :api => default_api}

# get input command line arguments
optparse = OptionParser.new do |opts|
    opts.banner = "Usage: ruby_automate.rb [options]"
    #opts.on("--folder n", "input the base folder that store all cases folders") { |folder| options[:folder] = folder }
    opts.on("--api n", "RTSDK API (EMA/ETA) [optional]"){|api| options[:api] = api}
    opts.on("--version n", "ESDK/RTSDK Java version [optional]"){|sdkversion| options[:sdkversion] = sdkversion}
end

optparse.parse!
# if no caseid, exit program
# if options[:folder].nil?
#     abort("No folder inputted")
# end

## Create Folder and files variables

folder = "#{options[:folder]}"
# pom.xml
pom_file = "./pom.xml"

@api = options[:api]

if @api == "EMA" then
    @junitscope = "test"
    puts "EMA"
else 
    @junitscope = "compile"
    puts "ETA"
end

@artifactid = "#{options[:api]}_Java_#{options[:sdkversion]}_Maven"

sdk_version = options[:sdkversion]

# Set SDK <--> Maven version
if maven_rtsdk_version_data["rtsdk_versions"][sdk_version] then
    @rtsdkversion = maven_rtsdk_version_data["rtsdk_versions"][sdk_version]
    puts @rtsdkversion
else
    @rtsdkversion = maven_rtsdk_version_data["latest_version"]
    puts "not found that version, use the latest version instead #{@rtsdkversion}"
end

# Set JDK compat version
#@compat_jdk_version = "1.8" 
@compat_jdk_version = maven_rtsdk_version_data["support_jdk_version"]   
puts "use JDK #{@compat_jdk_version}"

# Set rebrand namespace
@namespace = maven_rtsdk_version_data["namespace"]["refinitiv"]
@transportapi = maven_rtsdk_version_data["transportapi"]["refinitiv"]

## Generating folders and files
begin

    # using ERB template
    erb_pom = ERB.new(File.read(default_ema_pom_template))
    # Creating pom.xml
    File.open(pom_file,"w") do |line|
        line.puts erb_pom.result(binding)
    end
    puts "Done creating pom.xml"
    
   
rescue => exception
    puts "Exception occurs #{exception.message}"
    puts exception.backtrace.inspect
end