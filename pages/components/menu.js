import React, { PropTypes, Component } from 'react';
import { Menu, Icon, Modal, Button } from 'antd';

const SubMenu = Menu.SubMenu;
const MenuItemGroup = Menu.ItemGroup;

class AppMenu extends Component {

    static propTypes = {};

    state = {
        showingReference: false,
        showingAbout: false,
        showingNewDialog: false
    };

    componentDidMount() { }

    onClickMenuItem = data => {
        switch (data.key) {
            case 'reference':
                this.setState({ showingReference: true });
                break;
            case 'about':
                this.setState({ showingAbout: true });
                break;
            default:
                this.props.onClick(data.key);
        }
    }

    onCloseMenu = () => {
        this.setState({
            showingReference: false,
            showingAbout: false,
            showingNewDialog: false
        })
    }

    render() {

        return (
            <div>
                <Menu
                    onClick={this.onClickMenuItem}
                    mode="horizontal"
                >
                    <Menu.Item key="about"><Icon type="setting" />About</Menu.Item>                
                    <SubMenu title={<span><Icon type="setting" />Storage</span>}>
                        <Menu.Item disabled key="setting:2">New Shader</Menu.Item>
                        <SubMenu title={'Load Shaders'}>
                        </SubMenu>
                        <SubMenu title={'Sample Shaders'}>
                            {
                                this.props.sampleShaders.map(name => {
                                    return <Menu.Item key={`SAMPLE-${name}`}>{name}</Menu.Item>
                                })
                            }
                        </SubMenu>
                        <Menu.Item disabled key="save">Save Shader</Menu.Item>
                    </SubMenu>
                    <Menu.Item key="reference"><Icon type="setting" />Reference</Menu.Item>

                </Menu>

                <Modal
                    visible={this.state.showingReference}
                    title="References"
                    onOk={this.onCloseMenu}
                    onCancel={this.onCloseMenu}
                    footer={[
                        <Button key="submit" onClick={this.onCloseMenu}>
                            Close
                        </Button>
                    ]}
                    width={800}
                >
                    <h3>Attributes:</h3>
                    <div></div>
                    <h3>Uniforms:</h3>
                    <div></div>
                </Modal>

                <Modal
                    visible={this.state.showingAbout}
                    title="About"
                    onOk={this.onCloseMenu}
                    onCancel={this.onCloseMenu}
                    footer={[
                        <Button key="submit" onClick={this.onCloseMenu}>
                            Close
                        </Button>
                    ]}
                    width={800}
                >
                    <div>
                        <p>The project on github is <a target="_blank" href="https://github.com/xieguanglei/tiny-shadertoy">tiny shadertoy</a>.</p>
                        <p>And thanks to <a target="_blank" href="https://thebookofshaders.com/">The Book of Shaders</a> and <a target="_blank" href="http://shadertoy.com/">Shadertoy</a> for inspiration.</p>
                    </div>
                </Modal>

                <Modal
                    visible={this.state.showingNewDialog}
                    title="Create Shader"
                    onOk={this.onCloseMenu}
                    onCancel={this.onCloseMenu}
                    footer={[
                        <Button key="submit" onClick={this.onCloseMenu}>
                            Close
                        </Button>
                    ]}
                    width={800}
                >
                    <div>


                    </div>
                </Modal>

            </div>
        )
    }
}

export default AppMenu;