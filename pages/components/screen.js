import React, { PropTypes, Component } from 'react';

import run from '../lib/run';

class Screen extends Component {

    static propTypes = {};

    state = {};

    componentDidMount() {
        this.runShader();
    }

    componentDidUpdate(prevProps) {
        if (prevProps.shaderSource !== this.props.shaderSource) {
            this.stop();
            this.runShader();
        }
    }

    runShader() {
        try {
            this.stop = run(this.props.shaderSource, this.refs.canvas);
            this.props.onError(null);
        }catch(e){
            this.props.onError(e);
        }
    }

    render() {

        const { width, height } = this.props;

        const style = {
            width, height,
            background: '#fff'
        }

        return (
            <div style={{...style}}>
                <canvas ref="canvas" width={width} height={height} style={style} />
            </div>
        )
    }
}

export default Screen;