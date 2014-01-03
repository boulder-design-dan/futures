// Foundation JavaScript
// Documentation can be found at: http://foundation.zurb.com/docs
$(document).foundation();

$(function(){
    $('.topmenu').slicknav({
        label: '',
        duration: 500,
        closeOnClick: true,
        prependTo:'.topmenu-mobile'
    });
});
