#!/usr/bin/env rspec

require 'spec_helper'

describe 'mcollective::deploy_rsa_key', :type => :define do
  let(:facts) do
    { :operatingsystem => 'redhat' }
  end

  describe 'when only the mandatory parameters are provided' do
    let(:title) { 'myuser' }

    let(:params) do
      {}
    end

    pending 'should always be included' do
      # TODO: stub the file function
      subject.should contain_mcollective__deploy_rsa_key('myuser')
    end
  end
end
