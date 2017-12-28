import React, { PropTypes, Component } from 'react';
import { Menu, Icon } from 'antd';


const SubMenu = Menu.SubMenu;
const MenuItemGroup = Menu.ItemGroup;

class AppMenu extends Component {

    static propTypes = {};

    state = {};

    componentDidMount() { }

    render() {
        return (
            <div>
                <Menu
                    onClick={this.handleClick}
                    selectedKeys={[this.state.current]}
                    mode="horizontal"
                >
                    <SubMenu title={<span><Icon type="setting" />Storage</span>}>
                        <Menu.Item disabled key="setting:1">New Shader</Menu.Item>
                        <Menu.Item disabled key="setting:2">Restore</Menu.Item>
                        <Menu.Item disabled key="setting:3">Save</Menu.Item>
                    </SubMenu>
                </Menu>
            </div>
        )
    }
}

export default AppMenu;