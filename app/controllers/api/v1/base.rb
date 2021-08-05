module API
  module V1
    class Base < Grape::API
      version 'v1'
      format :json
      
      mount V1::Books
      mount V1::Signup
    end
  end
end