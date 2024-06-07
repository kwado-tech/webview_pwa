

const init = () => {
    const getWindowInnerHeight = () => {
        return window.innerHeight;
    }

    function openAndResizeWindow() {
        // Open a new window
        const newWindow = window.open('', '', 'width=800,height=600');
        if (newWindow) {
            // Resize the new window
            newWindow.resizeTo(newWindow.innerWidth, 1000);
            newWindow.document.write('<p>This window has been resized.</p>');
        } else {
            alert('Failed to open new window. Please allow pop-ups.');
        }
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
                    // location.reload();
                    // // document.body.height = windowHeight;
                    // window.resizeTo(window.innerWidth, 1000)
                    // console.log('windowHeight-1', windowHeight);
                    // document.documentElement.style.height = `initial`;
                    // setTimeout(() => {
                    //     document.documentElement.style.height = '100%';
                    //     setTimeout(() => {
                    //         console.log('REFRESH HAPPENED - 1!!!');
                    //         // this line prevents the content
                    //         // from hiding behind the address bar
                    //         window.scrollTo(0, 1);
                    //         window.resizeTo(window.innerWidth, 1000);
                    //         openAndResizeWindow();
                    //     }, 500);
                    // }, 500);
                }
            };

        // function reportWindowSize() {
        //     console.log('resize', window.innerHeight, window.innerWidth);
        // }

        // window.onresize = reportWindowSize;
        document.addEventListener("visibilitychange", visibilityChangeListener);

        return visibilityChangeListener;
    }

    window._getWindowInnerHeight = getWindowInnerHeight;
    window._addResizeOnVisibilityChangeEventListener = addResizeOnVisibilityChangeEventListener;
}

window.onload = () => {
    init();
}