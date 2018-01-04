import React, { Component } from 'react';
import { render } from 'react-dom';

import { debounce, property } from 'lodash';

import Layout from './components/layout';
import Screen from './components/screen';
import Info from './components/info';
import CodeEditor from './components/code-editor';
import Menu from './components/menu';

import './index.less';

import sampleShaders from './shaders/index';

class App extends Component {

    state = {
        code: sampleShaders['bos homework']['cell'],
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
        const code = property(key.split('/'))(sampleShaders);
        this.setState({ code });
    }

    render() {

        return (
            <Layout>
                <Menu onClick={this.onClickMenu} sampleShaders={sampleShaders} />
                <Screen shaderSource={this.state.code} onError={this.onCodeError} />
                <Info error={this.state.error} />
                <CodeEditor code={this.state.code} onCodeChange={this.onCodeChange} />
            </Layout>
        )
    }
}

render(<App />, document.getElementById('root'));