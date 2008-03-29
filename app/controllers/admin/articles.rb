module Admin
  class Articles < Base

    before :find_article, :only => %w(edit update delete)

    def index
      @articles = Article.all(:order => 'published_at DESC')
      display @articles
    end
    
    def show
      @article = Article[params[:id]]
      display @article
    end
    
    def new
      @article = Article.new
      display @article
    end
    
    def create
      @article = Article.new(params[:article])
      @article.published_at = params[:published] == "0" ? nil : Time.now
      @article.user_id = self.current_user.id
      if @article.save
        redirect url(:admin_article, @article)
      else
        render :new
      end
    end
    
    def edit
      display @article
    end
    
    def update
      if @article.update_attributes(params[:article])
        redirect url(:admin_article, @article)
      else
        render :edit
      end
    end
    
    def delete
      @article.destroy!
      redirect url(:admin_articles)
    end
    
    private
      def find_article
        @article = Article[params[:id]]
      end

  end
  
end