var IndUsers = {
  completeSchoolToEducation : function() {
    // must use on() to dynamic generate element
    $(document).on('keydown.autocomplete', '.autocomplete_school', function(){
      $(this).autocomplete('/ind_users/school_search', {
        scroll: false, 
        minChars: 1,
        delay: 300,
        selectFirst : true
      }).result(function(event, item, fomatted) {
        var schoolName = $(fomatted).attr("data");
        $(this).closest(".span6").find(".school_field").val(schoolName);
        $(this).val(schoolName);
        $(this).replaceWith("<span>" + schoolName + " <a onclick='IndUsers.resetEducationSchool(this, \""+ schoolName +"\");' class='reset_school' href='javascript:;'>X</a></span>");
        return false;
      });   
    });
  },

  resetEducationSchool : function(el, schoolName){
    $(el).parent().replaceWith("<input type='text' name='school' class='autocomplete_school' value='"+ schoolName +"'/>");
  },

  load : function(){
    IndUsers.completeSchoolToEducation();
  }

}
