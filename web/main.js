

const init = () => {
    const getWindowInnerHeight = () => {
        return window.innerHeight;
    }

    const addResizeOnVisibilityChangeEventListener = (windowHeight) => {
        console.log('windowHeight', windowHeight);
        console.log('document.body.height', document.body.height);

        const visibilityChangeListener =
            () => {
                // const matcher = new RegExp(pattern);
                // const isValidMatch = matcher.test(location.pathname);
                const isHomePath = '/home' || '/';

                if (document.visibilityState === 'visible' && isHomePath) {
                    console.log('REFRESH HAPPENED!!!');
                    // document.body.height = windowHeight;
                    window.resizeTo(window.innerWidth, windowHeight)
                    console.log('windowHeight', windowHeight);
                }
            };

        document.addEventListener("visibilitychange", visibilityChangeListener);

        return visibilityChangeListener;
    }

    window._getWindowInnerHeight = getWindowInnerHeight;
    window._addResizeOnVisibilityChangeEventListener = addResizeOnVisibilityChangeEventListener;
}

window.onload = () => {
    init();
}