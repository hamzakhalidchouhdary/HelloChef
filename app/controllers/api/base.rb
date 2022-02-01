module API
  class Base < Grape::API 
    prefix :api

    mount API::V1::Base
    mount API::V2::Base
  end
 end