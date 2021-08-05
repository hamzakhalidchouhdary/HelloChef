module API
  module V1
    class Books < Grape::API
      helpers V1::AuthHelpers
      before { authenticate }

      namespace :books do
        desc 'Return list of books'
        params do 
        end
        get do
          {'msg' => "Hello World!!!", "status" => 220, "text" => "oh yes!!", "token" => @auth_token}
        end

        get ":name" do
          {"msg" => "Welcome " + params[:name]}
        end
      end
    end
  end
end