

const init = () => {
    const showAlert = (message) => {
        alert(message);
    }

    window._showAlert = showAlert;
}

window.onload = () => {
    init();
}