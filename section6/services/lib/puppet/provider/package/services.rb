require 'puppet/provider/package'

Puppet::Type.type(:package).provide :services, :parent => Puppet::Provider::Package do
  desc "Package management based on a static file"
  has_feature :versionable, :uninstallable

  confine :operatingsystem => :ubuntu

  def self.instances
    i = {}
    services = []
    File.open('/etc/services').each_line do |line|
      next unless line.scan('/tcp')
      next if line.start_with? "#"
      next if line.length == 0
      name,p,rest = line.split
      begin
        i[name] = p.split('/')[0]
      rescue
        i[name] = nil
      end
    end
    i.collect do |name,port|
      next if (name.nil?)
      services << self.new(
        :name => name,
        :ensure => port,
        :provider => 'services'
      )
    end
    services
  end

  def query
    i = {}
    File.open('/etc/services').each_line do |line|
      next unless line.scan('/tcp')
      next if line.start_with? "#"
      next if line.length == 0
      name,p,rest = line.split
      begin
        i[name] = p.split('/')[0]
      rescue
        i[name] = nil
      end
    end
    if i.has_key?(@resource[:name])
      { :name => @resource[:name], :ensure => i[@resource[:name]] }
    else
      nil
    end
  end

  def install
    if @resource[:ensure] != :present
      File.open('/etc/services', 'a+') { |f|
        f.write("#{@resource[:name]}#{' '*(16-@resource[:name].length)}#{@resource[:ensure]}/tcp#{' '*(20-@resource[:ensure].to_s.length)}# added by services package provider\n")
      }
    end
  end

  def uninstall
    f=File.open('/etc/services').readlines
    f.delete_if{ |l| l.start_with?(@resource[:name])}
    File.open('/etc/services','w') do |nF|
      nF.seek(0)
      f.each { |l|
        nF.write(l)
      }
    end
  end
end
