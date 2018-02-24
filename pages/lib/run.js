import { compile } from 'shader-program-compiler';


export default function (fShader, canvas) {

    function loadImageAsTexture(url, uniform) {
        const image = new Image();
        image.crossOrigin = true;
        image.onload = function () {
            const texture = uniform.createTexture(image);
            uniform.fill(texture);
        }
        image.src = url;
    }

    function loadVideoAsTexture(url, uniform, callback) {

        const video = document.createElement('video');
        video.style.display = 'none';
        video.setAttribute('playsinline', true);
        video.setAttribute('webkit-playsinline', true);
        video.crossOrigin = 'anonymous';

        let playing = false;
        let timeupdate = false;

        video.autoplay = true;
        video.muted = true;
        video.loop = true;

        video.addEventListener('playing', function () {
            if (!playing) {
                playing = true;
                checkReady();
            }
        }, true);
        video.addEventListener('timeupdate', function () {
            if (!timeupdate) {
                timeupdate = true;
                checkReady();
            }
        }, true);

        function checkReady() {
            if (playing && timeupdate) {
                const texture = uniform.createTexture(video);
                uniform.fill(texture);

                callback(function(){
                    uniform.update(texture, video);
                })
            }
        }

        video.src = url;
        video.play();
    }

    const vShader = `
    attribute vec2 aPosition;
    void main() {
      gl_Position = vec4(aPosition, 0, 1);
    }`;

    const gl = canvas.getContext('webgl');

    let offsetX = 0;
    let offsetY = 0;
    canvas.addEventListener('mousemove', function (e) {
        offsetX = e.offsetX;
        offsetY = e.offsetY;
    });

    const { program, attributes, uniforms, fillElements, drawElements, createElementsBuffer } = compile({
        vShader, fShader, gl
    });

    gl.useProgram(program);

    const elementsBuffer = createElementsBuffer([0, 1, 2]);
    fillElements(elementsBuffer);

    const positionBuffer = attributes.aPosition.createBuffer([0, 3, 3, -3, -3, -3]);
    attributes.aPosition.fill(positionBuffer);

    uniforms.uResolution && uniforms.uResolution.fill([canvas.width, canvas.height]);

    let startTime = null;
    let willStop = false;
    function render() {
        if (willStop) {
            return;
        }
        gl.clearColor(0.0, 0.0, 0.0, 1.0);
        gl.clearDepth(1.0);
        gl.clear(gl.COLOR_BUFFER_BIT);

        if (uniforms.uTime) {
            if (!startTime) {
                startTime = Date.now();
            }
            const uTime = ((Date.now() - startTime) / 1000) % 65532;
            uniforms.uTime.fill([uTime]);
        }
        if (uniforms.uMouse) {
            uniforms.uMouse.fill([offsetX, offsetY]);
        }

        if (updateTexture) {
            updateTexture();
        }

        drawElements(3);
        requestAnimationFrame(render);
    }
    render();

    if (uniforms.image0) {
        loadImageAsTexture(
            'https://img.alicdn.com/tfs/TB18RQAaqmWBuNjy1XaXXXCbXXa-512-512.jpg',
            uniforms.image0
        )
    }
    if (uniforms.image1) {
        loadImageAsTexture(
            'https://img.alicdn.com/tfs/TB1cBUAaqmWBuNjy1XaXXXCbXXa-788-788.jpg',
            uniforms.image1
        )
    }

    let updateTexture = null;
    if (uniforms.video0) {
        loadVideoAsTexture(
            'https://mdn.github.io/webgl-examples/tutorial/sample8/Firefox.mp4',
            uniforms.video0,
            function (update) {
                updateTexture = update
            }
        )
    }




    return function stop() {
        willStop = true;
    }
}