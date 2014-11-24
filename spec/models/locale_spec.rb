require "i18n-spec"

RSpec.describe 'locale:' do

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
