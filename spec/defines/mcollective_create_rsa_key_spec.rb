#!/usr/bin/env rspec

require 'spec_helper'

describe 'mcollective::create_rsa_key', :type => :define do
  let(:facts) do
    { :operatingsystem => 'redhat' }
  end

  describe 'when only the mandatory parameters are provided' do
    let(:title) { 'myuser' }

    let(:params) do
      {}
    end

    it 'should always be included' do
      subject.should contain_mcollective__create_rsa_key('myuser')
    end
  end
end
