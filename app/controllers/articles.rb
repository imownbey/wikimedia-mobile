class Articles < Application
  before :setup_ivars
  
  def home
    @name = "::Home"
    @main_page = Wikipedia.main_page(request.language_code)
    render
  end
  
  def random
    @article = Article.random(current_server)
    redirect @article.path
  end
  
  def show
    @name = params[:search] || params[:title]
    # Perform a normal search
    @article = Article.new(current_server, @name)
    @article.fetch!
    display @article, :search
  end
  
  def file
    render current_server.file(params[:file]).html(:image)
  end
  
 private 
  def setup_ivars
    @name = ""
  end
  
end
