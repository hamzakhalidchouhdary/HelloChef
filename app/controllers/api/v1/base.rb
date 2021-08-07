module API
  module V1
    class Base < Grape::API
      helpers V1::AuthHelpers

      version 'v1'
      format :json
      
      mount V1::Login
      mount V1::Signup
      mount V1::Organization
      mount V1::MyStaff

    end
  end
end