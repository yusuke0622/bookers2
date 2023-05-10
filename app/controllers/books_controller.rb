class BooksController < ApplicationController
  before_action :authenticate_user!
  
  def new
    @book = Book.new
  end
  
  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    @book.save
    redirect_to book_path(@book.id)
  end

  def show
    @book = Book.find(params[:id])
    @user = @book.user
    @new_book = Book.new
  end

  def index
    @books = Book.all
    @user = current_user
    @new_book = Book.new
  end

  def edit
    @book = Book.find(params[:id])
  end
  
  def update
    @book = Book.find(params[:id])
    if @book.update(book_params) 
      flash[:notice] = "You have updated book successfully."
      redirect_to book_path(@book.id)
    else 
      render :edit
    end
  end
  
  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end
  
  #def get_profile_image(width, height)
     #unless profile_image.attached?
       #file_path = Rails.root.join('app/assets/images/no_image.jpg')
       #profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
     #end
      #profile_image.variant(resize_to_limit: [width, height]).processed
  #end
  
  private
  def book_params
    params.require(:book).permit(:title, :body)
  end
end
