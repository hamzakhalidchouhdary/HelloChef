module API
  module V2
    class Books < Grape::API
      namespace :books do
        desc 'Return list of books'
        params do 
        end
        get do
          {'msg' => "Hello World!!!", "version" => 2}
        end

        get ":id" do
          {"id" => params[:id], "version" => '2'}
        end
      end
    end
  end
end