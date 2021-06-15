require 'fastlane/action'
require_relative '../helper/upload_dsym_helper'

module Fastlane
  module Actions
    class UploadDsymAction < Action
      def self.run(params)
        require 'rest-client'
        use_bugly = params[:use_bugly]

        if use_bugly
          upload_bugly(params)
        else
          upload_specity(params)
        end
      end

      def self.upload_specity(params)
        UI.message("[UploadDsymAction] [upload_specity] 🔵running ...... ")
        host          = params[:host]
        dsym_zip_file = params[:dsym_zip_file]
        kvs           = params[:kvs]

        UI.user_error!("❌host not pass") unless host
        UI.user_error!("❌dsym_zip_file not pass") unless dsym_zip_file

        UI.important("[UploadDsymAction] [upload_specity] host: #{host}")
        UI.important("[UploadDsymAction] [upload_specity] dsym_zip_file: #{dsym_zip_file}")

        cmds = []
        cmds << "curl #{host}"
        cmds << "-F \"file=@#{dsym_zip_file}\""
        cmds << '--max-time 6000 --retry 5'
        cmd = cmds.join(' ')

        UI.important("[upload_specity] cmd: #{cmd}")
        system(cmd)
        if $?.exitstatus.zero?
          true
        else
          false
        end

        # args = {
        #   'multipart' => true,
        #   'file' => File.open(dsym_zip_file, 'rb')
        # }
        # kvs.each do |k, v|
        #   args[k.to_s] = v
        # end if kvs

        # begin
        #   RestClient.post(
        #     host,
        #     args
        #   )
        #   UI.success("[UploadDsymAction] [upload_specity] 🎉success upload #{dsym_zip_file}")
        #   true
        # rescue => exception
        #   UI.error("[UploadDsymAction] [upload_specity] ❌failed upload dsym")
        #   false
        # end
      end

      def self.upload_bugly(params)
        UI.message("[UploadDsymAction] [upload_bugly] 🔵running ...... ")
        buglyid       = params[:buglyid]
        buglykey      = params[:buglykey]
        buglytoolpath = params[:buglytoolpath]
        dsym_files    = params[:dsym_files]
        version       = params[:version]
        package       = params[:package]

        UI.user_error!("❌buglyid not pass") unless buglyid
        UI.user_error!("❌buglykey not pass") unless buglykey
        UI.user_error!("❌buglytoolpath not pass") unless buglytoolpath
        UI.user_error!("❌dsym_files not pass") unless dsym_files
        UI.user_error!("❌version not pass") unless version
        UI.user_error!("❌package not pass") unless package

        UI.important("[UploadDsymAction] [upload_bugly] buglyid: #{buglyid}")
        UI.important("[UploadDsymAction] [upload_bugly] buglykey: #{buglykey}")
        UI.important("[UploadDsymAction] [upload_bugly] buglytoolpath: #{buglytoolpath}")
        UI.important("[UploadDsymAction] [upload_bugly] dsym_files: #{dsym_files}")
        UI.important("[UploadDsymAction] [upload_bugly] version: #{version}")
        UI.important("[UploadDsymAction] [upload_bugly] package: #{package}")


        dsym_files.each do |df|
          times = 3
          tries = 1
          begin
            cmd = "java -jar #{buglytoolpath} -inputSymbol #{df} -appid #{buglyid} -appkey #{buglykey} -bundleid #{package} -version #{version} -platform iOS"
            Actions.sh(cmd)
          rescue => ex
            tries += 1
            retry if tries <= times

            UI.error("❌失败超过 #{times} 次:")
            UI.error(ex.message)
            UI.error(ex.inspect)
            UI.error(ex.backtrace.join("\n"))
            UI.user_error!("❌ force to crash!")
          end
        end

        UI.success("[UploadDsymAction] [upload_bugly] 🎉success upload to upload_bugly")
      end

      def self.description
        "upload dsym to your specify server"
      end

      def self.details
        '1. if you upload bugly, you must install bugly tool and set ENV to find bugly tool
        wget https://bugly.qq.com/v2/sdk?id=<your_bugly_id> -O ./buglySymboliOS.zip
        unzip ./buglySymboliOS.zip -d ${HOME}/tools
        2. specity: upload xx.dSYM.zip
        3. bugly: upload xx.dSYM/xx.Symbol.zip , like this: java -jar buglySymboliOS.jar -i Share.appex.dSYM -u -id <bugly_id> -key <bugly_key> -package <your_ios_appid> -version <your_app_version> => buglySymbol_Share_arm64-xxxx.zip'
      end

      def self.authors
        ["xiongzenghui"]
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(
            key: :host,
            description: "where upload your dsym.zip",
            optional: true,
            type: String,
            conflicting_options: [:bugly]
          ),
          FastlaneCore::ConfigItem.new(
            key: :dsym_zip_file,
            description: "where upload your xx.dsym.zip like this : /path/to/xxx_com.xxx.ios-dev_1.2.3-diff_13236.dSYM.zip",
            optional: true,
            type: String
          ),
          FastlaneCore::ConfigItem.new(
            key: :use_bugly,
            description: "is upload to bugly ?",
            is_string: false,
            optional: true,
            default_value: false,
            conflicting_options: [:host]
          ),
          FastlaneCore::ConfigItem.new(
            key: :buglyid,
            description: "your bugly id",
            optional: true,
            type: String
          ),
          FastlaneCore::ConfigItem.new(
            key: :buglykey,
            description: "your bugly key",
            optional: true,
            type: String
          ),
          FastlaneCore::ConfigItem.new(
            key: :buglytoolpath,
            description: 'where buglySymboliOS.jar ? like this : ${HOME}/tools/buglySymboliOS.jar',
            optional: true,
            default_value: '~/tools/buglySymboliOS.jar',
            type: String
          ),
          FastlaneCore::ConfigItem.new(
            key: :dsym_files,
            description: "where upload your xx.dSYM files like this : [/path/to/aa.appex.dSYM, /path/to/bb.appex.dSYM, /path/to/cc.appex.dSYM]",
            optional: true,
            type: Array
          ),
          FastlaneCore::ConfigItem.new(
            key: :version,
            description: "buglySymboliOS.jar ........ -version <your_pass_version>",
            optional: true,
            type: String
          ),
          FastlaneCore::ConfigItem.new(
            key: :package,
            description: "buglySymboliOS.jar ........ -package <your_pass_package>",
            optional: true,
            type: String
          ),
          FastlaneCore::ConfigItem.new(
            key: :kvs,
            description: "curl -Fkey=value",
            optional: true,
            type: Hash
          )
        ]
      end

      def self.is_supported?(platform)
        platform == :ios
      end
    end
  end
end