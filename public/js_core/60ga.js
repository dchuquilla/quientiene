
(function() {
  if (sessionStorage.getItem('gaTagManager') === "string") {
    dataLayer.push({
      GtM: sessionStorage.getItem('gaTagManager')
    }); 
  }
  else {
    var xhr = new XMLHttpRequest();
    xhr.open("GET", "https://www.googletagmanager.com/gtag/js?id=G-0HKQTSW8VY", true);
    xhr.onload = function (e) {
    if (xhr.readyState === 4) {
      if (xhr.status === 200) {
        dataLayer.push({
          GtM: xhr.responseText
        });
        sessionStorage.setItem('gaTagManager',xhr.responseText);
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
