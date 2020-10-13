window.onload =function (){
    console.log(get_cookie("login_key"))
    if (get_cookie('login_key')==null){
        console.log(get_cookie("login_key"))
        window.location = "/login"
    }
}