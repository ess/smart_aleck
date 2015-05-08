require "optionally"
require "smart_aleck/version"
require 'smart_aleck/category_indexer'
require 'smart_aleck/entry_creator'
require 'smart_aleck/finding_viable_peers'

module SmartAleck
  include Optionally::Required

  def self.configure(options)
    check_required_options(options, :category_model, :entry_model)
    @category_model = options[:category_model]
    @entry_model = options[:entry_model]
  end

  def self.category_model
    @category_model
  end

  def self.entry_model
    @entry_model
  end

  def self.verify_configured
    raise NotConfigured unless (category_model && entry_model)
    true
  end

  def self.clear_config!
    @entry_model = @category_model = nil
  end

  class NotConfigured < StandardError
  end
end
