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



function getHashItem() {
    var hash = location.hash.substr(1);
    var result = {};
    hash.split('&').forEach(function (part) {
        var item = part.split('=');
        result[item[0]] = decodeURIComponent(item[1]);
    });

    return result.item ? result.item.split('.') : ['bos homework', 'cell'];
};




class App extends Component {

    state = {
        code: property(getHashItem())(sampleShaders),
        error: null
    };

    componentDidMount() {
        window.addEventListener('hashchange', () => {
            this.setState({
                code: property(getHashItem())(sampleShaders)
            })
        })
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
        location.hash = 'item=' + key.replace('/', '.');
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