import React, { Component } from 'react';
import { render } from 'react-dom';

import { debounce } from 'lodash';

import Layout from './components/layout';
import Screen from './components/screen';
import Info from './components/info';
import CodeEditor from './components/code-editor';
import Menu from './components/menu';

import './index.less';

import sampleShaders from './shaders/index';

class App extends Component {

    state = {
        code: sampleShaders.cell,
        error: null
    };

    componentDidMount() {

    }

    onCodeChange = debounce((code) => {
        this.setState({ code });
    }, 500);

    onCodeError = error => {
        if (error) {
            this.setState({
                error
            })
        } else {
            this.setState({
                error: null
            })
        }
    }

    onClickMenu = key => {
        if(key.startsWith('SAMPLE-')){
            const [,name] = key.split('-');
            this.setState({code: sampleShaders[name]});
        }
    }

    render() {

        return (
            <Layout>
                <Menu onClick={this.onClickMenu} sampleShaders={Object.keys(sampleShaders)}/>
                <Screen shaderSource={this.state.code} onError={this.onCodeError} />
                <Info error={this.state.error} />
                <CodeEditor code={this.state.code} onCodeChange={this.onCodeChange} />
            </Layout>
        )
    }
}

render(<App />, document.getElementById('root'));