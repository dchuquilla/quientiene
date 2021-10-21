
(function() {
  if (sessionStorage.getItem('ipAddress') === "string") {
    dataLayer.push({
      ip: sessionStorage.getItem('ipAddress')
    }); 
  }
  else {
    var xhr = new XMLHttpRequest();
    xhr.open("GET", "https://www.googletagmanager.com/gtag/js?id=G-0HKQTSW8VY", true);
    xhr.onload = function (e) {
    if (xhr.readyState === 4) {
      if (xhr.status === 200) {
        dataLayer.push({
          ip: xhr.responseText
        });
        sessionStorage.setItem('ipAddress',xhr.responseText);
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
  
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());

  gtag('config', 'G-0HKQTSW8VY');
})()
