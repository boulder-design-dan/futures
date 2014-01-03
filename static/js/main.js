$(document).ready(function(){
$(".accordion").on("click", "dd", function (event) {
    $("dd.active").find(".content").slideToggle("slow");
    $(this).find(".content").slideToggle("slow");
})
});
