require 'spec_helper'

describe 'prometheus::logstash_exporter' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts.merge(os_specific_facts(facts))
      end

      context 'with version specified' do
        let(:params) do
          {
            version: '0.6.0',
            arch: 'amd64',
            os: 'linux'
          }
        end

        it { is_expected.to compile.with_all_deps }
        describe 'required resources' do
          it { is_expected.to contain_group('logstash-exporter') }
          it { is_expected.to contain_prometheus__daemon('logstash_exporter') }
          it { is_expected.to contain_service('logstash_exporter') }
          it { is_expected.to contain_user('logstash-user') }
        end
      end
    end
  end
end
