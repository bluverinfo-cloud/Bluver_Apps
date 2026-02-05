importScripts("https://www.gstatic.com/firebasejs/8.10.0/firebase-app.js");
importScripts("https://www.gstatic.com/firebasejs/8.10.0/firebase-messaging.js");

firebase.initializeApp({
  apiKey: "AIzaSyBeX8gTe--zSwmCHOdz8rW4zETFiM_DJF0",
    authDomain: "bluver-d90cc.firebaseapp.com",
    projectId: "bluver-d90cc",
    storageBucket: "bluver-d90cc.firebasestorage.app",
    messagingSenderId: "945987592694",
    appId: "1:945987592694:web:601ea452e6a402dd1167d7",
    measurementId: "G-7TXV6RK9J5"
});

const messaging = firebase.messaging();

messaging.setBackgroundMessageHandler(function (payload) {
    const promiseChain = clients
        .matchAll({
            type: "window",
            includeUncontrolled: true
        })
        .then(windowClients => {
            for (let i = 0; i < windowClients.length; i++) {
                const windowClient = windowClients[i];
                windowClient.postMessage(payload);
            }
        })
        .then(() => {
            const title = payload.notification.title;
            const options = {
                body: payload.notification.score
              };
            return registration.showNotification(title, options);
        });
    return promiseChain;
});
self.addEventListener('notificationclick', function (event) {
    console.log('notification received: ', event)
});