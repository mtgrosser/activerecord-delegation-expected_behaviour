require 'active_record'

ActiveRecord::Delegation.module_eval do
  REDELEGATED_METHODS = [:encode_with, :to_ary, :join, :[], :&, :|, :+, :-, :sample,
    :reverse, :compact, :in_groups, :in_groups_of, :to_sentence, :to_formatted_s,
    :shuffle, :split, :index, :excluding]

  REDELEGATED_METHODS.each do |method|
    if method =~ /[^\]]=$/
      define_method(method) { |arg| delegate_to_klass_or_records(method, arg) }
    else
      define_method(method) { |*args, &block| delegate_to_klass_or_records(method, *args, &block) }
    end
  end

  protected

  def delegate_to_klass_or_records(method, *args, &block)
    if @klass.respond_to?(method)
      scoping { @klass.public_send(method, *args, &block) }
    else
      records.public_send(method, *args, &block)
    end
  end
end
