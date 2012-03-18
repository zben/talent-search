class BookmarksController < ApplicationController
  def bookmark
    @bookmarks = Bookmark.where(:bookmarkable_type=>params[:type]).where(:bookmarkable_id=>params[:id])
    if @bookmarks.empty?
      logger.info "no bookmark yet"
      @bookmark = Bookmark.create(:user_id=>current_user.id,:bookmarkable=>eval(params[:type]).find(params[:id]))
      @is_bookmarked = true
    else
      logger.info 'already has bookmark'
      @bookmark = @bookmarks.first
      @bookmarks.destroy_all
      @is_bookmarked = false
    end
    @bookmarkable = @bookmark.bookmarkable
    
    respond_to do |format|  
      format.js    
    end  
  end

end
