window.onload = function () {
    console.log(get_cookie("login_key"))
    if (get_cookie('login_key') == null) {
        console.log(get_cookie("login_key"))
        window.location = "/login"
    }

    function createDiv(className, value, id) {
        var input = document.createElement('input')
        input.type = 'button'
        input.className = className
        input.style.width = '100px'
        input.style.height = '50px'
        input.style.backgroundColor = 'blue'
        input.value = value
        input.id = id
        return input;
    }


    get_division = function () {
        console.log("get_division")
        let modal_body = document.getElementById('modal')
        let xmlhttp = getXmlHttp()
        xmlhttp.open('POST', '/api', true)
        xmlhttp.setRequestHeader('Content-Type', 'application/json')

        xmlhttp.send(JSON.stringify({"api_method": "get_division"}))
        xmlhttp.onreadystatechange = function () {
            if (xmlhttp.readyState == 4) {
                if (xmlhttp.status == 200) {
                    let answer = JSON.parse(xmlhttp.responseText)
                    console.log(answer[0]["idDivision"])
                    for (var i = 0; i < answer.length; i++) {
                        modal_body.appendChild(createDiv('division', answer[i]['shortTitle'], answer[i]['idDivision']));
                    }

                }
            }
        }
    }
    var modal = document.getElementById('myModal');
    var btn = document.getElementById("myBtn");
    var span = document.getElementsByClassName("close")[0];
    btn.onclick = function () {
        get_division()
        modal.style.display = "block";
    }
    span.onclick = function () {
        modal.style.display = "none";
    }
    window.onclick = function (event) {
        if (event.target == modal) {
            modal.style.display = "none";
        }
    }


}