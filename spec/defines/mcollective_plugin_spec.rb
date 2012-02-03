#!/usr/bin/env rspec

require 'spec_helper'

describe 'mcollective::plugin', :type => :define do
  let(:facts) do
    { :operatingsystem => 'redhat' }
  end

  describe 'when only the mandatory parameters are provided' do
    let(:title) { 'myplugin' }

    let(:params) do
      { :type => 'agent' }
    end

    it 'should always be included' do
      subject.should contain_mcollective__plugin('myplugin')
    end
  end
end
