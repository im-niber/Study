class HomeController < ApplicationController
    def index
    end

    def result
        @plus_result = params[:num1].to_i + params[:num2].to_i
    end

    def plus
        @plus_result = params[:num1].to_i + params[:num2].to_i
    end

    def index2
        @posts = Post.all
    end

    def create
        post = Post.new
        post.title = params[:title]
        post.content = params[:content]
        post.save

        redirect_to '/index2'
    end

    def write
    end

    def modify
        @post = Post.find(params[:post_id])
    end

    def update
        post = Post.find(params[:id])
        post.title = params[:title]
        post.content = params[:content]
        post.save
        redirect_to '/index2'
    end

    def delete
        Post.destroy(params[:id])
        redirect_to '/index2'
    end
end