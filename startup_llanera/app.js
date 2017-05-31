function login() {
    console.log("hello");
    $.ajax({
        url: 'http://127.0.0.1:5000/login/',
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify({
            'email': $("#email").val(),
            'password': $("#password").val()
        }),
        type: "POST",
        dataType: "json",
        success: function (resp) {
            if (resp.status == 'ok') {
                window.location.replace('diner.html');
            } else if (resp.status == 'error') {
                window.location.replace('/texts/404.html');
            }

        },
        error: function (resp) {
            window.location.replace('/texts/404.html');
        }
    });