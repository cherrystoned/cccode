class Cccode::Misc
  
  require 'pry'
  require 'active_support/core_ext/object/try'

  def self.nested_keys(source_hash, *target_keys)
    begin
      new_keys = target_keys
      new_hash = source_hash
      while new_keys.present?
        return nil unless valid_key?(new_keys[0], new_hash)
      
        chk_try = new_hash.try(:[], new_keys[0])
        if chk_try
          new_hash = new_hash[new_keys[0]]
          new_keys.delete_at(0)
          return chk_try   if new_keys.blank?
        else
          return nil
        end
      end   if new_keys && new_hash
      new_hash
    rescue StandardError => e
      return nil
    end
  end

  def self.valid_key?(k, source=nil)
    key_valid = k.is_a?(String) || k.is_a?(Integer) || k.is_a?(Symbol)
    ar_valid  = source ? (source.is_a?(Array) ? k.is_a?(Integer) : true) : true
    key_valid && ar_valid
  end
end