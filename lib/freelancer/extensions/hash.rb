class Hash

  # Symbolize the keys in the hash. Copied from ActiveSupport's Core Extensions.
  def symbolize_keys
    inject({}) do |options, (key, value)|
      options[(key.to_sym rescue key) || key] = value
      options
    end
  end

end