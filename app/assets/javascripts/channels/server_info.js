App.server_info = App.cable.subscriptions.create("ServerInfoChannel", {
  connected: function() {
    // Called when the subscription is ready for use on the server
    console.log("Connected to ServerInfoChannel")
    //error = function(e) { console.log("Still Disconnected from ServerInfoChannel") }
    os = $('#online_status')
    os.html('(ONLINE)')
    os.removeClass("text-danger").addClass("text-body")
  },

  disconnected: function() {
    // Called when the subscription has been terminated by the server
      console.log("Disconnected from ServerInfoChannel")
      os = $('#online_status')
      os.html('(OFFLINE)')
      os.removeClass("text-body").addClass("text-danger")
  },

  received: function(data) {
    // Called when there's incoming data on the websocket for this channel
    $('#server_message').html(data.message)
  }
});
