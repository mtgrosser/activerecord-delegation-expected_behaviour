require 'active_record'

module ActiveRecord
  module Delegation
    module ExpectedBehaviour
      VERSION = '1.0.0'
      
      UNEXPECTED_METHODS = [:encode_with, :to_ary, :join, :[], :&, :|, :+, :-,
        :sample, :reverse, :compact, :in_groups, :in_groups_of,
        :to_sentence, :to_formatted_s, :shuffle, :split, :index]
      
      def self.included(base)
        base.module_eval do
          UNEXPECTED_METHODS.each { |method| remove_method(method) }
        end
      end
    end
  end
end

ActiveRecord::Delegation.include ActiveRecord::Delegation::ExpectedBehaviour
