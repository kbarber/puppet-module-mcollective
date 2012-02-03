#!/usr/bin/env rspec

require 'spec_helper'

describe 'mcollective::policy', :type => :define do
  let(:facts) do
    { :operatingsystem => 'redhat' }
  end

  describe 'when only the mandatory parameters are provided' do
    let(:title) { 'myagent' }

    let(:params) do
      { 
        :userpolicy => {
          'ken' => {
            'policy' => 'allow',
            'actions' => ['status', 'run', 'jump'],
          }
        }
      }
    end

    it 'should always be included' do
      subject.should contain_mcollective__policy('myagent')
    end
  end
end
