module Eve
  class API
    module Services
      module Account
        def characters
          validate_credentials(:limited)
          request(:account, :characters)
        end
      end
    end
  end
end
