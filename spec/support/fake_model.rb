require 'ostruct'

class FakeModel < OpenStruct
  def self.instances
    @instances ||= {}
  end

  def self.create(options = {})
    instance = new({id: instances.length + 1}.merge(options))
    instance.save
  end

  def self.all
    instances.values
  end

  def self.destroy_all
    @instances = {}
  end

  def save
    self.class.instances[id] = self
  end
end
