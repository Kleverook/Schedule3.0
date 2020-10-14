window.onload = function () {
    // if (get_cookie('login_key')!=null){
    //     console.log(get_cookie("login_key"))
    //     window.location = "/"
    // }

    check_user = function () {
        let login = document.getElementById('login')
        let password = document.getElementById('password')

        let xmlhttp = getXmlHttp()
        xmlhttp.open('POST', '/api', true)
        xmlhttp.setRequestHeader('Content-Type', 'application/json')
        xmlhttp.send(JSON.stringify({"password": password.value, "login": login.value, "api_method": "check_user"}))
        xmlhttp.onreadystatechange = function () {
            if (xmlhttp.readyState == 4) {
                if (xmlhttp.status == 200) {
                    let answer = JSON.parse(xmlhttp.responseText)
                    let error = document.getElementById('error_box')
                    if (answer['state']) {
                        error.style.visibility = 'hidden'
                        console.log("OK")
                        set_cookie('login_key', answer['loginKey'])

                        window.location = "/"
                    } else {
                        error.style.visibility = 'visible'
                    }
                }
            }
        }
    }
}