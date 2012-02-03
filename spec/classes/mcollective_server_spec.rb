#!/usr/bin/env rspec

require 'spec_helper'

describe 'mcollective::server', :type => :class do
  let(:facts) do
    { :operatingsystem => 'redhat' }
  end

  describe 'when only the mandatory parameters are provided' do
    let(:params) do
      {}
    end

    it 'should always be included' do
      subject.should contain_class('mcollective::server')
    end

    it 'should create a default config file' do
      subject.should contain_file('/etc/mcollective/server.cfg')
    end
  end
end
