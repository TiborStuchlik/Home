App.users = {
    all: function() {
        $.ajax("/users/list").done(
            function(data) {
                $('#users_container').html(data)
            }
        )
    },

    alive: function() {
        console.log("budu pingat na server")
        App.server_info_private.alive({ pok: "hok"})
    },

    interval: null,

    aliveStop: function() {
        if ( this.interval != null ) {
            clearInterval(this.interval)
        }
    },

    aliveStart: function() {
        this.aliveStop()
        this.interval = setInterval( this.alive,3000)
    }
}