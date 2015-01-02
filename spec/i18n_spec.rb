require 'spec_helper'
require 'i18n/tasks'
require "i18n-spec"

describe 'locale:' do

  Dir.glob('config/locales/*.yml') do |locale_file|
    next if locale_file == "config/locales/config.yml"
    next if locale_file.include? "extra"
    context locale_file do
      it { is_expected.to be_parseable }
      it { is_expected.to have_valid_pluralization_keys }
      it { is_expected.not_to have_missing_pluralization_keys }
      it { is_expected.to have_one_top_level_namespace }
      it { is_expected.not_to have_legacy_interpolations }
      it { is_expected.to have_a_valid_locale }
      it { is_expected.to be_a_complete_translation_of 'config/locales/en.yml' }
    end
  end
  context 'config/locales/en.yml' do
    it { is_expected.to be_a_complete_translation_of 'config/locales/fi.yml' }
  end
end

describe 'I18n' do
  let(:i18n) { I18n::Tasks::BaseTask.new }
  let(:missing_keys) { i18n.missing_keys }
  let(:unused_keys) { i18n.unused_keys }

  it 'does not have missing keys' do
    # needs work
#    expect(missing_keys).to be_empty,
 #                           "Missing #{missing_keys.leaves.count} i18n keys, run `i18n-tasks missing' to show them"
  end

  it 'does not have unused keys' do
    expect(i18n.unused_keys).to be_empty,
                                "#{unused_keys.leaves.count} unused i18n keys, run `i18n-tasks unused' to show them"
  end
end
