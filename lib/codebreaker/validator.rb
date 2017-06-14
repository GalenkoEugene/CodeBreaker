# frozen_string_literal: true

module Validator
  def self.included(base)
    base.extend(Validator)
  end
  def valid?(str)
    str =~ /^[1-6]{4}$/
  end
end

