class BasicAuth
  def initialize(app)
    @app = app
  end

  def call(env)
    auth = Rack::Auth::Basic.new(@app) do |u, p|
      u == username && p == password
    end

    auth.call env
  end

  def username
    ENV["HTTP_USER"]
  end

  def password
    ENV["HTTP_PASSWORD"]
  end
end