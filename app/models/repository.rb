class Repository
  def self.posts
    @posts ||= InMemoryRepository.new
  end
end

class InMemoryRepository
  def initialize
    @instances = {}
  end

  def clear
    @instances = {}
  end

  def find(id)
    @instances[id.to_i]
  end

  def destroy(instance)
    instance = @instances.delete(instance.id)
    instance._destroyed = true
    instance
  end

  def save(instance)
    if instance.valid?
      if instance.persisted?
        @instances[instance.id] = instance
      else
        instance.id = count + 1
        @instances[instance.id] = instance
        instance._new_record = false
      end
      true
    else
      false
    end
  end

  def count
    @instances.size
  end

  def all
    @instances.values.sort_by(&:id)
  end

  def first
    all.first
  end

  def last
    all.last
  end
end

class ActiveRecord::Base
  def self.clear
  end

  def self.save(instance)
    instance.save
  end

  def _new_record=(value)
    @new_record = value
  end

  def _destroyed=(value)
    @destroyed = value
  end
end
