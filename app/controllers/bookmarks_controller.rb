class BookmarksController < ApplicationController
  def bookmark
    @bookmark = Bookmark.create(:user_id=>current_user.id,:bookmarkable=>eval(params[:type]).find(params[:id]))
    @bookmarkable = @bookmark.bookmarkable
    
    respond_to do |format|  
      format.js    
    end  
  end

  def unbookmark
    bookmark = Bookmark.find(params[:id])
    @bookmarkable = bookmark.bookmarkable
    bookmark.destroy
    
    respond_to do |format|  
      format.js    
    end  
  end
end
