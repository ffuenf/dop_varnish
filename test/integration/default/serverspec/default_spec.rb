require 'serverspec'
set :backend, :exec
set :path, '/sbin:/usr/sbin:/usr/local/sbin:$PATH'

describe file('/etc/varnish/secret') do
  it { should be_file }
  it { should be_mode 400 }
  it { should contain 'insecuresecret' }
end

describe file('/etc/varnish/default.vcl') do
  it { should be_file }
  it { should be_mode 644 }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
end

describe file('/etc/default/varnish') do
  it { should be_file }
  it { should be_mode 644 }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
end

describe file('/var/lib/varnish/default') do
  it { should be_directory }
end

describe file('/etc/varnish/vcl.d') do
  it { should be_directory }
end

describe file('/etc/varnish/.all_includes.vcl') do
  it { should be_file }
  it { should be_mode 644 }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
end

describe file('/etc/varnish/include_varnish_configs') do
  it { should be_file }
  it { should be_mode 755 }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
end

describe service('varnish') do
  it { should be_enabled }
  it { should be_running }
end
