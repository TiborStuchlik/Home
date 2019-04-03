App.server_info = App.cable.subscriptions.create("ServerInfoChannel", {
  connected: function() {
    // Called when the subscription is ready for use on the server
    console.log("connected")
  },

  disconnected: function() {
    // Called when the subscription has been terminated by the server
  },

  message: function() {

      console.log("ping")
  },

  received: function(data) {
    // Called when there's incoming data on the websocket for this channel
    $('#server_message').html(data.message)
  }
});
