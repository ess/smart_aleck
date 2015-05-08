require 'spec_helper'

describe SmartAleck do
  let(:opts) {
    {category_model: Category, entry_model: Entry, user_model: User}
  }

  it 'has a version number' do
    expect(SmartAleck::VERSION).not_to be nil
  end

  describe '.configure' do
    it 'requires a category model and an entry model' do
      expect(described_class).
        to receive(:check_required_options).
        with(opts, :category_model, :entry_model)

      described_class.configure(opts)
    end

    it 'sets the category model' do
      described_class.configure(opts)
      expect(described_class.category_model).to eql(opts[:category_model])
    end

    it 'sets the entry model' do
      described_class.configure(opts)
      expect(described_class.entry_model).to eql(opts[:entry_model])
    end
  end

  describe '.entry_model' do
    it 'is the configured entry model' do
      described_class.configure(opts)
      expect(described_class.entry_model).to eql(opts[:entry_model])
    end
  end

  describe '.category_model' do
    it 'is the configured category model' do
      described_class.configure(opts)
      expect(described_class.category_model).to eql(opts[:category_model])
    end
  end

  describe '.verify_configured' do
    it 'is true when the configuration is valid' do
      described_class.configure(opts)
      expect(described_class.verify_configured).to eql(true)
    end

    it 'raises NotConfigured if the configuration is not valid' do
      described_class.clear_config!
      expect{described_class.verify_configured}.
        to raise_error(described_class::NotConfigured)
    end
  end

  describe '.clear_config!' do
    before(:each) do
      described_class.configure(opts)
    end

    it 'clears the entry model' do
      expect(described_class.entry_model).not_to eql(nil)
      described_class.clear_config!
      expect(described_class.entry_model).to eql(nil)
    end

    it 'clears the category model' do
      expect(described_class.category_model).not_to eql(nil)
      described_class.clear_config!
      expect(described_class.category_model).to eql(nil)
    end

    it 'causes configuration verification to fail' do
      expect(described_class.verify_configured).to eql(true)
      described_class.clear_config!
      expect{described_class.verify_configured}.
        to raise_error(described_class::NotConfigured)
    end
  end
end
