# Expected behaviour for ActiveRecord::Delegation

Prefer some class methods over methods from Enumerable on ActiveRecord relations

## Rationale

In Rails 5 you can no longer call some ActiveRecord class methods named
like their Enumerable counterparts:

```:encode_with, :to_ary, :join, :[], :&, :|, :+, :-, :sample, :reverse, :compact, :in_groups, :in_groups_of, :to_sentence, :to_formatted_s, :shuffle, :split, :index```
        
This gem reinstates the expected behaviour, where you can always
get the method from Enumerable by calling to_a on the relation,
whilst being able to define it as class method on the relation model.

See: https://github.com/rails/rails/issues/26949

## Licensing

Licensed under the MIT license.
