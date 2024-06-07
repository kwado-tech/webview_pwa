

const init = () => {
    const showAlert = (message) => {
        // alert(message);
        console.log('location.pathname: ', location.pathname);
    }

    window._showAlert = showAlert;
}

window.onload = () => {
    init();
}