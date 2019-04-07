// By Tiba

//= require rails-ujs
//= require jquery
// require activestorage
// require turbolinks
//= require_directory .
// require_directory /config
// require_tree ./channels


// request permission on page load
document.addEventListener('DOMContentLoaded', function () {
    if (!Notification) {
        alert('Desktop notifications not available in your browser. Try Chromium.');
        return;
    }

    if (Notification.permission !== "granted")
        Notification.requestPermission();
});

function testNotify() {
    console.log("test notify")
    notifyMe( "test", "<a href='https://www.google.cz'>pokus na google</a>")
}

function notifyMe(title,message) {
    if (Notification.permission !== "granted")
        Notification.requestPermission();
    else {
        var notification = new Notification(title, {
            icon: 'https://cdn.sstatic.net/stackexchange/img/logos/so/so-icon.png',
            body: message,
        });

        notification.onclick = function () {
            window.open("https://www.google.cz");
        };

    }

}
