import { compile } from './compile-shader';

export default function (fShader, canvas) {

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

        drawElements(3);
        requestAnimationFrame(render);
    }
    render();

    return function stop() {
        willStop = true;
    }
}