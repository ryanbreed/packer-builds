# vi: ft=ruby

require 'thor'
require 'fileutils'
require 'timeout'


class Packer < Thor
  no_commands do
    def target_os
      RbConfig::CONFIG["target_os"].gsub(/\d+/,'').downcase
    end
  end
  desc 'validate', "Validate all the packer templates"
  def validate
    Dir.chdir './packer' do
      templates = Dir.glob("*.json")
      templates.each do |template|
        puts "#{template}"
        unless system "packer validate #{template}"
          fail "Validation failed!"
        end
        puts "\n"
      end
    end
  end

  desc 'clean', "Description goes here"
  def clean(what)
    if what == "cache"
      FileUtils.rm_rf(Dir.glob('./packer/packer_cache/*'))
    elsif what == "boxes"
      FileUtils.rm_rf(Dir.glob('./packer/*.box'))
    end
  end

  desc 'base', "build base box"
  option :template, default: 'breed-base-*.json'
  option :error, default: 'cleanup'
  def base
    only=case target_os
    when /darwin/
      "vmware-iso"
    when /linux/
      "qemu"
    else
      "virtualbox-iso"
    end
    templates = Dir.glob(options[:template])
    templates.each do |t|
      system "packer build -on-error=#{options[:error]} -only=#{only} #{t}"
    end
  end

  desc 'build', "Execute the packer builder"
  option :only, :banner => "<only>"
  def build
    templates = Dir.glob("*.json")
    if options[:only]
      templates.each do |template|
        system "packer build -only=#{options[:only]} #{template}"
      end
    else
      templates.each do |template|
        system "packer build #{template}"
      end
    end
  end

end
