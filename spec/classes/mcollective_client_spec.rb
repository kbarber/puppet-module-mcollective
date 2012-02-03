#!/usr/bin/env rspec

require 'spec_helper'

describe 'mcollective::client', :type => :class do
  # Convenience helper for returning parameters for a type from the
  # catalogue.
  #
  # TODO: find a place for this, potentially rspec-puppet.
  def get_param(type, title, param)
    catalogue.resource(type, title).send(:parameters)[param.to_sym]
  end

  let(:facts) do
    { :operatingsystem => 'redhat' }
  end

  describe 'when only the mandatory parameters are provided' do
    let(:params) do
      {}
    end

    it 'should always be included' do
      subject.should contain_class('mcollective::client')
    end

    it 'should create a default config file' do
      subject.should contain_file('/etc/mcollective/client.cfg')
    end
  end

  describe 'when setting a parameter' do
    let(:params) do
      {
        :config_file => "/etc/myconfig",
      }
    end

    validate = {
      :stomp_server => {
        :valid => "mystompserver",
      },
      :mc_loglevel => {
        :valid => "info",
      },
      :mc_security_provider => {
        :valid => "ssl",
      },
    }

    validate.each do |key,value|
      it "should populate #{key} in template" do
        params[key] = value[:valid]
        subject.should contain_file('/etc/myconfig')
        content = get_param("file", "/etc/myconfig", "content")
        content.should =~ /#{value[:valid]}/
      end
    end
  end
end
