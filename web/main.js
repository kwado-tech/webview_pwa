

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
                    // // document.body.height = windowHeight;
                    // window.resizeTo(window.innerWidth, 1000)
                    // console.log('windowHeight-1', windowHeight);
                    document.documentElement.style.height = `initial`;
                    setTimeout(() => {
                        document.documentElement.style.height = '100%';
                        setTimeout(() => {
                            console.log('REFRESH HAPPENED - 1!!!');
                            // this line prevents the content
                            // from hiding behind the address bar
                            window.scrollTo(0, 1);
                        }, 500);
                    }, 500);
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