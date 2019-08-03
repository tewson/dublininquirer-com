class ArticlesController < ApplicationController
  before_action :set_response_format
  
  def show
    @article = Article.published.by_slug(internal_slug(params)).includes(:authors, :artworks, :comments).first

    if !@article
      raise ActiveRecord::RecordNotFound
    end

    @template = @article.template.present? ? @article.template : 'standard'

    # if the article is paywalled, the user doesn't haven't permission, and the browser isn't a bot
    @limited = @article.paywalled? && !browser.bot? && !permission_for_article?(internal_slug(params))
    
    request.format = :html
  end

  def feed
    @articles = Rails.cache.fetch("/articles/feed", expires_in: 1.hour) do
      Article.published.includes(:authors, :artworks).by_date.limit(50)
    end

    respond_to do |format|
      format.xml { render layout: false }
    end
  end

  def search
    @page = [params[:p].to_i, 1].compact.max
    @query = params[:q]
    @articles = Article.published.basic_search(@query).includes(:authors, :artworks).page(@page)
  end

  private

  def internal_slug(params)
    "/#{ params[:year] }/#{ params[:month] }/#{ params[:day] }/#{ params[:slug] }"
  end
end
