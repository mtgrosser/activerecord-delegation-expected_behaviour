require 'active_record'

ActiveRecord::Delegation.module_eval do
  REDELEGATED_METHODS = [:encode_with, :to_ary, :join, :[], :&, :|, :+, :-, :sample,
    :reverse, :compact, :in_groups, :in_groups_of, :to_sentence, :to_fs,
    :shuffle, :split, :index, :excluding]

  REDELEGATED_METHODS.each do |method|
    if method =~ /[^\]]=$/
      define_method(method) { |arg| delegate_to_klass_or_records(method, arg) }
    else
      define_method(method) { |*args, **kwargs, &block| delegate_to_klass_or_records(method, *args, **kwargs, &block) }
    end
  end

  protected

  def delegate_to_klass_or_records(method, *args, **kwargs, &block)
    if model.respond_to?(method)
      scoping { model.public_send(method, *args, **kwargs, &block) }
    else
      records.public_send(method, *args, **kwargs, &block)
    end
  end
end
