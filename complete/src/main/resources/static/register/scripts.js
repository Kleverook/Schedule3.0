window.onload = function () {
    // if (get_cookie('login_key')!=null){
    //     console.log(get_cookie("login_key"))
    //     window.location = "/"
    // }
    var check = false
    onlyLettersAndDigits = function (obj) {
        let re = new RegExp('^[a-zA-Z0-9]+$');
        return (re.test(obj.value))
    }
    includeDigits = function (obj) {
        let re = new RegExp('[0-9]');
        return (re.test(obj.value))
    }
    notNull = function (obj) {
        if (obj != null) {
            return true
        } else return false
    }
    checkDataBase = function (obj) {
        let xmlhttp = getXmlHttp()
        xmlhttp.open('POST', '/api', true)
        xmlhttp.setRequestHeader('Content-Type', 'application/json')
        console.log(obj.value)
        xmlhttp.send(JSON.stringify({"login": obj.value, "api_method": "check_login"}))
        xmlhttp.onreadystatechange = function () {
            if (xmlhttp.readyState == 4) {
                if (xmlhttp.status == 200) {
                    let answer = JSON.parse(xmlhttp.responseText)
                    console.log(answer)
                    if (answer['state'] == true) {
                        console.log("DB" + answer['state'])
                        check = true
                        console.log(check)
                        return true
                    } else {
                        return false
                    }
                }
            }
        }
    }

    checkSimbol = function (obj) {
        if (obj.value.length != 0) {
            if (obj.value.search(/[^A-Za-zА-Яа-я\s]/) == -1) {
                return true
            } else return false
        }
    }
    countSimbol = function (obj) {

        if (obj.value.length > 6) {
            return true
        } else return false
    }
    check_login = function () {
        let login = document.getElementById('login')


        if (onlyLettersAndDigits(login) & notNull(login) & countSimbol(login)) {
            login.style.background = "#29FF0E"
            return true
        } else {
            login.style.background = "#ff0000"
            return false
        }

    }
    check_password = function () {
        let password = document.getElementById('password')
        // console.log("======pass===============")
        // console.log(onlyLettersAndDigits(password))
        // console.log(notNull(password))
        // console.log(countSimbol(password))
        // console.log(includeDigits(password))
        if (onlyLettersAndDigits(password) & notNull(password) & countSimbol(password) & includeDigits(password)) {
            password.style.background = "#29FF0E"
            return true
        } else {
            password.style.background = "#ff0000"
            return false
        }
    }
    check_password_repeat = function () {
        let password = document.getElementById('password')
        let password_repeat = document.getElementById('password_repeat')

        if (password.value == password_repeat.value) {
            password_repeat.style.background = "#29FF0E"
            return true
        } else {
            password_repeat.style.background = "#ff0000"
            return false
        }

    }
    check_name = function () {
        let name = document.getElementById('name')

        if (checkSimbol(name)) {
            name.style.background = "#29FF0E"
            return true
        } else {
            name.style.background = "#ff0000"
            return false
        }
    }
    check_surname = function () {
        let surname = document.getElementById('surname')

        if (checkSimbol(surname)) {
            surname.style.background = "#29FF0E"
            return true
        } else {
            surname.style.background = "#ff0000"
            return false
        }
    }

    check_user = function () {
        console.log("reg")
        let error = document.getElementById('error_box')
        let login = document.getElementById('login')
        // console.log(login.value)
        if (check_login() & check_password() & check_password_repeat() & check_name() & check_surname()) {

            console.log("OK2")

           select_database()
        } else {
            error.style.visibility = 'hidden'

        }

    }
}

select_database = function () {
    let login = document.getElementById('login')
    let password = document.getElementById('password')
    let name = document.getElementById('name')
    let surname = document.getElementById('surname')
    let error = document.getElementById('error_box')
    console.log("select")
    let xmlhttp = getXmlHttp()
    xmlhttp.open('POST', '/api', true)
    xmlhttp.setRequestHeader('Content-Type', 'application/json')
    xmlhttp.send(JSON.stringify({
        "login": login.value, "password": password.value,
        "name": name.value,
        "surname": surname.value,
        "api_method": "select_database"
    }))
    xmlhttp.onreadystatechange = function () {
        if (xmlhttp.readyState == 4) {
            if (xmlhttp.status == 200) {
                let answer = JSON.parse(xmlhttp.responseText)

                if (answer['state'] == true) {
                    console.log(answer)
                    set_cookie('login_key', answer['loginKey'])
                    error.value = ""
                    window.location = "/"

                } else {
                    login.style.background = "#ff0000"
                    error.value = answer["loginKey"]
                }
            }
        }
    }

}