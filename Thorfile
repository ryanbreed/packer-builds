# vi: ft=ruby

require 'thor'
require 'fileutils'
require 'timeout'


class Packer < Thor
  no_commands do
    def target_os
      RbConfig::CONFIG["target_os"].gsub(/\d+/,'').downcase
    end
    def only_target(base_build: false)
      case target_os
      when /darwin/
        base_build ? "vmware-iso" : "vmware-vmx"
      when /linux/
        "qemu"
      else
        "virtualbox-iso"
      end
    end
  end
  desc 'validate', "Validate all the packer templates"
  def validate
      templates = Dir.glob("breed-*.json")
      templates.each do |template|
        puts "#{template}"
        unless system "packer validate #{template}"
          fail "Validation failed!"
        end
        puts "\n"
      end
  end

  desc 'base', "Execute base builds"
  option :dest, default: "local"
  def base
    templates=Dir.glob("breed-base-*.json")
    only=only_target(base_build: true)
    templates.each do |t|
      system "packer build -on-error=cleanup  -var-file=vars_dest_#{options[:dest]}.json -only=#{only} #{t}"
    end
  end

  desc 'build', "Execute the secondary builds"
  option :dest, default: "local"
  def build
    templates = Dir.glob("breed-spec-*.json")
    only=only_target(base_build: false)
    templates.each do |template|
      system "packer build -on-error=cleanup -var-file=vars_dest_#{options[:dest]}.json -only=#{only} #{template}"
    end
  end
end
