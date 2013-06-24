$(document).ready(function() {
    $("ul#main-menu li a").click(function(){
        prev = $(this).parent().parent().find("a.active").attr("rel");
        next = $(this).attr("rel");
        $(this).parent().parent().find("a.active").removeClass("active");
        $(this).addClass("active");
        $("div.content-left#" + prev).stop(true, true).fadeOut(250, function(){
           $("div.content-left#" + next).stop(true, true).fadeIn(250);
        });
        return false;
    });
});