require 'docker'
require 'serverspec'

describe "vault" do
  image = Docker::Image.build_from_dir('.')

  set :os, :family => :alpine
  set :backend, :docker
  set :docker_image, image.id

  it "installs the correct version of vault" do
    expect(vault_version).to include('0.5.1')
  end

  def vault_version
    command('/usr/local/bin/vault version').stdout
  end
end
