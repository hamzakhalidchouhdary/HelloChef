class CorsMiddleware
  def initialize(app)
    @app = app
  end

  def call(env)
    # Add CORS headers here
    response = @app.call(env)
    response[1]['Access-Control-Allow-Origin'] = 'http://127.0.0.1:4200'
    response[1]['Access-Control-Allow-Methods'] = 'GET, POST, PUT, PATCH, DELETE, OPTIONS, HEAD'
    response
  end
end

Rails.application.config.middleware.insert_before 0, CorsMiddleware