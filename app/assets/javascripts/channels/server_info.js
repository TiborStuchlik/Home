// ServerInfoChannel

/*App.server_info = App.cable.subscriptions.create({ channel: "ServerInfoChannel", stream_type: "public"}, {
  connected: function() {
    console.log("Connected to Public ServerInfoChannel")
  },

  disconnected: function() {
      console.log("disconnected public")
  },

  received: function(data) {
  }
});*/

App.server_info_private = App.cable.subscriptions.create({ channel: "ServerInfoChannel", stream_type: "private"}, {
    connected: function() {
        // Called when the subscription is ready for use on the server
        console.log("Connected to Private ServerInfoChannel")
        //error = function(e) { console.log("Still Disconnected from ServerInfoChannel") }
/*        App.cable.connection.monitor.recordPing = function() {
            App.cable.connection.monitor.pingedAt = new Date().getTime()
            console.log("mam ping")
        }*/
        os = $('#online_status')
        os.removeClass("text-danger").addClass("fa-spin")
        //App.users.all()
        //App.users.aliveStart()
    },

    disconnected: function() {
        // Called when the subscription has been terminated by the server
        console.log("Disconnected from Private ServerInfoChannel")
        os = $('#online_status')
        os.removeClass("fa-spin").addClass("text-danger")
        //App.users.aliveStop()
    },

    alive: function(data) {
        this.perform("alive", data)
    },

    received: function(data) {
        // Called when there's incoming data on the websocket for this channel
        $('#server_message').html(data.message)
        if (data.type == "expire") {
            notifyMe("Session Expired", data.message)
            App.server_info_private.unsubscribe()
            App.server_info_private.disconnected()
        }
    }
});