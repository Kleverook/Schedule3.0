function getXmlHttp() {
    var xmlhttp;
    try {
        xmlhttp = new ActiveXObject("Msxml2.XMLHTTP");
    } catch (e) {
        try {
            xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
        } catch (e) {
            xmlhttp = false;
        }
    }
    ;
    if (!xmlhttp && typeof XMLHttpRequest != 'undefined') {
        xmlhttp = new XMLHttpRequest();
    }
    ;
    return xmlhttp;
};

function set_cookie ( name, value, exp_y, exp_m, exp_d, path, domain, secure )
{
    var cookie_string = name + "=" + escape ( value );

    if ( exp_y )
    {
        var expires = new Date ( exp_y, exp_m, exp_d );
        cookie_string += "; expires=" + expires.toGMTString();
    }

    if ( path )
        cookie_string += "; path=" + escape ( path );

    if ( domain )
        cookie_string += "; domain=" + escape ( domain );

    if ( secure )
        cookie_string += "; secure";

    document.cookie = cookie_string;
}

function get_cookie ( cookie_name )
{
    var results = document.cookie.match ( '(^|;) ?' + cookie_name + '=([^;]*)(;|$)' );

    if ( results )
        return ( unescape ( results[2] ) );
    else
        return null;
}

function delete_cookie ( cookie_name )
{
    var cookie_date = new Date ( );  // Текущая дата и время
    cookie_date.setTime ( cookie_date.getTime() - 1 );
    document.cookie = cookie_name += "=; expires=" + cookie_date.toGMTString();
    window.location = "/"
}

// function check_task() {
//     var xmlhttp = getXmlHttp();
//     xmlhttp.open('POST', '/', true);
//     xmlhttp.setRequestHeader('Content-Type', 'application/json');
//     xmlhttp.send(JSON.stringify({"command": "check_task"}));
//     xmlhttp.onreadystatechange = function () {
//         if (xmlhttp.readyState == 4) {
//             if (xmlhttp.status == 200) {
//                 var dict = JSON.parse(xmlhttp.responseText);
//                 for (var key in dict) {
//                     var elem = document.querySelector('tr[id="' + key + '"] td:nth-of-type(3)');
//                     if (elem.querySelector(".overlay-loader")) {
//                         elem.querySelector(".overlay-loader").remove();
//                     }
//                     elem.innerHTML = dict[key][0];
//                 }
//                 ;
//             }
//             ;
//         }
//         ;
//     };
//     if (document.querySelectorAll('table div[class="overlay-loader"]').length) {
//         setTimeout(check_task, 1 * 1000);
//     }
//     ;
// };