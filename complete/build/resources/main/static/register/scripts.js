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
        let login1 = document.getElementById('login1')


        if (onlyLettersAndDigits(login) & notNull(login) & countSimbol(login)) {
            login1.style.color = "#b0fda6"
            return true
        } else {
            login1.style.color = "#F58F8F"
            return false
        }

    }
    check_password = function () {
        let password = document.getElementById('password')
        let password1 = document.getElementById('password1')
        // console.log("======pass===============")
        // console.log(onlyLettersAndDigits(password))
        // console.log(notNull(password))
        // console.log(countSimbol(password))
        // console.log(includeDigits(password))
        if (onlyLettersAndDigits(password) & notNull(password) & countSimbol(password) & includeDigits(password)) {
            password1.style.color = "#B0FDA6"
            return true
        } else {
            password1.style.color = "#f58f8f"
            return false
        }
    }
    check_password_repeat = function () {
        let password = document.getElementById('password')
        let password_repeat = document.getElementById('password_repeat')
        let password_repeat1 = document.getElementById('password_repeat1')

        if (password.value == password_repeat.value) {
            password_repeat1.style.color = "#B0FDA6"
            return true
        } else {
            password_repeat1.style.color = "#F58F8F"
            return false
        }

    }
    check_name = function () {
        let name = document.getElementById('name')
        let name1 = document.getElementById('name1')

        if (checkSimbol(name)) {
            name1.style.color = "#B0FDA6"
            return true
        } else {
            name1.style.color = "#F58F8F"
            return false
        }
    }
    check_surname = function () {
        let surname = document.getElementById('surname')
        let surname1 = document.getElementById('surname1')

        if (checkSimbol(surname)) {
            surname1.style.color = "#B0FDA6"
            return true
        } else {
            surname1.style.color = "#F58F8F"
            return false
        }
    }

    check_user = function () {
        console.log("reg")
        let error = document.getElementById('error_box')
        let login = document.getElementById('login')
        // console.log(login.value)
        console.log(check_login())
        console.log(check_password())
        console.log(check_password_repeat())
        console.log(check_name())
        console.log(check_surname())
        if (check_login() & check_password() & check_password_repeat() & check_name() & check_surname()) {

            console.log("OK2")

           select_database()
        } else {
            error.style.visibility = 'visible'

        }

    }
}

select_database = function () {
    let login = document.getElementById('login')
    let login1 = document.getElementById('login1')
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
                    login1.style.color = "#F58F8F"
                    error.value = answer["loginKey"]
                    console.log(answer["loginKey"])
                }
            }
        }
    }

}