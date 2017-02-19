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

  desc 'base', "Execute base builds"
  def base
    templates=Dir.glob("*-base.json")
    only=only_target(base_build: true)
    templates.each do |t|
      system "packer build -on-error=cleanup -only=#{only} #{t}"
    end
  end

  desc 'build', "Execute the secondary builds"
  def build
    templates = Dir.glob("*.json").reject {|t| t.match(/base/)}
    only=only_target(base_build: false)
    templates.each do |template|
      system "packer build -on-error=cleanup -only=#{only} #{template}"
    end
  end

end
