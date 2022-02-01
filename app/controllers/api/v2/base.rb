module API
  module V2
    class Base < Grape::API
      version 'v2'
      format :json

      mount V2::Books
    end
  end
end