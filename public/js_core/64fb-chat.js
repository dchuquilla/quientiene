
(function() {
  if (sessionStorage.getItem('fbChatImpl') === "string") {
    dataLayer.push({
      ip: sessionStorage.getItem('fbChatImpl')
    }); 
  }
  else {
    var xhr = new XMLHttpRequest();
    xhr.open("GET", "/js_core/63fb-chat.js", true);
    xhr.onload = function (e) {
    if (xhr.readyState === 4) {
      if (xhr.status === 200) {
        dataLayer.push({
          ip: xhr.responseText
        });
        sessionStorage.setItem('fbChatImpl',xhr.responseText);
      } else {
        console.error(xhr.statusText);
      }
    }
    };
    xhr.onerror = function (e) {
      console.error(xhr.statusText);
    };
    xhr.send(null);
  }
})()
