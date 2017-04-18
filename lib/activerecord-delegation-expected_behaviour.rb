require 'active_record'

module ActiveRecord
  module Delegation
    module ExpectedBehaviour
      VERSION = '1.1.1'
      
      REDELEGATED_METHODS = [:encode_with, :to_ary, :join, :[], :&, :|, :+, :-, :sample,
        :reverse, :compact, :in_groups, :in_groups_of, :to_sentence, :to_formatted_s,
        :shuffle, :split, :index]
      
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
  end
end

ActiveRecord::Delegation.prepend ActiveRecord::Delegation::ExpectedBehaviour
